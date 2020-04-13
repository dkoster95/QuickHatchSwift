//
//  MockRequest.swift
//  QuickHatch
//
//  Created by Daniel Koster on 4/13/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch

class MockRequest: NSObject, Request {
    
    var requestResumed = false
    func resume() {
        requestResumed = true
    }
    var requestSuspended = false
    func suspend() {
        requestSuspended = true
    }
    var requestCancelled = false
    func cancel() {
        requestCancelled = true
    }
    
    
}
