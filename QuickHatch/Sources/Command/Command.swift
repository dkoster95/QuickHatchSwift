//
//  Command.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol CommandType {
    var id: UUID { get }
    func execute()
    func cancel()
}


public class Command<T>: CommandType {
    
    private(set) var handleError: ((Error) -> Void)?
    private(set) var responseHeaders: ((URLResponse) -> Void)?
    private(set) var result: ((T) -> Void)?
    private(set) var log: Logger?
    private(set) var trafficController: CommandTrafficController?
    private(set) var key: String?
    private(set) var resultsQueue: DispatchQueue = .main
    private var identifier: UUID?
    
    public var id: UUID {
        if let id = self.identifier {
            return id
        }
        let newId = UUID()
        identifier = newId
        return newId
    }
    
    public func log(with logger: Logger) -> Command<T> {
        self.log = logger
        return self
    }
    
    public func authenticate(authentication: Authentication) -> Command<T> {
        return self
    }
    
    public func manageTraffic<Traffic: CommandTrafficController>(with: Traffic, and key: String) -> Command<T> {
        self.trafficController = with
        self.key = key
        return self
    }
    
    public func asyncOn(queue: DispatchQueue) -> Command<T> {
        resultsQueue = queue
        return self
    }
    
    public func responseHeaders(responseHeaders: @escaping (URLResponse) -> Void) -> Command<T>{
        self.responseHeaders = responseHeaders
        return self
    }
    
    public func handleError(errorHandler: @escaping (Error) -> Void) -> Command<T> {
        handleError = errorHandler
        return self
    }
    
    public func dataResponse(resultHandler: @escaping (T) -> Void) -> Command<T> {
        result = resultHandler
        return self
    }
    
    public func execute() {
        
    }
    
    public func cancel() {
        
    }
    
//    static public func == (lhs: Command<T>, rhs: Command<T>) -> Bool {
//        return lhs.id == rhs.id
//    }
    
}
