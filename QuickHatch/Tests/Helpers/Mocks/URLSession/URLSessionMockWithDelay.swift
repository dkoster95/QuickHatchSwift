//
//  URLSessionMockWithDelay.swift
//  QuickHatch
//
//  Created by Daniel Koster on 5/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation


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
