//
//  URLSessionLayer.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/25/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public class QHRequestFactory: NetworkRequestFactory {
    
    private let session: URLSession
    private var log: Logger?
    private let unauthorizedCode: Int
    
    public init(urlSession: URLSession, unauthorizedCode: Int = 401) {
        self.session = urlSession
        self.unauthorizedCode = unauthorizedCode
    }
    
    public func log(with logger: Logger) {
        log = logger
    }
    
    fileprivate func execIn(dispatch: DispatchQueue, handler:@escaping () -> Void) {
        log?.debug("Switching to \(dispatch)")
        dispatch.async {
            handler()
        }
    }
    
    fileprivate func logRequestData(urlRequest: URLRequest) {
        guard let method = urlRequest.httpMethod, let url = urlRequest.url else { return }
        log?.debug("\(method.uppercased()) \(url.absoluteString)")
    }
    
    public func json(request: URLRequest,
                     dispatchQueue: DispatchQueue,
                     completionHandler completion: @escaping (Result<Response<Any>, Error>) -> Void) -> Request {
        logRequestData(urlRequest: request)
        return data(request: request, dispatchQueue: dispatchQueue) { (result: Result<Response<Data>,Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                do {
                    let json = try JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions(rawValue: 0))
                    completion(.success(Response(data: json, httpResponse: response.httpResponse)))
                } catch let decodingError {
                    completion(Result.failure(RequestError.serializationError(error: decodingError)))
                }
            }
        }
    }
    
    public func data(request: URLRequest, dispatchQueue: DispatchQueue ,completionHandler completion: @escaping DataCompletionHandler) -> Request {
        logRequestData(urlRequest: request)
        return session.dataTask(with: request) { [weak self] (data: Data?,response: URLResponse?,error: Error?) in
            guard let self = self else { return }
            self.execIn(dispatch: dispatchQueue) {
                if let requestError = NetworkRequestFactoryHelper.checkForRequestError(data: data,
                                                                                       response: response,
                                                                                       error: error,
                                                                                       unauthorizedCode: self.unauthorizedCode) {
                    completion(Result.failure(requestError))
                    return
                }
                guard let data = data, let urlResponse = response else {
                    completion(Result.failure(RequestError.noResponse))
                    return
                }
                completion(.success(Response<Data>(data: data,httpResponse: urlResponse)))
            }
        }
    }
    
    public func string(request: URLRequest,
                       dispatchQueue: DispatchQueue,
                       completionHandler completion: @escaping (Result<Response<String>, Error>) -> Void) -> Request {
        logRequestData(urlRequest: request)
        return data(request: request, dispatchQueue: dispatchQueue) { (result: Result<Response<Data>,Error>) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                guard let stringData = String(data: response.data, encoding: .utf8) else {
                    completion(.failure(RequestError.serializationError(error: RequestError.malformedRequest)))
                    return
                }
                let response = Response(data: stringData, httpResponse: response.httpResponse)
                completion(.success(response))
            }
        }
    }
    
    deinit {
        log?.info("Network factory deallocated")
    }
}
