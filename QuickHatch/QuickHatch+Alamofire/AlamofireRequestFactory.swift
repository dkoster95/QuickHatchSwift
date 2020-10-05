//
//  AlamofireRequestFactory.swift
//  NetworkingLayer-Alamofire
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch
import Alamofire

public class AlamofireRequestFactory: NetworkRequestFactory {

    private var alamofireSession: Session
    private var unauthorizedError: Int = 401
    private var log: Logger?
    
    public init(alamofireSession: Session, logger: Logger? = nil) {
        self.alamofireSession = alamofireSession
        self.log = logger
    }
    
    public func json(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping (Result<Any, Error>) -> Void) -> QuickHatch.Request {
        return alamofireSession.request(request).responseJSON(queue: dispatchQueue) {
            dataResponse in
            guard dataResponse.error == nil || !dataResponse.error!.requestWasCancelled else {
                completion(Result.failure(RequestError.cancelled))
                return
            }
            guard let urlResponse = dataResponse.response else {
                completion(Result.failure(RequestError.noResponse))
                return
            }
            guard urlResponse.statusCode != self.unauthorizedError else {
                completion(Result.failure(RequestError.unauthorized))
                return
            }
            switch dataResponse.result {
            case .success(let json):
                completion(.success(json))
            case .failure:
                var error = RequestError.unknownError(statusCode: urlResponse.statusCode)
                if let httpStatusCode = HTTPStatusCode(rawValue: urlResponse.statusCode) {
                    error = RequestError.requestWithError(statusCode: httpStatusCode)
                }
                completion(.failure(error))
            }
        }
    }
    
    public func string(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping (Result<String, Error>) -> Void) -> QuickHatch.Request {
        return alamofireSession.request(request).responseString(queue: dispatchQueue) {
            dataResponse in
            guard dataResponse.error == nil || !dataResponse.error!.requestWasCancelled else {
                completion(Result.failure(RequestError.cancelled))
                return
            }
            guard let urlResponse = dataResponse.response else {
                completion(Result.failure(RequestError.noResponse))
                return
            }
            guard urlResponse.statusCode != self.unauthorizedError else {
                completion(Result.failure(RequestError.unauthorized))
                return
            }
            switch dataResponse.result {
            case .success(let string):
                completion(.success(string))
            case .failure:
                var error = RequestError.unknownError(statusCode: urlResponse.statusCode)
                if let httpStatusCode = HTTPStatusCode(rawValue: urlResponse.statusCode) {
                    error = RequestError.requestWithError(statusCode: httpStatusCode)
                }
                completion(.failure(error))
            }
        }
    }
    
    public func data(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping (Result<Data, Error>) -> Void) -> QuickHatch.Request {
        return alamofireSession.request(request).responseData(queue: dispatchQueue) {
            dataResponse in
            guard dataResponse.error == nil || !dataResponse.error!.requestWasCancelled else {
                completion(Result.failure(RequestError.cancelled))
                return
            }
            guard let urlResponse = dataResponse.response else {
                completion(Result.failure(RequestError.noResponse))
                return
            }
            guard urlResponse.statusCode != self.unauthorizedError else {
                completion(Result.failure(RequestError.unauthorized))
                return
            }
            switch dataResponse.result {
            case .success(let data):
                completion(.success(data))
            case .failure:
                var error = RequestError.unknownError(statusCode: urlResponse.statusCode)
                if let httpStatusCode = HTTPStatusCode(rawValue: urlResponse.statusCode) {
                    error = RequestError.requestWithError(statusCode: httpStatusCode)
                }
                completion(.failure(error))
            }
        }
    }
    
}
