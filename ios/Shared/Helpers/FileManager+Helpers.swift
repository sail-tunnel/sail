//
//  FileManager+Helpers.swift
//  PacketTunnel
//
//  Created by Jerry Bool on 2022/12/6.
//

import Foundation

extension FileManager {
    static var appGroupId = "group.com.sail-tunnel.sail"
    
    private var sharedFolderURL: URL? {
        let appGroupId = FileManager.appGroupId
        guard let sharedFolderURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupId) else {
            Logger.log("Cannot obtain shared folder URL", to: Logger.vpnLogFile)
            return nil
        }
        return sharedFolderURL
    }

    var vpnLogFile: URL? {
        sharedFolderURL?.appendingPathComponent("log")
    }

    var leafLogFile: URL? {
        sharedFolderURL?.appendingPathComponent("leaf.log")
    }

    var leafConfFile: URL? {
        sharedFolderURL?.appendingPathComponent("leaf.conf")
    }

    var leafConfTemplateFile: URL? {
        Bundle.main.url(forResource: "template", withExtension: "conf")
    }
}
