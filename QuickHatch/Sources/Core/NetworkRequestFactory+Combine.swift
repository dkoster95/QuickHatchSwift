//
//  NetworkRequestFactory+Combine.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/7/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation
import Combine
import UIKit

@available(tvOS 13.0, *)
@available(watchOSApplicationExtension 6.0, *)
@available(OSX 10.15, *)
@available(iOS 13.0, *)
public extension NetworkRequestFactory {
    
    func image(urlRequest: URLRequest,
               dispatchQueue: DispatchQueue = .main,
               quality: CGFloat) -> AnyPublisher<UIImage, Error> {
        return data(request: urlRequest, dispatchQueue: dispatchQueue)
            .tryMap {
                if let image = UIImage(data: $0, scale: quality) {
                    return image
                }
                throw RequestError.serializationError(error: ImageError.malformedError)
            }.eraseToAnyPublisher()
    }
    
    func response<CodableData: Codable>(urlRequest: URLRequest,
                                        dispatchQueue: DispatchQueue = .main,
                                        jsonDecoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<CodableData, Error> {
        return data(request: urlRequest, dispatchQueue: dispatchQueue)
            .decode(type: CodableData.self, decoder: jsonDecoder)
            .mapError {
                if $0 is Swift.DecodingError { return RequestError.serializationError(error: $0) }
                return $0
            }
            .eraseToAnyPublisher()
    }
    
    func string(urlRequest: URLRequest,
                dispatchQueue: DispatchQueue = .main,
                jsonDecoder: JSONDecoder = JSONDecoder())-> AnyPublisher<String, Error> {
        return data(request: urlRequest, dispatchQueue: dispatchQueue).tryMap {
            if let string = String(bytes: $0, encoding: .utf8) { return string }
            throw EncodingError.stringDecodingFailed
        }.eraseToAnyPublisher()
    }
}
