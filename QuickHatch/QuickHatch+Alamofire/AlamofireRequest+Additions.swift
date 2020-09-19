//
//  AlamofireRequest+Additions.swift
//  NetworkingLayer-Alamofire
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import Alamofire
import QuickHatch

extension Alamofire.Request: QuickHatch.Request {
    public func resume() {
        let _: Alamofire.Request = self.resume()
    }
    
    public func suspend() {
        let _: Alamofire.Request = self.suspend()
    }
    
    public func cancel() {
        let _: Alamofire.Request = self.cancel()
    }
    
}
