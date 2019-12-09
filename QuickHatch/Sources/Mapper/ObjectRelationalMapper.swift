//
//  NSObject+Extension.swift
//  fordpass-watch-na Extension
//
//  Created by Common on 2/22/18.
//  Copyright © 2018 Ford. All rights reserved.
//

import Foundation

open class ObjectRelationalMapper: NSObject {
    
    
    public required init(JSON: [String: Any]) {
    }
    
    open var toJSON: [String: Any] {
        return [:]
    }
}
