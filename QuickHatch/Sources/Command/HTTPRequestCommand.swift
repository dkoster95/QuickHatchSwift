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
    
    
    public init(urlRequest: URLRequest, networkFactory: NetworkRequestFactory = QuickHatchRequestFactory(urlSession: URLSession.shared)) {
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
    
    public override func execute() {
        setupTrafficController()
        setupHandler()
        request?.resume()
    }
    
    private func setupTrafficController() {
        if let trafficController = self.trafficController,
            let key = self.key {
            trafficController.append(for: key,
                                     command: self)
        }
    }
    
    private func resetTraffic() {
        if let trafficController = self.trafficController, let key = self.key {
            trafficController.resetFlow(key: key)
        }
        request = nil
    }
    
    private func setupHandler() {
        if let handleResult = self.result {
            request = networkFactory.object(request: urlRequest, dispatchQueue: resultsQueue) { [weak self] (result: Result<Response<T>, Error>) in
                guard let self = self else { return }
                self.resetTraffic()
                switch result {
                case .success(let object):
                    handleResult(object.data)
                    if let responseHeaders = self.responseHeaders {
                        responseHeaders(object.httpResponse)
                    }
                case .failure(let error):
                    self.handleError?(error)
                }
            }
        }
    }
    
    public override func cancel() {
        request?.cancel()
    }
    
    deinit {
        log?.info("Deiniting Command")
    }
}
