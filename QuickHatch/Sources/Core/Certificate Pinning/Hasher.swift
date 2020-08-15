//
//  Hasher.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/11/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation
import CryptoKit

public protocol Hasher {
    func hash(data: Data) -> String
}

public class CCSHA256Hasher: Hasher {
    public static let shared = CCSHA256Hasher()
    
    public init() {}
    
    public func hash(data: Data) -> String {
        return data.base64EncodedString()
    }
}

@available(iOS 13.0, *)
public class CKSHA256Hasher: Hasher {
    public func hash(data: Data) -> String {
        return SHA256.hash(data: data).data.base64EncodedString()
    }
}

@available(iOS 13.0, *)
extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hexStr: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
