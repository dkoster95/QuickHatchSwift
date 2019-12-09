//
//  Command.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol CommandType {
    func execute()
    func cancel()
}

public class Command<T>: CommandType {
    
    private(set) var handler: ((Result<Response<T>, Error>) -> Void)?
    private(set) var arrayHandler: ((Result<Response<Array<T>>, Error>) -> Void)?
    private(set) var handleError: ((Error) -> Void)?
    private(set) var results: (([T]) -> Void)?
    private(set) var result: ((T) -> Void)?
    private(set) var log: Logger?
    private(set) var trafficController: CommandTrafficController?
    private(set) var key: String?
    private(set) var resultsQueue: DispatchQueue = .main
    
    public func log(with logger: Logger) -> Command<T> {
        self.log = logger
        return self
    }
    
    public func authenticate(authentication: Authentication) -> Command<T> {
        return self
    }
    
//    public func refresh(authenticationRefresher: RefreshableAuthentication) -> Command<T> {
//        return self
//    }
    
    public func manageTraffic(with: CommandTrafficController, and key: String) -> Command<T> {
        self.trafficController = with
        self.key = key
        return self
    }
    
    public func resultsOn(queue: DispatchQueue) -> Command<T> {
        resultsQueue = queue
        return self
    }
    
    public func completionHandler(handler: @escaping (Result<Response<T>, Error>) -> Void) -> Command<T> {
        self.handler = handler
        arrayHandler = nil
        return self
    }
    
    public func completionHandler(handler: @escaping (Result<Response<Array<T>>,Error>) -> Void) -> Command<T> {
        self.arrayHandler = handler
        self.handler = nil
        return self
    }
    
    public func handleError(errorHandler: @escaping (Error) -> Void) -> Command<T> {
        handleError = errorHandler
        return self
    }
    
    public func onResult(resultHandler: @escaping (T) -> Void) -> Command<T> {
        result = resultHandler
        results = nil
        return self
    }
    
    public func onResults(resultsHandler: @escaping ([T]) -> Void) -> Command<T> {
        results = resultsHandler
        result = nil
        return self
    }
    
    public func execute() {
        
    }
    
    public func cancel() {
        
    }
    
    public func map<NewValue>(_ transform: (Command<T>) -> NewValue) -> NewValue {
        return transform(self)
    }
    
    public func flatMap<NewType>(_ transform: (Command<T>) -> Command<NewType>) -> Command<NewType> {
        return transform(self)
    }
}
