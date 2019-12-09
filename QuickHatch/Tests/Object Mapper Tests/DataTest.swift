//
//  DataTest.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/15/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch

class DataTest: ObjectRelationalMapper {
    
    var name: String?
    var age: Int?
    
    required init(JSON: [String : Any]) {
        name = JSON["name"] as? String
        age = JSON["age"] as? Int
        super.init(JSON: JSON)
    }
    
    override var toJSON: [String : Any] {
        return ["name": name!, "age": age!]
    }
}
