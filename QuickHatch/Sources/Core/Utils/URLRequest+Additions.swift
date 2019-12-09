//
//  URLRequest+Additions.swift
//  QuickHatch
//
//  Created by QuickHatch on 16/04/2019.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
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
