//
//  RequestError.swift
//  QuickHatch
//
//  Created by Daniel Koster on 3/30/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public enum RequestPollingError: Error {
    case attemptsOverflow
}

public enum ImageError: Error {
    case malformedError
}

public enum RequestError: Error, Equatable {
    
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorized, .unauthorized): return true
        case (.serializationError, .serializationError): return true
        case (.unknownError(let statusCodeA), .unknownError(let statusCodeB)): return statusCodeA == statusCodeB
        case (.cancelled, .cancelled): return true
        case (.noResponse, .noResponse):return true
        case (.requestWithError(let statusCodeA), .requestWithError(let statusCodeB)):
            return statusCodeA.rawValue == statusCodeB.rawValue
        case (.invalidParameters, .invalidParameters): return true
        case (.malformedRequest, .malformedRequest): return true
        case (.other, .other): return true
        default: return false
        }
    }
    
    public static func map(error: Error) -> RequestError {
        if error.requestWasCancelled { return .cancelled }
        return (error as? RequestError) ?? .other(error: error)
    }
    
    case unauthorized
    case unknownError(statusCode: Int)
    case cancelled
    case noResponse
    case requestWithError(statusCode: HTTPStatusCode)
    case serializationError(error: Error)
    case invalidParameters
    case malformedRequest
    case other(error: Error)
}
