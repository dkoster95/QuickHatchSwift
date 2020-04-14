//
//  HTTPRequestCommand.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/6/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public class HTTPRequestCommand<T: Codable> {
    
    private let urlRequest: URLRequest
    private var networkFactory: NetworkRequestFactory
    private var responseHeaders: ((URLResponse) -> Void)?
    private var dispatchQueue: DispatchQueue = .main
    private let logger: Logger
    private var discardIfCancelledFlag: Bool = false
    
    
    public init(urlRequest: URLRequest, networkFactory: NetworkRequestFactory = QuickHatchRequestFactory(urlSession: URLSession.shared), logger: Logger = log) {
        self.urlRequest = urlRequest
        self.networkFactory = networkFactory
        self.logger = log
    }
    
    public func authenticate(authentication: Authentication) -> HTTPRequestCommand<T> {
        logger.info("Authenticate Method called with \(authentication)")
        let authenticatedRequest = try! authentication.authorize(request: urlRequest)
        let request = HTTPRequestCommand(urlRequest: authenticatedRequest, networkFactory: networkFactory, logger: logger)
        request.responseHeaders = self.responseHeaders
        request.dispatchQueue = dispatchQueue
        return request
    }
    
    public func asyncOn(queue: DispatchQueue) -> HTTPRequestCommand<T> {
        let commandCopy = self
        commandCopy.dispatchQueue = queue
        return commandCopy
    }
    
    public func responseHeaders(responseHeaders: @escaping (URLResponse) -> Void) -> HTTPRequestCommand<T>{
        let commandCopy = self
        commandCopy.responseHeaders = responseHeaders
        return commandCopy
    }
    
    public func discardIfCancelled() -> HTTPRequestCommand<T> {
        let commandCopy = self
        commandCopy.discardIfCancelledFlag = true
        return commandCopy
    }
    
    public func dataResponse(resultHandler: @escaping (T) -> Void, errorHandler: ((Error) -> Void)? = nil) -> Request {
        return networkFactory.response(request: urlRequest, dispatchQueue: dispatchQueue) { (result: Result<Response<T>,Error>) in
            switch result {
            case .success(let response):
                self.responseHeaders?(response.httpResponse)
                resultHandler(response.data)
            case .failure(let error):
                if let error = error as? RequestError, error == .cancelled, self.discardIfCancelledFlag {
                    self.logger.error("Cancelled error message")
                } else {
                    errorHandler?(error)
                }
            }
        }
    }
    
    deinit {
        logger.info("Deiniting Command")
    }
}
