//
//  EnvironmentFactory.swift
//  Watch
//
//  Created by fordpass on 01/04/2019.
//  Copyright © 2019 Ford Motor Company. All rights reserved.
//

import Foundation



public protocol ServerEnvironmentConfiguration: Any {
    var headers: [String: String] { get }
    var qa: HostEnvironment { get }
    var staging: HostEnvironment { get }
    var production: HostEnvironment { get }
}


public enum Environment: String {
    case qa = "QA"
    case staging = "Staging"
    case production = "Prod"
    
    public func getCurrentEnvironment(server: ServerEnvironmentConfiguration) -> HostEnvironment {
        switch self {
        case .qa:
            return server.qa
        case .staging:
            return server.staging
        case .production:
            return server.production
        }
    }
}
