//
//  NetworkRequestFactory+Image.swift
//  NetworkingLayer
//
//  Created by Daniel Koster on 6/10/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

#if os(iOS)
    
import UIKit

public enum ImageError: Error {
    case malformedError
}

public extension NetworkRequestFactory {
    func image(urlRequest: URLRequest, quality: CGFloat = 1, dispatchQueue: DispatchQueue = .main, completion completionHandler: @escaping (Result<UIImage,Error>) -> Void) -> Request {
        return data(request: urlRequest, dispatchQueue: dispatchQueue) {
            result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data.data, scale: quality) {
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(RequestError.serializationError(error: ImageError.malformedError)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
#endif
