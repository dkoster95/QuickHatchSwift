//
//  NetworkRequestFactory+Codable.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation

public extension NetworkRequestFactory {
    func object<T:Codable>(request: URLRequest, dispatchQueue: DispatchQueue = .main ,completionHandler completion: @escaping (Result<T, Error>) -> Void) -> Request {
        return data(request: request, dispatchQueue: dispatchQueue) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let dataJson):
                do {
                    let objectDecoded = try JSONDecoder().decode(T.self, from: dataJson)
                    completion(.success(objectDecoded))
                }
                catch _ {
                    completion(Result.failure(RequestError.serializationError))
                }
            }
        }
    }
    func array<T:Codable>(request: URLRequest, dispatchQueue: DispatchQueue = .main , completionHandler completion: @escaping (Result<[T], Error>) -> Void) -> Request {
        return data(request: request, dispatchQueue: dispatchQueue) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let dataArray):
                do {
                    let arrayDecoded = try JSONDecoder().decode([T].self, from: dataArray)
                    completion(.success(arrayDecoded))
                }
                catch _ {
                    completion(Result.failure(RequestError.serializationError))
                }
            }
        }
    }
}
