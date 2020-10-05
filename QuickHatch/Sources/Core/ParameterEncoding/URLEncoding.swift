//
//  URLEncoding.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/16/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public struct URLEncoding: ParameterEncoding {
    
    public static var `default`: URLEncoding { return URLEncoding() }
    
    public static var methodDependent: URLEncoding { return URLEncoding() }
    
    public static var queryString: URLEncoding { return URLEncoding(destination: .queryString) }
    
    public static var httpBody: URLEncoding { return URLEncoding(destination: .httpBody) }
    
    public let destination: ParamDestination
    
    public init(destination: ParamDestination = .methodDependent) {
        self.destination = destination
    }
    
    public func encode(_ urlRequest: URLRequestProtocol, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters else { return urlRequest }
        
        if let method = HTTPMethod(rawValue: urlRequest.httpMethod ?? "GET"), encodeParametersInURL(with: method) {
            guard let url = urlRequest.url else {
                throw EncodingError.parameterEncodingFailed(reason: .missingURL)
            }
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + query(parameters)
                urlComponents.percentEncodedQuery = percentEncodedQuery
                urlRequest.url = urlComponents.url
            }
        } else {
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = query(parameters).data(using: .utf8, allowLossyConversion: false)
        }
        
        return urlRequest
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += EncodingHelpers.queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
    private func encodeParametersInURL(with method: HTTPMethod) -> Bool {
        switch destination {
        case .queryString:
            return true
        case .httpBody:
            return false
        default:
            break
        }
        
        switch method {
        case .get, .head, .delete:
            return true
        default:
            return false
        }
    }
}
