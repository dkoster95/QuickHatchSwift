//
//  URLRequest+Additions.swift
//  Watch-iOS
//
//  Created by fordpass on 16/04/2019.
//  Copyright © 2019 Ford Motor Company. All rights reserved.
//

import Foundation

public extension URLRequest {
        
    mutating func addHeader(value: String, key: String) {
        self.addValue(value, forHTTPHeaderField: key)
    }
    
    init(url: URL, method: HTTPMethod) {
        self.init(url: url)
        self.httpMethod = method.rawValue
    }
}
