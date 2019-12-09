//
//  CommandTrafficController.swift
//  NetworkingLayer
//
//  Created by Daniel Koster on 8/6/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import Foundation

public protocol CommandTrafficController {
    func setCurrentCommand(for key: String, command: CommandType)
    func resetCurrentCommand(key: String)
    func resetTraffic()
    func isCommandRunning(key: String) -> Bool
}

public class StaticTrafficController: CommandTrafficController {
    
    public init() {}
    
    private var commands: [String: CommandType] = [:]
    
    public func setCurrentCommand(for key: String, command: CommandType) {
        if isCommandRunning(key: key) {
            commands[key]?.cancel()
        }
        commands[key] = command
    }
    
    public func resetCurrentCommand(key: String) {
        commands[key] = nil
    }
    
    public func resetTraffic() {
        commands.forEach { (key, value) in
            commands[key]?.cancel()
        }
        commands.removeAll()
    }
    
    public func isCommandRunning(key: String) -> Bool {
        return commands[key] != nil
    }
    
    
}
