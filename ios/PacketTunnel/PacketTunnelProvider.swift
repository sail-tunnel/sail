import NetworkExtension

var conf = """
[General]
loglevel = trace
dns-server = 223.5.5.5, 114.114.114.114
tun-fd = {{tunFd}}
routing-domain-resolve = true

[Proxy]
Direct = direct

[Rule]
EXTERNAL, site:cn, Direct
FINAL, Direct
"""

class PacketTunnelProvider: NEPacketTunnelProvider {

    private static let leafId: UInt16 = 666

    var tunnelFd: Int32? {
        var buf = [CChar](repeating: 0, count: Int(IFNAMSIZ))

        for fd: Int32 in 0 ... 1024 {
            var len = socklen_t(buf.count)

            if getsockopt(fd, 2 /* IGMP */, 2, &buf, &len) == 0 && String(cString: buf).hasPrefix("utun") {
                return fd
            }
        }

        return packetFlow.value(forKey: "socket.fileDescriptor") as? Int32
    }

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

        setTunnelNetworkSettings(settings) { error in
            if let error = error {
                return completionHandler(error)
            }

            DispatchQueue.global(qos: .userInteractive).async {
                signal(SIGPIPE, SIG_IGN)

                let tunFd = self.tunnelFd != nil ? String(self.tunnelFd!) : nil

                conf = conf
                    .replacingOccurrences(of: "{{tunFd}}", with: tunFd ?? "")

                leaf_run_with_config_string(PacketTunnelProvider.leafId, conf)
            }
            completionHandler(nil)
        }
    }

    override func stopTunnel(with reason: NEProviderStopReason, completionHandler: @escaping () -> Void) {
        leaf_shutdown(PacketTunnelProvider.leafId)
        // Add code here to start the process of stopping the tunnel.
        completionHandler()
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
