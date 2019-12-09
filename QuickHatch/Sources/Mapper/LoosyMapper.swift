//
//  LoosyMapper.swift
//  FordPass
//
//  Created by Bruno Garelli on 9/9/17.
//  Copyright © 2017 Daniel Koster. All rights reserved.
//

import Foundation

public class LoosyMapper<T: ObjectRelationalMapper> {
    public init() {
    }
    
    public func mapArray(dict: Any) -> [T] {
        guard let array = dict as? [[String: Any]] else {
            return []
        }
        var objectArray: [T] = []
        for item in array {
            let item = T(JSON: item)
            objectArray.append(item)
        }
        return objectArray
    }
    
    public func toJSONArray(array: [T]) -> [[String: Any]] {
        var jsonArray: [[String: Any]] = []
        for item in array {
            jsonArray.append(item.toJSON)
        }
        return jsonArray
    }
    
    public func mapObject(dict: Any) -> T? {
        guard let json = dict as? [String: Any] else {
            return nil
        }
        return T(JSON: json)
    }
}
