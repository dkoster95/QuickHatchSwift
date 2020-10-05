//
//  URLSessionDownloadMock.swift
//  QuickHatch
//
//  Created by Daniel Koster on 5/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

class URLSessionDownloadMock: URLSession {
    private let downloadingURL: URL?
    private let error: Error?
    private let urlResponse: URLResponse?
    internal weak var downloadDelegate: URLSessionDownloadDelegate?
    
    init(url: URL?, error: Error? = nil, urlResponse: URLResponse? = nil, delegate: URLSessionDownloadDelegate? = nil) {
        self.downloadingURL = url
        self.error = error
        self.urlResponse = urlResponse
        self.downloadDelegate = delegate
    }
    
    override func downloadTask(with request: URLRequest,
                               completionHandler: @escaping (URL?, URLResponse?, Error?) -> Void) -> URLSessionDownloadTask {
        let url = downloadingURL
        let response = urlResponse
        let error = self.error
        let mockTask = URLSessionDownloadTaskMock {
            completionHandler(url,response, error)
        }
        downloadDelegate?.urlSession?(self, downloadTask: mockTask, didWriteData: 80, totalBytesWritten: 60, totalBytesExpectedToWrite: 100)
        downloadDelegate?.urlSession?(self, downloadTask: mockTask, didWriteData: 80, totalBytesWritten: 80, totalBytesExpectedToWrite: 100)
        downloadDelegate?.urlSession?(self, downloadTask: mockTask, didWriteData: 80, totalBytesWritten: 100, totalBytesExpectedToWrite: 100)
        return mockTask
    }
}
