//
//  URLSessionDownloadTaskMock.swift
//  QuickHatch
//
//  Created by Daniel Koster on 5/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

class URLSessionDownloadTaskMock: URLSessionDownloadTask {
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
