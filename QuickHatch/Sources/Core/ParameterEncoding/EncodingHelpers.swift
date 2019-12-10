//
//  EncodingHelpers.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/14/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public struct EncodingHelpers {
    public static func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)", value: value)
            }
        }
//        else if let value = value as? NSNumber {
//            if value.isBool {
//                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
//            } else {
//                components.append((escape(key), escape("\(value)")))
//            }
//        }
        else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    public static func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        
        
//        if #available(iOS 8.3, *) {
//            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
//        } else {
//            let batchSize = 50
//            var index = string.startIndex
//
//            while index != string.endIndex {
//                let startIndex = index
//                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
//                let range = startIndex..<endIndex
//
//                let substring = string[range]
//
//                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
//
//                index = endIndex
//            }
//        }
//
//        return escaped
    }
}
