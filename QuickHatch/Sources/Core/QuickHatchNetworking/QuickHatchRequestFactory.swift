//
//  URLSessionLayer.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
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
    
    public func json(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping (Result<Response<Any>, Error>) -> Void) -> Request{
        logRequestData(urlRequest: request)
        return data(request: request, dispatchQueue: dispatchQueue) {
            (result: Result<Response<Data>,Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                do {
                    let json:Any =  try JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as Any
                    completion(.success(Response(data:json, httpResponse: response.httpResponse)))
                }
                catch _ {
                    completion(Result.failure(RequestError.serializationError))
                }
            }
        }
    }
    
    public func data(request: URLRequest, dispatchQueue: DispatchQueue ,completionHandler completion: @escaping DataCompletionHandler) -> Request {
        logRequestData(urlRequest: request)
        return session.dataTask(with: request){
            (data:Data?,response:URLResponse?,error:Error?) in
            self.execIn(dispatch: dispatchQueue) {
                if let requestError = NetworkRequestFactoryHelper.checkForRequestError(data: data, response: response, error: error, unauthorizedCode: self.unauthorizedCode) {
                    completion(Result.failure(requestError))
                    return
                }
                guard let data = data, let urlResponse = response else {
                    completion(Result.failure(RequestError.noResponse))
                    return
                }
                completion(.success(Response<Data>(data:data,httpResponse: urlResponse)))
            }
        }
    }
    
    public func string(request: URLRequest, dispatchQueue: DispatchQueue ,completionHandler completion: @escaping (Result<Response<String>, Error>) -> Void) -> Request {
        logRequestData(urlRequest: request)
        return data(request: request, dispatchQueue: dispatchQueue) {
            (result: Result<Response<Data>,Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                guard let stringData = String(data: response.data, encoding: .utf8) else {
                    completion(.failure(RequestError.serializationError))
                    return
                }
                let response = Response(data: stringData, httpResponse: response.httpResponse)
                completion(.success(response))
            }
        }
    }
    
    deinit {
        log?.info("🌐QuickHatch🌐 - Network factory destroyed")
    }
}
