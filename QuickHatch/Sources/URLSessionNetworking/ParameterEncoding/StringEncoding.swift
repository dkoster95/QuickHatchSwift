//
//  StringEncoding.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/14/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation

public class StringEncoding: ParameterEncoding {
    
    public init(destination: ParamDestination = .queryString) {
        self.paramDest = destination
    }
    private var paramDest: ParamDestination
    
    public class var bodyEncoding: StringEncoding {
        return StringEncoding(destination: .httpBody)
    }
    
    public class var urlEncoding: StringEncoding {
        return StringEncoding()
    }
    
    
    public func encode(_ urlRequest: URLRequestProtocol, with parameters: Parameters?) throws -> URLRequest {
        var request: URLRequest = try urlRequest.asURLRequest()
        guard let url = request.url else {
            throw EncodingError.parameterEncodingFailed(reason: ParameterEncodingFailureReason.missingURL)
        }
        if paramDest == .queryString {
            urlEncoding(url: url, params: parameters, urlRequest: &request)
            return request
        }
        bodyEncoding(params: parameters, urlRequest: &request)
        return request
    }
    
    private func urlEncoding(url: URL, params: Parameters?, urlRequest: inout URLRequest) {
        guard let validParams = params, !validParams.isEmpty else { return }
        var urlString = url.absoluteString
        validParams.forEach({ (key, value) in
            let escapedParameter = EncodingHelpers.escape("{\(key)}")
            urlString = urlString.replacingOccurrences(of: escapedParameter, with: EncodingHelpers.queryComponents(fromKey: key, value: value)[0].1)
        })
        urlRequest.url = URL(string: urlString)
    }
    
    private func bodyEncoding(params: Parameters?, urlRequest: inout URLRequest) {
        guard let validParams = params, !validParams.isEmpty else { return }
        var paramsEncoded: String = ""
        validParams.forEach({ (key, value) in
            paramsEncoded += EncodingHelpers.queryComponents(fromKey: key, value: value)[0].1 + "&"
        })
        paramsEncoded.removeLast()
        urlRequest.httpBody = paramsEncoded.data(using: .utf8, allowLossyConversion: false)
    }
    
    
}
