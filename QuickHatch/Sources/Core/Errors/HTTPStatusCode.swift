//
//  HTTPStatusCode.swift
//  QuickHatch
//
//  Created by Daniel Koster on 3/30/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
/**
 HTTP status codes as per http://en.wikipedia.org/wiki/List_of_HTTP_status_codes
 
 The RF2616 standard is completely covered (http://www.ietf.org/rfc/rfc2616.txt)
 */
public enum HTTPStatusCode: Int {
    // Informational
    case httpContinue = 100
    case switchingProtocols = 101
    case processing = 102
    
    // Success
    case oK = 200
    case created = 201
    case accepted = 202
    case nonAuthoritativeInformation = 203
    case noContent = 204
    case resetContent = 205
    case partialContent = 206
    case multiStatus = 207
    case alreadyReported = 208
    case iMUsed = 226
    
    // Redirections
    case multipleChoices = 300
    case movedPermanently = 301
    case found = 302
    case seeOther = 303
    case notModified = 304
    case useProxy = 305
    case switchProxy = 306
    case temporaryRedirect = 307
    case permanentRedirect = 308
    
    // Client Errors
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case notAcceptable = 406
    case proxyAuthenticationRequired = 407
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case lengthRequired = 411
    case preconditionFailed = 412
    case requestEntityTooLarge = 413
    case requestURITooLong = 414
    case unsupportedMediaType = 415
    case requestedRangeNotSatisfiable = 416
    case expectationFailed = 417
    case imATeapot = 418
    case authenticationTimeout = 419
    case unprocessableEntity = 422
    case locked = 423
    case failedDependency = 424
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests = 429
    case requestHeaderFieldsTooLarge = 431
    case loginTimeout = 440
    case noResponse = 444
    case retryWith = 449
    case unavailableForLegalReasons = 451
    case requestHeaderTooLarge = 494
    case certError = 495
    case noCert = 496
    case hTTPToHTTPS = 497
    case tokenExpired = 498
    case clientClosedRequest = 499

    // Server Errors
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    case gatewayTimeout = 504
    case hTTPVersionNotSupported = 505
    case variantAlsoNegotiates = 506
    case insufficientStorage = 507
    case loopDetected = 508
    case bandwidthLimitExceeded = 509
    case notExtended = 510
    case networkAuthenticationRequired = 511
    case networkTimeoutError = 599
}

extension HTTPStatusCode {
    /// Informational - Request received, continuing process.
    public var isInformational: Bool {
        return self.rawValue >= 100 && self.rawValue <= 199
    }
    /// Success - The action was successfully received, understood, and accepted.
    public var isSuccess: Bool {
        return self.rawValue >= 200 && self.rawValue <= 299
    }
    /// Redirection - Further action must be taken in order to complete the request.
    public var isRedirection: Bool {
        return self.rawValue >= 300 && self.rawValue <= 399
    }
    /// Client Error - The request contains bad syntax or cannot be fulfilled.
    public var isClientError: Bool {
        return self.rawValue >= 400 && self.rawValue <= 499
    }
    /// Server Error - The server failed to fulfill an apparently valid request.
    public var isServerError: Bool {
        return self.rawValue >= 500 && self.rawValue <= 599
    }
    
}

extension HTTPStatusCode {
    /// - returns: a localized string suitable for displaying to users that describes the specified status code.
    public var localizedReasonPhrase: String {
        return HTTPURLResponse.localizedString(forStatusCode: rawValue)
    }
}

// MARK: - Printing

extension HTTPStatusCode: CustomDebugStringConvertible, CustomStringConvertible {
    public var description: String {
        return "\(rawValue) - \(localizedReasonPhrase)"
    }
    public var debugDescription: String {
        return "HTTPStatusCode:\(description)"
    }
}
