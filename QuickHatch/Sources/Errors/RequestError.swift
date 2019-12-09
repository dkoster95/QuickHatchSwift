//
//  RequestError.swift
//  iDeate
//
//  Created by Daniel Koster on 3/30/17.
//  Copyright © 2017 Daniel Koster. All rights reserved.
//

import Foundation

public enum RequestError: Error, Equatable {
    
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorized, .unauthorized): return true
        case (.serializationError, .serializationError): return true
        case (.noInternetConnection, .noInternetConnection): return true
        case (.unknownError(let statusCodeA), .unknownError(let statusCodeB)): return statusCodeA == statusCodeB
        case (.cancelled, .cancelled): return true
        case (.noResponse, .noResponse):return true
        case (.requestWithError(let statusCodeA), .requestWithError(let statusCodeB)):
            return statusCodeA.rawValue == statusCodeB.rawValue
        default: return false
        }
    }
    
    case unauthorized
    case unknownError(statusCode: Int)
    case cancelled
    case noResponse
    case requestWithError(statusCode:HTTPStatusCode)
    case serializationError
    case invalidParameters
    case noInternetConnection
    case malformedRequest
}
