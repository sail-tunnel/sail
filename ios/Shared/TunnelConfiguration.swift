//
//  TunnelConfiguration.swift
//  Runner
//
//  Created by Jerry Bool on 2022/12/7.
//

import Foundation

public final class TunnelConfiguration {
    public var name: String?
    
    public var content: String?
    
    public init(name: String?, content: String?) {
        self.name = name
        self.content = content
    }
}

extension TunnelConfiguration: Equatable {
    public static func == (lhs: TunnelConfiguration, rhs: TunnelConfiguration) -> Bool {
        return lhs.name == rhs.name &&
            lhs.name == rhs.name
    }
}
