//
//  FakeDataModel.swift
//  NetworkingLayerTests
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation

class DataModel: Codable {
    var name: String?
    var nick: String
    var age: Int?
    
    init(name: String, nick: String, age: Int) {
        self.name = name
        self.nick = nick
        self.age = age
    }
}
