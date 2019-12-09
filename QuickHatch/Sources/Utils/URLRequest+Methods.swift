//
//  URLRequest+Methods.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation

public extension URLRequest {
    
    static func get(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .get)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
    
    static func post(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .post)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                         headers: headers,
                                         encoding: encoding)
    }
    
    static func put(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .put)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
    
    static func delete(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .delete)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
    
    static func patch(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .patch)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
    
    static func connect(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .connect)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
    
    static func head(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .head)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
    
    static func trace(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .trace)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
    
    static func options(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest {
        var urlRequest =  URLRequest(url: url, method: .options)
        return try urlRequest.configureParamsAndHeaders(params: params,
                                                        headers: headers,
                                                        encoding: encoding)
    }
}

private extension URLRequest {
    
    mutating func configureParamsAndHeaders(params: [String: Any], headers: [String: String], encoding: ParameterEncoding) throws -> URLRequest {
        headers.forEach({ (key, value) in
            self.addHeader(value: value, key: key)
        })
        return try encoding.encode(self, with: params)
    }
    
}
