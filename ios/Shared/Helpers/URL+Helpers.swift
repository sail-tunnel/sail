//
//  URL+Helpers.swift
//  PacketTunnel
//
//  Created by Jerry Bool on 2022/12/6.
//

import Foundation

extension URL {
    
    var contents: String? {
        guard self.isFileURL else {
            return nil
        }

        do {
            return try String(contentsOf: self)
        }
        catch {
            Logger.log(error.localizedDescription, to: Logger.vpnLogFile)

            return nil
        }
    }

    @discardableResult
    func truncate() -> Self {
        if isFileURL {
            try? "".write(to: self, atomically: true, encoding: .utf8)
        }

        return self
    }
}
