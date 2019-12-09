//
//  HTTPRequestCommand.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/6/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation

public class HTTPRequestCommand<T: Codable>: Command<T> {
    
    private var urlRequest: URLRequest
    private var networkFactory: NetworkRequestFactory
    private var authentication: Authentication?
    private var request: Request?
    private var authenticationRefresher: RefreshableAuthentication?
    
    
    public init(urlRequest: URLRequest, networkFactory: NetworkRequestFactory) {
        self.urlRequest = urlRequest
        self.networkFactory = networkFactory
    }
    
    public override func log(with logger: Logger) -> Command<T> {
        networkFactory.log(with: logger)
        return super.log(with: logger)
    }
    
    public override func authenticate(authentication: Authentication) -> Command<T> {
        log?.info("Authenticate Method called with \(authentication)")
        self.authentication = authentication
        urlRequest = authentication.authorize(request: urlRequest) 
        return self
    }
    
//    public override func refresh(authenticationRefresher: RefreshableAuthentication) -> Command<T> {
//        self.authenticationRefresher = authenticationRefresher
//        log?.info("AuthenticationRefresher set")
//        return self
//    }
    
    public override func execute() {
        setupTrafficController()
        setupArrayHandler()
        setupObjectHandler()
        request?.resume()
    }
    
    private func setupTrafficController() {
        if let trafficController = self.trafficController,
            let key = self.key {
            trafficController.setCurrentCommand(for: key,
                                                command: self)
        }
    }
    
    private func resetTraffic() {
        if let trafficController = self.trafficController, let key = self.key {
            trafficController.resetCurrentCommand(key: key)
        }
        request = nil
    }
    
    private func setupArrayHandler() {
        if let arrayHandler = self.arrayHandler {
            request = networkFactory.array(request: urlRequest, dispatchQueue: resultsQueue) { [weak self] (result: Result<Response<Array<T>>, Error>) in
                guard let self = self else { return }
                self.resetTraffic()
                arrayHandler(result)
            }
            return
        }
        if let handleResults = self.results {
            request = networkFactory.array(request: urlRequest, dispatchQueue: resultsQueue) { [weak self] (result: Result<Response<Array<T>>, Error>) in
                guard let self = self else { return }
                self.resetTraffic()
                switch result {
                case .success(let arrayResponse):
                    handleResults(arrayResponse.data)
                case .failure(let error):
                    self.handleError?(error)
                }
            }
        }
    }
    
    private func setupObjectHandler() {
        if let handler = self.handler {
            request = networkFactory.object(request: urlRequest, dispatchQueue: resultsQueue) { [weak self] (result: Result<Response<T>, Error>) in
                guard let self = self else { return }
                self.resetTraffic()
                handler(result)
            }
            return
        }
        if let handleResult = self.result {
            request = networkFactory.object(request: urlRequest, dispatchQueue: resultsQueue) { [weak self] (result: Result<Response<T>, Error>) in
                guard let self = self else { return }
                self.resetTraffic()
                switch result {
                case .success(let object):
                    handleResult(object.data)
                case .failure(let error):
                    self.handleError?(error)
                }
            }
        }
    }
    
//    private func refreshAuthenticationHandler(error: Error) {
//        if error.isUnauthorized, let refresher = authenticationRefresher {
//            refresher.refresh(params: [:]) { result in
//                switch result {
//                case .success(_ ):
//                    self.execute()
//                case .failure(let error):
//                    self.log?.error("Refresh AuthenticationFailed with error \(error)")
//                }
//            }
//        }
//    }
    
    public override func cancel() {
        request?.cancel()
    }
    
    deinit {
        log?.info("Deiniting Command")
    }
}
