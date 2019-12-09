//
//  LoosyMapper.swift
//  QuickHatch
//
//  Created by Daniel Koster on 9/9/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
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
