//
//  URLSessionDataTask+Additions.swift
//  NetworkingLayer
//
//  Created by Daniel Koster on 6/3/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation

extension URLSessionDataTask: Request {
    
    open override func resume() {
        self.resume()
    }
    
    open override func cancel() {
        self.cancel()
    }
    
    open override func suspend() {
        self.suspend()
    }
}
