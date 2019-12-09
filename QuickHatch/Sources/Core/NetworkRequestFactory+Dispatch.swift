//
//  NetworkRequestFactory+Dispatch.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public extension NetworkRequestFactory {
    func json(request: URLRequest,dispatchQueue: DispatchQueue = .main, completionHandler completion: @escaping AnyCompletionHandler) -> Request {
        return json(request: request,
                    dispatchQueue: dispatchQueue,
                    completionHandler: completion)
    }
    func string(request: URLRequest,dispatchQueue: DispatchQueue = .main, completionHandler completion: @escaping StringCompletionHandler) -> Request {
        return string(request: request,
                      dispatchQueue: dispatchQueue,
                      completionHandler: completion)
    }
    func data(request: URLRequest, dispatchQueue: DispatchQueue = .main, completionHandler completion: @escaping DataCompletionHandler) -> Request {
        return data(request: request,
                    dispatchQueue: dispatchQueue,
                    completionHandler: completion)
    }
}
