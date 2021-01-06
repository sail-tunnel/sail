import Foundation
import NetworkExtension

extension NEVPNStatus: CustomStringConvertible {
    public var description: String {
        switch self {
        case .disconnected: return "Disconnected"
        case .invalid: return "Invalid"
        case .connected: return "Connected"
        case .connecting: return "Connecting"
        case .disconnecting: return "Disconnecting"
        case .reasserting: return "Reasserting"
        }
    }
}

public class VPNManager {
    public var manager = NEVPNManager.shared()
    
    private static var sharedVPNManager: VPNManager = {
        return VPNManager()
    }()
    
    public class func shared() -> VPNManager {
        return sharedVPNManager
    }
    
    public init() {}
    
    public func loadVPNPreference(completion: @escaping (Error?) -> Void) {
        NETunnelProviderManager.loadAllFromPreferences() { managers, error in
            guard let managers = managers, error == nil else {
                completion(error)
                return
            }
            
            if managers.count == 0 {
                let newManager = NETunnelProviderManager()
                newManager.protocolConfiguration = NETunnelProviderProtocol()
                newManager.localizedDescription = "iLeaf"
                newManager.protocolConfiguration?.serverAddress = "iLeaf"
                newManager.saveToPreferences { error in
                    guard error == nil else {
                        completion(error)
                        return
                    }
                    newManager.loadFromPreferences { error in
                        self.manager = newManager
                        completion(nil)
                    }
                }
            } else {
                self.manager = managers[0]
                completion(nil)
            }
        }
    }
    
    public func enableVPNManager(completion: @escaping (Error?) -> Void) {
        manager.isEnabled = true
        manager.saveToPreferences { error in
            guard error == nil else {
                completion(error)
                return
            }
            self.manager.loadFromPreferences { error in
                completion(error)
            }
        }
    }
    
    public func toggleVPNConnection(completion: @escaping (Error?) -> Void) {
        if self.manager.connection.status == .disconnected || self.manager.connection.status == .invalid {
            do {
                try self.manager.connection.startVPNTunnel()
            } catch {
                completion(error)
            }
        } else {
            self.manager.connection.stopVPNTunnel()
        }
    }
}
