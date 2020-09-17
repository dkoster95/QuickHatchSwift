//
//  DownloadRequest.swift
//  QuickHatch
//
//  Created by Daniel Koster on 5/4/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol DownloadRequest: Request {
    func progress(received: @escaping (Double) -> Void) -> DownloadRequest
    func download(to location: @escaping (Result<URL, Error>) -> Void) -> DownloadRequest
}

public protocol DownloadRequestConfiguration {
    func urlSession(with delegate: URLSessionDownloadDelegate) -> URLSession
}

public protocol DownloadRequestDelegate {
    func didUpdateProgress(value: Double)
    func didFinishDownloading(url: URL)
}
