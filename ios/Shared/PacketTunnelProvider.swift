import NetworkExtension
import LeafFFI

class PacketTunnelProvider: NEPacketTunnelProvider {
    
    private lazy var adapter: LeafAdapater = {
        LeafAdapater.setPacketTunnelProvider(with: self)
        return LeafAdapater.shared()
    }()

    override func startTunnel(options: [String : NSObject]?, completionHandler: @escaping (Error?) -> Void) {
        let ipv4 = NEIPv4Settings(addresses: ["192.168.20.2"], subnetMasks: ["255.255.255.0"])
        ipv4.includedRoutes = [NEIPv4Route.default()]

        let ipv6 = NEIPv6Settings(addresses: ["FC00::0001"], networkPrefixLengths: [7])
        ipv6.includedRoutes = [NEIPv6Route.default()]

        let dns = NEDNSSettings(servers: ["1.1.1.1"])
        // https://developer.apple.com/forums/thread/116033
        // Mention special Tor domains here, so the OS doesn't drop onion domain
        // resolve requests immediately.
        dns.matchDomains = ["", "onion", "exit"]

        let settings = NEPacketTunnelNetworkSettings(tunnelRemoteAddress: "192.168.20.20")
        settings.ipv4Settings = ipv4
        settings.ipv6Settings = ipv6
        settings.dnsSettings = dns
        settings.proxySettings = nil
        settings.mtu = 1500

        self.adapter.start(completionHandler: completionHandler)
        
        setTunnelNetworkSettings(settings) { error in
            if let error = error {
                return completionHandler(error)
            }

            completionHandler(nil)
        }
    }

    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        self.adapter.stop { error in
            if let error = error {
                Logger.log(error.localizedDescription, to: Logger.vpnLogFile)
            }
            
            completionHandler()
        }
    }

    override func handleAppMessage(_ messageData: Data, completionHandler: ((Data?) -> Void)?) {
        // Add code here to handle the message.
        if let handler = completionHandler {
            handler(messageData)
        }
    }

    override func sleep(completionHandler: @escaping () -> Void) {
        // Add code here to get ready to sleep.
        completionHandler()
    }

    override func wake() {
        // Add code here to wake up.
    }
}
