//
//  ParameterEncoding.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public typealias Parameters = [String: Any]

public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestProtocol, with parameters: Parameters?) throws -> URLRequest
}

public enum ParamDestination {
    case methodDependent
    case queryString
    case httpBody
}

public extension NSNumber {
    var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

public extension Bool {
    var stringValue: String {
        return self ? "true" : "false"
    }
    var intValue: Int {
        return self ? 1 : 0
    }
}
