//
//  NetworkingLayer.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public typealias DataCompletionHandler = (Result<Response<Data>, Error>) -> Void
public typealias StringCompletionHandler = (Result<Response<String>, Error>) -> Void
public typealias AnyCompletionHandler = (Result<Response<Any>, Error>) -> Void


public protocol NetworkRequestFactory {
    func log(with logger: Logger) 
    func json(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping AnyCompletionHandler) -> Request
    func string(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping StringCompletionHandler) -> Request
    func data(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping DataCompletionHandler) -> Request
}

