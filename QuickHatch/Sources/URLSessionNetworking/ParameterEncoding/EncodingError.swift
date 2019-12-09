//
//  EncodingError.swift
//  FordPass
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2017 Daniel Koster. All rights reserved.
//

import Foundation


public enum ParameterEncodingFailureReason {
    case missingURL
    case jsonEncodingFailed(error: Error)
    case propertyListEncodingFailed(error: Error)
}

public enum EncodingError : Error {
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case invalidURL(url: URLConvertible)
}
