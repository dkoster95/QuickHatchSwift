//
//  Error+Additions.swift
//  QuickHatch
//
//  Created by Daniel Koster on 3/31/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
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
