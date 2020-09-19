//
//  MockAuthentication.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/13/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch

class MockAuthentication: Authentication {
    public var isAuth = true
    var isAuthenticated: Bool {
        return isAuth
    }
    
    func autenticate(params: [String: Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void) {
        
    }
    
    public var urlRequestResult: URLRequest?
    func authorize(request: URLRequest) -> URLRequest {
        log.verbose("authorizing")
        var authRequest = request
        authRequest.addHeader(value: "Auth 12312", key: "authorization")
        urlRequestResult = authRequest
        return authRequest
    }
    
    func clearCredentials() {
        
    }
    
}
