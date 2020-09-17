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

//public class AuthClass: Authentication {
//    public var isAuthenticated: Bool = false
//
//    public func autenticate<AuthModel>(params: [String : Any], completionHandler completion: @escaping (Result<AuthModel, Error>) -> Void) where AuthModel : Decodable, AuthModel : Encodable {
//        QHRequestFactory(urlSession: .shared)
//            .response(request: try! URLRequest.get(url: "",
//                                                   encoding: URLEncoding.default))
//            { (result: Result<Response<AuthModel>,Error>) in
//                completion(result.map { $0.data })
//        }
//    }
//
//    public func authorize(request: URLRequest) throws -> URLRequest {
//        return try! URLRequest.get(url: "", encoding: URLEncoding.default)
//    }
//
//    public func clearCredentials() {
//
//    }
//
//
//}

//class x {
//    func auth() {
//        AuthClass().autenticate(params: [:]) { (result: Result<Auth,Error>) in
//
//        }
//    }
//}
//
//struct Auth: Codable {
//
//}
