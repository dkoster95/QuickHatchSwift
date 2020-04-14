//
//  HTTPCommandTests.swift
//  NetworkingLayerTests
//
//  Created by Daniel Koster on 8/6/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class HTTPCommandTests: CommandTestBase {

    
    func testCommandFailureUnauthorized() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: urlSessionLayer)
            .dataResponse (resultHandler: { data in
                XCTAssert(false)
                
            }, errorHandler: { error in
                if let requestError = error as? RequestError {
                    XCTAssertEqual(requestError, RequestError.unauthorized)
                }
            }).resume()
    }
    
    func testCommandFailureUnauthorizedOnResult() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        let dispatch = DispatchQueue(label: "test")
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .asyncOn(queue: dispatch)
            .dataResponse(resultHandler: { result in
                XCTAssert(false)
            },errorHandler:  { error in
                XCTAssertTrue(!Thread.isMainThread)
                log.error(error.localizedDescription)
                if let requestError = error as? RequestError {
                    XCTAssertTrue(requestError == RequestError.unauthorized)
                }
            }).resume()
    }
    
    func testCommandFailureInternalServerError() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 500))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .dataResponse(resultHandler: { data in
                XCTAssert(false)
                
            }, errorHandler: { error in
                    if let requestError = error as? RequestError {
                        XCTAssertEqual(requestError, RequestError.requestWithError(statusCode: .InternalServerError))
                    }
            }).resume()
    }
    
    func testCommandFailureUnknownHTTPStatusCode() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 566))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .dataResponse(resultHandler: { data in
                XCTAssert(false)
                
            }, errorHandler: { error in
                    if let requestError = error as? RequestError {
                        XCTAssertEqual(requestError, RequestError.unknownError(statusCode: 566))
                    }
            }).resume()
    }
    
    func testCommandFailureNoResponse() {
        let unauthorizedUrlSession = URLSessionMock()
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .dataResponse(resultHandler: { data in
                XCTAssert(false)
                
            }, errorHandler: { error in
                    if let requestError = error as? RequestError {
                        XCTAssertEqual(requestError, RequestError.noResponse)
                    }
            }).resume()
    }

}
