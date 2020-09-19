//
//  NSObject+Extension.swift
//  QuickHatch
//
//  Created by Daniel Koster on 2/22/18.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

open class ObjectRelationalMapper: NSObject {
    
    public required init(JSON: [String: Any]) {
    }
    
    open var toJSON: [String: Any] {
        return [:]
    }
}
