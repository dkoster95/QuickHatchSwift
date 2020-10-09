//
//  URLSessionProtocol.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/7/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation
import Combine

public protocol URLSessionProtocol {
    func task(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Request
    @available(tvOS 13.0, *)
    @available(watchOSApplicationExtension 6.0, *)
    @available(OSX 10.15, *)
    @available(iOS 13.0, *)
    func taskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

extension URLSession: URLSessionProtocol {
    public func task(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Request {
        return self.dataTask(with: request, completionHandler: completionHandler)
    }
    
    @available(tvOS 13.0, *)
    @available(watchOSApplicationExtension 6.0, *)
    @available(OSX 10.15, *)
    @available(iOS 13.0, *)
    public func taskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return self.dataTaskPublisher(for: request).eraseToAnyPublisher()
    }
}
