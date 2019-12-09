//
//  JSONEncoding.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/16/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation

public struct JSONEncoding: ParameterEncoding {
    
    public static var `default`: JSONEncoding { return JSONEncoding() }
    
    public static var prettyPrinted: JSONEncoding { return JSONEncoding(options: .prettyPrinted) }
    
    public let options: JSONSerialization.WritingOptions
    
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestProtocol, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
        } catch {
            throw EncodingError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
    
    
    public func encode(_ urlRequest: URLRequestProtocol, withJSONObject jsonObject: Any? = nil) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let jsonObject = jsonObject else { return urlRequest }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
        } catch {
            throw EncodingError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}
