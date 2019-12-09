//
//  Error+Additions.swift
//  iDeate
//
//  Created by Daniel Koster on 3/31/17.
//  Copyright © 2017 Daniel Koster. All rights reserved.
//

import Foundation

extension Error {
    
    public var requestWasCancelled: Bool {
        return (self as NSError).code == -999
    }
    
    public var isUnauthorized: Bool {
        if let error = self as? RequestError {
            return error == .unauthorized
        }
        return false
    }
}
