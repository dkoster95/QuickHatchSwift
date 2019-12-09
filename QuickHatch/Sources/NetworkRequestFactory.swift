//
//  NetworkingLayer.swift
//  FordPass
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2017 Daniel Koster. All rights reserved.
//

import Foundation

public protocol Request {
    func resume()
    func suspend()
    func cancel()
}

public typealias DataCompletionHandler = (Result<Data, Error>) -> Void
public typealias StringCompletionHandler = (Result<String, Error>) -> Void
public typealias AnyCompletionHandler = (Result<Any, Error>) -> Void


public protocol NetworkRequestFactory {
    func log(with logger: Logger) 
    func json(request: URLRequest,dispatchQueue: DispatchQueue, completionHandler completion: @escaping AnyCompletionHandler) -> Request
    func string(request: URLRequest,dispatchQueue: DispatchQueue, completionHandler completion: @escaping StringCompletionHandler) -> Request
    func data(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping DataCompletionHandler) -> Request
}

