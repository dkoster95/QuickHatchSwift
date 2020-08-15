//
//  URLSessionDownloadTask+Additions.swift
//  QuickHatch
//
//  Created by Daniel Koster on 4/28/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation


public class QHDownloadRequest: NSObject, DownloadRequest, URLSessionDownloadDelegate {
    private var urlSessionDownloadTask: URLSessionDownloadTask?
    private var progressHandler: ((Double) -> Void)?
    private var urlRequest: URLRequest
    private let configuration: DownloadRequestConfiguration
    private let dispatchQueue: DispatchQueue
    
    public init(configuration: DownloadRequestConfiguration, urlRequest: URLRequest, dispatchQueue: DispatchQueue = .main) {
        self.urlRequest = urlRequest
        self.configuration = configuration
        self.dispatchQueue = dispatchQueue
    }

    public func progress(received: @escaping (Double) -> Void) -> DownloadRequest {
        progressHandler = received
        return self
    }
    
    public func download(to location: @escaping (Result<URL, Error>) -> Void) -> DownloadRequest {
        urlSessionDownloadTask = configuration.urlSession(with: self).downloadTask(with: urlRequest) { [weak self] (localURL, response, Error) in
            self?.dispatchQueue.async {
                if let url = localURL {
                    location(.success(url))
                }
                //check for errors
            }
        }
        return self
    }
    
    public func resume() {
        urlSessionDownloadTask?.resume()
    }
    
    public func suspend() {
        urlSessionDownloadTask?.suspend()
    }
    
    public func cancel() {
        urlSessionDownloadTask?.cancel()
    }
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        //locationHandler?(location)
    }

    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let porcentage: Double = Double((totalBytesWritten * 100) / totalBytesExpectedToWrite)
        progressHandler?(porcentage)
    }
    
}
