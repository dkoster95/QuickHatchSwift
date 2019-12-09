//
//  URLSessionMock.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

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
    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let urlResponse = self.urlResponse
        return URLSessionDataTaskMock {
            completionHandler(data, urlResponse, error)
        }
    }
}

class URLSessionMockWithDelay: URLSessionMock {
    private var delay: Double
    
    init(data: Data? = nil, error: Error? = nil, urlResponse: URLResponse? = nil, delay: Double) {
        self.delay = delay
        super.init(data: data, error: error, urlResponse: urlResponse)
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let urlResponse = self.urlResponse
        return URLSessionDataTaskMockWithDelay(delay: delay) {
            completionHandler(data, urlResponse, error)
        }
    }
    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
        ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let urlResponse = self.urlResponse
        return URLSessionDataTaskMockWithDelay(delay: delay) {
            completionHandler(data, urlResponse, error)
        }
    }
}
