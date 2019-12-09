//
//  URLSessionLayer.swift
//  FordPass
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2017 Daniel Koster. All rights reserved.
//

import Foundation


public class QuickHatchRequestFactory : NetworkRequestFactory {
    
    private var session: URLSession
    private var log: Logger?
    private var unauthorizedCode: Int = 401
    public init(urlSession: URLSession, unauthorizedCode: Int = 401) {
        self.session = urlSession
        self.unauthorizedCode = unauthorizedCode
    }
    
    public func log(with logger: Logger) {
        log = logger
    }
    
    fileprivate func execIn(dispatch: DispatchQueue, handler:@escaping () -> Void) {
        log?.debug("🌐QuickHatch🌐 - Switching to \(dispatch)")
        dispatch.async {
            handler()
        }
    }
    
    fileprivate func logRequestData(urlRequest: URLRequest) {
        guard let method = urlRequest.httpMethod, let url = urlRequest.url else { return }
        log?.debug("🌐QuickHatch🌐 - \(method.uppercased()) \(url.absoluteString)")
    }
    
    public func json(request: URLRequest, dispatchQueue: DispatchQueue,  completionHandler completion: @escaping (Result<Any, Error>) -> Void) -> Request{
        logRequestData(urlRequest: request)
        return session.dataTask(with: request){
            (data:Data?,response:URLResponse?,error:Error?) in
            self.execIn(dispatch: dispatchQueue) {
                if let requestError = NetworkRequestFactoryHelper.checkForRequestError(data: data, response: response, error: error, unauthorizedCode: self.unauthorizedCode) {
                    completion(Result.failure(requestError))
                    return
                }
                guard let dataJson = data else{
                    completion(Result.failure(RequestError.noResponse))
                    return
                }
                do {
                    let json:Any =  try JSONSerialization.jsonObject(with: dataJson, options: JSONSerialization.ReadingOptions(rawValue: 0)) as Any
                    completion(.success(json))
                }
                catch _ {
                    completion(Result.failure(RequestError.serializationError))
                }
            }
        }
    }
    
    public func data(request: URLRequest, dispatchQueue: DispatchQueue ,completionHandler completion: @escaping (Result<Data, Error>) -> Void) -> Request {
        logRequestData(urlRequest: request)
        return session.dataTask(with: request){
            (data:Data?,response:URLResponse?,error:Error?) in
            self.execIn(dispatch: dispatchQueue) {
                if let requestError = NetworkRequestFactoryHelper.checkForRequestError(data: data, response: response, error: error, unauthorizedCode: self.unauthorizedCode) {
                    completion(Result.failure(requestError))
                    return
                }
                guard let data = data else{
                    completion(Result.failure(RequestError.noResponse))
                    return
                }
                completion(.success(data))
            }
        }
    }
    
    public func string(request: URLRequest, dispatchQueue: DispatchQueue ,completionHandler completion: @escaping (Result<String, Error>) -> Void) -> Request {
        logRequestData(urlRequest: request)
        return session.dataTask(with: request){
            (data:Data?,response:URLResponse?,error:Error?) in
            self.execIn(dispatch: dispatchQueue) {
                if let requestError = NetworkRequestFactoryHelper.checkForRequestError(data: data, response: response, error: error, unauthorizedCode: self.unauthorizedCode) {
                    completion(Result.failure(requestError))
                    return
                }
                guard let data = data else{
                    completion(Result.failure(RequestError.noResponse))
                    return
                }
                let strData = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                completion(.success(strData!))
            }
        }
    }
    
    deinit {
        log?.info("🌐QuickHatch🌐 - Network factory destroyed")
    }
}
