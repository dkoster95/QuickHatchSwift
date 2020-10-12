//
//  URLSessionLayer.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import Combine

public class QHRequestFactory: NetworkRequestFactory {
    
    private let session: URLSessionProtocol
    private var log: Logger?
    private let unauthorizedCode: Int
    
    public init(urlSession: URLSessionProtocol, unauthorizedCode: Int = 401, logger: Logger? = nil) {
        self.session = urlSession
        self.unauthorizedCode = unauthorizedCode
        self.log = logger
    }
    
    fileprivate func execIn(dispatch: DispatchQueue, handler:@escaping () -> Void) {
        log?.debug("Switching to \(dispatch)")
        dispatch.async {
            handler()
        }
    }
    
    fileprivate func logRequestData(urlRequest: URLRequest) {
        guard let method = urlRequest.httpMethod, let url = urlRequest.url else { return }
        log?.debug("\(method.uppercased()) \(url.absoluteString)")
    }
    
    public func data(request: URLRequest, dispatchQueue: DispatchQueue ,completionHandler completion: @escaping DataCompletionHandler) -> Request {
        logRequestData(urlRequest: request)
        return session.task(with: request) { [weak self] (data: Data?,response: URLResponse?,error: Error?) in
            guard let self = self else { return }
            self.execIn(dispatch: dispatchQueue) {
                if let requestError = NetworkRequestFactoryHelper.checkForRequestError(data: data,
                                                                                       response: response,
                                                                                       error: error,
                                                                                       unauthorizedCode: self.unauthorizedCode) {
                    completion(Result.failure(requestError))
                    return
                }
                guard let data = data, let urlResponse = response else {
                    completion(Result.failure(RequestError.noResponse))
                    return
                }
                completion(.success(Response<Data>(data: data,httpResponse: urlResponse)))
            }
        }
    }
    
    @available(tvOS 13.0, *)
    @available(watchOSApplicationExtension 6.0, *)
    @available(iOS 13.0, *)
    @available(OSX 10.15, *)
    public func data(request: URLRequest, dispatchQueue: DispatchQueue) -> AnyPublisher<Data,Error> {
        return session.taskPublisher(for: request)
            .receive(on: dispatchQueue)
            .tryMap { response in
                if let requestError = NetworkRequestFactoryHelper.checkForRequestError(data: response.data,
                                                                                       response: response.response,
                                                                                       unauthorizedCode: self.unauthorizedCode) {
                    throw requestError
                }
                return response.data
            }
            .mapError { RequestError.map(error: $0) }
            .eraseToAnyPublisher()
    }
    
    deinit {
        log?.info("Network factory deallocated")
    }
}
