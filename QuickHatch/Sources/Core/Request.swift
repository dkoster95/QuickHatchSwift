//
//  Request.swift
//  QuickHatch
//
//  Created by Daniel Koster on 4/13/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol Request: NSObjectProtocol {
    func resume()
    func suspend()
    func cancel()
}

public protocol QHMonitorSet {
    func filter(query: (String) -> Bool) -> QHMonitorSet
    subscript (key: String) -> Request? { get set }
}

public class RequestMonitor: QHMonitorSet {
    private var requests: [String: Request] = [:]
    
    public init() {
        
    }
    
    public func filter(query: (String) -> Bool) -> QHMonitorSet {
        let requestMonitor = RequestMonitor()
        for key in requests.keys where query(key) {
            requestMonitor[key] = requests[key]
        }
        return requestMonitor
    }
    
    public subscript (key: String) -> Request? {
        get {
            return requests[key]
        }
        set {
            if let request = requests[key] {
                request.cancel()
            }
            requests[key] = newValue
        }
    }
}
