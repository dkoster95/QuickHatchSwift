//
//  EncodingError.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public enum ParameterEncodingFailureReason {
    case missingURL
    case jsonEncodingFailed(error: Error)
    case propertyListEncodingFailed(error: Error)
}

public enum EncodingError: Error {
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case invalidURL(url: URLConvertible)
}
