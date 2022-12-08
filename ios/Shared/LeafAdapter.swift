//
//  LeafAdapter.swift
//  Runner
//
//  Created by Jerry Bool on 2022/12/7.
//

import Foundation
import NetworkExtension
import LeafFFI

public enum LeafAdapterError: Error {
    /// Failure to locate tunnel file descriptor.
    case cannotLocateTunnelFileDescriptor

    /// Failure to perform an operation in such state.
    case invalidState

    /// Failure to set network settings.
    case setNetworkSettings(Error)
    
    /// Failure to set tunnel configuration
    case setTunnelConfiguration(Int32)

    /// Failure to start Leaf FFI.
    case startLeafFFI
}

/// Enum representing internal state of the `LeafAdapter`
private enum State {
    /// The tunnel is stopped
    case stopped

    /// The tunnel is up and running
    case started

    /// The tunnel is temporarily shutdown due to device going offline
    case temporaryShutdown
}

private extension Network.NWPath.Status {
    /// Returns `true` if the path is potentially satisfiable.
    var isSatisfiable: Bool {
        switch self {
        case .requiresConnection, .satisfied:
            return true
        case .unsatisfied:
            return false
        @unknown default:
            return true
        }
    }
}

public class LeafAdapater {
    private static var sharedLeafAdapater: LeafAdapater = {
        return LeafAdapater()
    }()

    public class func shared() -> LeafAdapater {
        return sharedLeafAdapater
    }
    
    /// Leaf instance id
    public static let leafId: UInt16 = 666
    
    /// Network routes monitor.
    private var networkMonitor: NWPathMonitor?

    /// Packet tunnel provider.
    private static weak var packetTunnelProvider: NEPacketTunnelProvider?
    
    /// Private queue used to synchronize access to `LeafAdapter` members.
    private let workQueue = DispatchQueue(label: "LeafAdapterWorkQueue")
    
    /// Adapter state.
    private var state: State = .stopped
    
    var tunnelFd: Int32? {
        var buf = [CChar](repeating: 0, count: Int(IFNAMSIZ))

        for fd: Int32 in 0 ... 1024 {
            var len = socklen_t(buf.count)

            if getsockopt(fd, 2 /* IGMP */, 2, &buf, &len) == 0 && String(cString: buf).hasPrefix("utun") {
                return fd
            }
        }

        return LeafAdapater.packetTunnelProvider?.packetFlow.value(forKey: "socket.fileDescriptor") as? Int32
    }
    
    /// Set PacketTunnelProvider instance
    /// - Parameter packetTunnelProvider: an instance of `NEPacketTunnelProvider`. Internally stored
    ///   as a weak
    public static func setPacketTunnelProvider(with packetTunnelProvider: NEPacketTunnelProvider) {
        LeafAdapater.packetTunnelProvider = packetTunnelProvider
    }
    
    /// Designated initializer.
    public init() {
        
    }
    
    deinit {
        // Cancel network monitor
        networkMonitor?.cancel()

        // Shutdown the tunnel
        if case .started = self.state {
            leaf_shutdown(LeafAdapater.leafId)
        }
    }
    
    public func setRuntimeConfiguration(conf: String?, completionHandler: @escaping (LeafAdapterError?) -> Void) {
        guard let conf = conf else {
            completionHandler(.startLeafFFI)
            return
        }
        
        let file = FileManager.default.leafConfFile

        try! conf.write(to: file!, atomically: true, encoding: .utf8)
        
        setenv("LOG_NO_COLOR", "true", 1)
        
        let result = leaf_test_config(file?.path)
        guard result == 0 else {
            completionHandler(.setTunnelConfiguration(result))
            return
        }
        
        completionHandler(nil)
    }
    
    /// Returns a runtime configuration.
    /// - Parameter completionHandler: completion handler.
    public func getRuntimeConfiguration(completionHandler: @escaping (String?) -> Void) {
        workQueue.async {
            let fm = FileManager.default

            if let conf = fm.leafConfFile?.contents {
                completionHandler(conf)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    /// Start the tunnel tunnel.
    /// - Parameters:
    ///   - tunnelConfiguration: tunnel configuration.
    ///   - completionHandler: completion handler.
    public func start(completionHandler: @escaping (LeafAdapterError?) -> Void) {
        workQueue.async {
            guard case .stopped = self.state else {
                completionHandler(.invalidState)
                return
            }

            let networkMonitor = NWPathMonitor()
            networkMonitor.pathUpdateHandler = { [weak self] path in
                self?.didReceivePathUpdate(path: path)
            }
            networkMonitor.start(queue: self.workQueue)

            let tunFd = self.tunnelFd != nil ? String(self.tunnelFd!) : nil
            
            // Reset log file.
            FileManager.default.leafLogFile?.truncate()

            let fm = FileManager.default
            let file = fm.leafConfFile
            var conf = file?.contents ?? ""
            
            conf = conf
                .replacingOccurrences(of: "{{leafLogFile}}", with: fm.leafLogFile?.path ?? "")
                .replacingOccurrences(of: "{{tunFd}}", with: tunFd ?? "")

            try! conf.write(to: file!, atomically: true, encoding: .utf8)

            setenv("LOG_NO_COLOR", "true", 1)

            leaf_run(LeafAdapater.leafId, file?.path)
            
            self.state = .started
            self.networkMonitor = networkMonitor
            completionHandler(nil)
        }
    }
    
    /// Stop the tunnel.
    /// - Parameter completionHandler: completion handler.
    public func stop(completionHandler: @escaping (LeafAdapterError?) -> Void) {
        workQueue.async {
            switch self.state {
            case .started:
                leaf_shutdown(LeafAdapater.leafId)

            case .temporaryShutdown:
                break

            case .stopped:
                completionHandler(.invalidState)
                return
            }

            self.networkMonitor?.cancel()
            self.networkMonitor = nil

            self.state = .stopped

            completionHandler(nil)
        }
    }

    /// Update runtime configuration.
    /// - Parameters:
    ///   - tunnelConfiguration: tunnel configuration.
    ///   - completionHandler: completion handler.
    public func update(conf: String?, completionHandler: @escaping (LeafAdapterError?) -> Void) {
        workQueue.async {
            if case .stopped = self.state {
                completionHandler(.invalidState)
                return
            }

            // Tell the system that the tunnel is going to reconnect using new configuration.
            // This will broadcast the `NEVPNStatusDidChange` notification to the GUI process.
            LeafAdapater.packetTunnelProvider?.reasserting = true
            defer {
                LeafAdapater.packetTunnelProvider?.reasserting = false
            }

            switch self.state {
            case .started:
                self.setRuntimeConfiguration(conf: conf, completionHandler: completionHandler)
                
                leaf_reload(LeafAdapater.leafId)

                self.state = .started

            case .temporaryShutdown:
                self.state = .temporaryShutdown

            case .stopped:
                fatalError()
            }

            completionHandler(nil)
        }
    }
    
    /// Helper method used by network path monitor.
    /// - Parameter path: new network path
    private func didReceivePathUpdate(path: Network.NWPath) {
        switch self.state {
        case .started:
            if path.status.isSatisfiable {
                
            } else {
                self.state = .temporaryShutdown
                leaf_shutdown(LeafAdapater.leafId)
            }

        case .temporaryShutdown:
            guard path.status.isSatisfiable else { return }
            self.state = .started

        case .stopped:
            // no-op
            break
        }
    }
}
