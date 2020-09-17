//
//  Authentication.swift
//  QuickHatch
//
//  Created by Daniel Koster on 9/26/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//
import Foundation


public protocol Authentication {
    var isAuthenticated: Bool { get }
    func autenticate<AuthenticationModel: Codable>(params: [String: Any], completionHandler completion: @escaping (Result<AuthenticationModel, Error>) -> Void)
    func authorize(request: URLRequest) throws -> URLRequest
    func clearCredentials()
}

public protocol RefreshableAuthentication {
    func refresh<RefreshableAuthenticationModel: Codable>(params: [String: Any], completionHandler completion: @escaping (Result<RefreshableAuthenticationModel, Error>) -> Void)
}

public protocol RevokableAuthentication {
    func revoke<RevokableAuthenticationModel: Codable>(params: [String: Any], completionHandler completion: @escaping (Result<RevokableAuthenticationModel, Error>) -> Void)
}
