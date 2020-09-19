//
//  NetworkEnvironment.swift
//  QuickHatch
//
//  Created by QuickHatch on 05/03/2019.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol HostEnvironment {
    var baseURL: String { get }
    var headers: [String: String] { get }
}

public class GenericHostEnvironment: HostEnvironment {
    public var headers: [String: String]
    public var baseURL: String
    
    public init(headers: [String: String], baseURL: String) {
        self.headers = headers
        self.baseURL = baseURL
    }
}
