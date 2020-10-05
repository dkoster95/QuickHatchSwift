//
//  NetworkingLayer.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import Combine

public typealias DataCompletionHandler = (Result<Response<Data>, Error>) -> Void
public typealias StringCompletionHandler = (Result<Response<String>, Error>) -> Void
public typealias AnyCompletionHandler = (Result<Response<Any>, Error>) -> Void

public protocol NetworkRequestFactory {
    func data(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping DataCompletionHandler) -> Request

    @available(tvOS 13.0, *)
    @available(watchOSApplicationExtension 6.0, *)
    @available(OSX 10.15, *)
    @available(iOS 13.0, *)
    func data(request: URLRequest, dispatchQueue: DispatchQueue) -> AnyPublisher<Data,Error>
}
