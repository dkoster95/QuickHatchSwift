//
//  CommandTrafficController.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/6/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol CommandTrafficController {
    func append(for key: String, command: CommandType)
    func resetFlow(key: String)
    func resetTraffic()
    func isCommandRunning(key: String, command: CommandType) -> Bool
    func printTrace()
}

public class TrafficControllerSet: CommandTrafficController {
    
    private var commands: [String: CommandType] = [:]
    private var log: Logger = Log(LogsShortcuts.commandModule)
    
    public init(log: Logger) {
        self.log = log
    }
    
    public convenience init() {
        self.init(log: Log(LogsShortcuts.commandModule))
    }
    
    public func append(for key: String, command: CommandType) {
        if isCommandRunning(key: key, command: command) {
            commands[key]?.cancel()
        }
        commands[key] = command
    }
    
    public func resetFlow(key: String) {
        commands[key] = nil
    }
    
    public func resetTraffic() {
        commands.forEach { (key, value) in
            commands[key]?.cancel()
        }
        commands.removeAll()
    }
    
    public func isCommandRunning(key: String, command: CommandType) -> Bool {
        return commands[key] != nil
    }
    
    public func printTrace() {
        commands.forEach { (key, value) in
            log.debug("Flow - \(key) -> Command with Id: \(value.id) running")
        }
    }
    
}
