//
//  NetworkRequestFactoryHelper.swift
//  QuickHatch
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

class NetworkRequestFactoryHelper {
    static func checkForRequestError(data: Data?, response: URLResponse?, error: Error?, unauthorizedCode: Int) -> RequestError? {
        guard error == nil || !error!.requestWasCancelled else {
            return RequestError.cancelled
        }
        guard let urlResponse = response as? HTTPURLResponse else {
            return RequestError.noResponse
        }
        guard urlResponse.statusCode != unauthorizedCode else {
            return RequestError.unauthorized
        }
        guard urlResponse.statusCode >= 200 && urlResponse.statusCode <= 201 else {
            var error = RequestError.unknownError(statusCode: urlResponse.statusCode)
            if let httpStatusCode = HTTPStatusCode(rawValue: urlResponse.statusCode) {
                error =  RequestError.requestWithError(statusCode: httpStatusCode)
            }
            return error
        }
        guard data != nil else {
            return RequestError.noResponse
            
        }
        return nil
    }
}
