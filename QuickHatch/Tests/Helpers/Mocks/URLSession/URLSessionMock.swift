//
//  URLSessionMock.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch
import Combine

class URLSessionProtocolMock: URLSessionProtocol {
    
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?
    
    init(data: Data? = nil, error: Error? = nil, urlResponse: URLResponse? = nil) {
        self.data = data
        self.error = error
        self.urlResponse = urlResponse
    }
    
    func task(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Request {
        let data = self.data
        let error = self.error
        let urlResponse = self.urlResponse
        return URLSessionDataTaskMock {
            completionHandler(data, urlResponse, error)
        }
    }
    
    var urlError: URLError = URLError(.cancelled)
    @available(iOS 13.0, *)
    func taskPublisher(for request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return Just((Data(), URLResponse()))
            .tryMap { _ in
                if let validData = self.data, let validResponse = self.urlResponse {
                    return (validData, validResponse)
                }
                throw urlError
            }
            .mapError { _ in
                return urlError
            }.eraseToAnyPublisher()
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var urlResponse: URLResponse?

    init(data: Data? = nil, error: Error? = nil, urlResponse: URLResponse? = nil) {
        self.data = data
        self.error = error
        self.urlResponse = urlResponse
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let urlResponse = self.urlResponse
        return URLSessionDataTaskMock {
            completionHandler(data, urlResponse, error)
        }
    }
}

class URLSessionMockResponses: URLSessionProtocolMock {
    private var responses: [(Data?,Error?,URLResponse?)] = []
    
    init(responses: [(Data?,Error?,URLResponse?)]) {
        self.responses = responses
    }
    
    override func task(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> Request {
        let firstResponse = responses.popLast()
        return URLSessionDataTaskMock {
            completionHandler(firstResponse?.0, firstResponse?.2, firstResponse?.1)
        }
    }
}
