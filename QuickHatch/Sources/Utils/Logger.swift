//
//  Logger.swift
//  FordPass
//
//  Created by Daniel Koster on 9/18/17.
//  Copyright © 2017 Daniel Koster. All rights reserved.
//

import Foundation

public let log = Log()

public protocol Logger {
    func verbose(_ msg: String)
    func debug(_ msg: String)
    func warning(_ msg: String)
    func error(_ msg: String)
    func info(_ msg: String)
    func severe(_ msg: String)
}

public class Log: Logger {
    
    public init() {
        
    }
    
    public func severe(_ msg: String) {
        #if DEBUG
        NSLog("Log: \(thread) 🆘 SEVERE -- \(msg)")
        #endif
    }
    
    public func warning(_ msg: String) {
        #if DEBUG
        NSLog("Log: \(thread) ⚠️ WARNING -- \(msg)")
        #endif
    }
    
    public func verbose(_ msg: String) {
        #if DEBUG
        NSLog("Log: \(thread) VERBOSE -- \(msg)")
        #endif
    }
    
    public func debug(_ msg: String) {
        #if DEBUG
        NSLog("Log: \(thread) ✅ DEBUG -- \(msg)")
        #endif
    }

    public func error(_ msg: String) {
        #if DEBUG
            NSLog("Log: \(thread) ❌ ERROR -- \(msg)")
        #endif
    }
    
    public func info(_ msg: String) {
        #if DEBUG
            NSLog("Log: \(thread) ℹ️ INFO -- \(msg)")
        #endif
    }
    
    private var thread: String {
        var thread = "Thread:"
        if Thread.current.isMainThread {
            thread += "main:"
        } else {
            thread += "background:"
        }
        thread += "priority:\(Thread.current.threadPriority)"
        return thread
    }
}
