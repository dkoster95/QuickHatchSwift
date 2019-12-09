//
//  URLSessionDataTaskMock.swift
//  NetworkingLayerTests
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation
class URLSessionDataTaskMock: URLSessionDataTask {
    
    private let closure: () -> Void
    
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}

class URLSessionDataTaskMockWithDelay: URLSessionDataTaskMock {
    private let delay: Double
    
    init(delay: Double, closure: @escaping () -> Void) {
        self.delay = delay
        super.init(closure: closure)
    }
    
    override func resume() {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            super.resume()
        }
    }
    
    override func cancel() {
        super.resume()
    }
}

class FakeURLSessionDataTask: URLSessionDataTask {
    public var resumed = false
    override func resume() {
        resumed = true
    }
    public var canceled = false
    override func cancel() {
        canceled = true
    }
    public var suspended = false
    override func suspend() {
        suspended = true
    }
}
