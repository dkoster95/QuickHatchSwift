//
//  NetworkRequestFactory+Codable.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public extension NetworkRequestFactory {
    func response<T:Codable>(request: URLRequest, dispatchQueue: DispatchQueue = .main, jsonDecoder: JSONDecoder = JSONDecoder() ,completionHandler completion: @escaping (Result<Response<T>, Error>) -> Void) -> Request {
        return data(request: request, dispatchQueue: dispatchQueue) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let dataJson):
                do {
                    let objectDecoded = try jsonDecoder.decode(T.self, from: dataJson.data)
                    completion(.success(Response<T>(data: objectDecoded,
                                                    httpResponse: dataJson.httpResponse)))
                }
                catch let decoderError {
                    completion(Result.failure(RequestError.serializationError(error: decoderError)))
                }
            }
        }
    }
}
