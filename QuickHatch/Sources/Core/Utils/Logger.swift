//
//  Logger.swift
//  QuickHatch
//
//  Created by Daniel Koster on 9/18/17.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public let log = Log("🌐QuickHatch🌐 -")

public struct LogsShortcuts {
    static let quickhatch = "🌐QuickHatch🌐 - "
    static let commandModule = "\(LogsShortcuts.quickhatch)Command -> "
    static let requestFactory = "\(LogsShortcuts.quickhatch)RequestFactory -> "
    static let certificatePinner = "\(LogsShortcuts.quickhatch)CertificatePinner ->"
}

public protocol Logger {
    func verbose(_ msg: String)
    func debug(_ msg: String)
    func warning(_ msg: String)
    func error(_ msg: String)
    func info(_ msg: String)
    func severe(_ msg: String)
}

public class Log: Logger {
    private let shortcutId: String
    
    public init(_ shortcutId: String) {
        self.shortcutId = shortcutId
    }
    
    public func severe(_ msg: String) {
        #if DEBUG
        NSLog("\(shortcutId) Log: \(thread) 🆘 SEVERE -- \(msg)")
        #endif
    }
    
    public func warning(_ msg: String) {
        #if DEBUG
        NSLog("\(shortcutId) Log: \(thread) ⚠️ WARNING -- \(msg)")
        #endif
    }
    
    public func verbose(_ msg: String) {
        #if DEBUG
        NSLog("\(shortcutId) Log: \(thread) VERBOSE -- \(msg)")
        #endif
    }
    
    public func debug(_ msg: String) {
        #if DEBUG
        NSLog("\(shortcutId) Log: \(thread) ✅ DEBUG -- \(msg)")
        #endif
    }

    public func error(_ msg: String) {
        #if DEBUG
            NSLog("\(shortcutId) Log: \(thread) ❌ ERROR -- \(msg)")
        #endif
    }
    
    public func info(_ msg: String) {
        #if DEBUG
            NSLog("\(shortcutId) Log: \(thread) ℹ️ INFO -- \(msg)")
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
