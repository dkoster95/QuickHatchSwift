//
//  MockDownloadRequestConfiguration.swift
//  QuickHatch
//
//  Created by Daniel Koster on 5/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch

struct MockDownloadRequestConfiguration: DownloadRequestConfiguration {
    private let url: URL?
    private let error: Error?
    private let urlResponse: URLResponse?
    
    init(url: URL? = nil, error: Error? = nil, urlResponse: URLResponse? = nil) {
        self.url = url
        self.error = error
        self.urlResponse = urlResponse
    }
    
    func urlSession(with delegate: URLSessionDownloadDelegate) -> URLSession {
        return URLSessionDownloadMock(url: url, error: error, urlResponse: urlResponse, delegate: delegate)
    }
}
