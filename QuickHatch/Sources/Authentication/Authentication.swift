//
//  Authentication.swift
//  ADP
//
//  Created by Daniel Koster on 9/26/17.
//  Copyright © 2017 Shri Harsha. All rights reserved.
//

import Foundation


public protocol Authentication {
    var isAuthenticated: Bool { get }
    func autenticate(params: [String: Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void)
    func authorize(request: URLRequest) -> URLRequest
    func clearCredentials()
}

public protocol RefreshableAuthentication {
    func refresh(params: [String: Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void)
}

public protocol RevokableAuthentication {
    func revoke(params: [String: Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void)
}
