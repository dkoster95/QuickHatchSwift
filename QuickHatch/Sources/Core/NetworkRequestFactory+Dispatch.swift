//
//  NetworkRequestFactory+Dispatch.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import Combine

public extension NetworkRequestFactory {
    func string(request: URLRequest,
                dispatchQueue: DispatchQueue = .main,
                completionHandler completion: @escaping StringCompletionHandler) -> Request {
        return response(request: request, dispatchQueue: dispatchQueue) { (result: Result<Response<String>,Error>) in
            completion(result)
        }
    }
    
    func data(request: URLRequest, dispatchQueue: DispatchQueue = .main, completionHandler completion: @escaping DataCompletionHandler) -> Request {
        return data(request: request,
                    dispatchQueue: dispatchQueue,
                    completionHandler: completion)
    }
    
    @available(tvOS 13.0, *)
    @available(watchOSApplicationExtension 6.0, *)
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    func data(request: URLRequest, dispatchQueue: DispatchQueue = .main) -> AnyPublisher<Data,Error> {
        return data(request: request, dispatchQueue: dispatchQueue)
    }
}
