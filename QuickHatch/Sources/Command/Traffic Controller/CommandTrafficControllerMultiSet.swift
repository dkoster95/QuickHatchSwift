//
//  CommandTrafficControllerMultiSet.swift
//  QuickHatch
//
//  Created by Daniel Koster on 1/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public class TrafficControllerMultiSet: CommandTrafficController {
    
    private var commandsMultiSet: [String: [CommandType]] = [:]
    private var log: Logger = Log(LogsShortcuts.commandModule)
    
    public init(log: Logger) {
        self.log = log
    }
    
    public convenience init() {
        self.init(log: Log(LogsShortcuts.commandModule))
    }
    
    public func append(for key: String, command: CommandType) {
        if let semiSet = commandsMultiSet[key] {
            let commandExists = !semiSet.filter {$0.id == command.id}.isEmpty
            guard !commandExists else { return }
            commandsMultiSet[key]?.append(command)
        } else {
            commandsMultiSet[key] = [command]
        }
    }
    
    public func resetFlow(key: String) {
        if var semiSet = commandsMultiSet[key] {
            for command in semiSet {
                command.cancel()
            }
            semiSet.removeAll()
        }
        commandsMultiSet[key] = nil
    }
    
    public func resetTraffic() {
        commandsMultiSet.forEach { (key, value) in
            _ = commandsMultiSet[key]?.map { $0.cancel() }
            commandsMultiSet[key]?.removeAll()
            commandsMultiSet[key] = nil
        }
    }
    
    public func isCommandRunning(key: String, command: CommandType) -> Bool {
        if let semiSet = commandsMultiSet[key] {
            return !semiSet.filter { $0.id == command.id }.isEmpty
        }
        return false
    }
    
    public func printTrace() {
        commandsMultiSet.forEach { (key, value) in
            for command in value {
                log.debug("Flow - \(key) -> Command with Id: \(command.id) running")
            }
        }
    }
    
}
