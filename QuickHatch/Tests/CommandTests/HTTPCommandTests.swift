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
    
    let trafficController = StaticTrafficController()
    
//    fileprivate func getResponse(statusCode: Int) -> HTTPURLResponse {
//        return HTTPURLResponse(url: URL(string:"www.google.com")!,
//                               statusCode: statusCode,
//                               httpVersion: "1.1",
//                               headerFields: nil)!
//    }
//
//    var getDataModelSample: Data {
//        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
//        return try! JSONEncoder().encode(dataModel)
//    }
//
//    var getArrayModelSample: Data {
//        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
//        let dataModel2 = DataModel(name: "dani", nick: "sp1", age: 13)
//        let array = [dataModel,dataModel2]
//        return try! JSONEncoder().encode(array)
//    }
//
//    private func buildRequest() -> URLRequest {
//        return try! URLRequest.get(url: URL(fileURLWithPath: ""),
//                              encoding: URLEncoding.default)
//    }
    
    func testCommandFailureUnauthorized() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: urlSessionLayer)
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .completionHandler { (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success( _):
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssertTrue(requestError == RequestError.unauthorized)
                }
            }
        }.execute()
    }
    
    func testCommandFailureUnauthorizedOnResult() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        let dispatch = DispatchQueue(label: "test")
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .resultsOn(queue: dispatch)
            .onResult { result in
                XCTAssert(false)
            }.handleError { error in
                XCTAssertTrue(!Thread.isMainThread)
                log.error(error.localizedDescription)
                if let requestError = error as? RequestError {
                    XCTAssertTrue(requestError == RequestError.unauthorized)
                }
            }.execute()
    }
    
    func testCommandFailureInternalServerError() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 500))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .completionHandler {
            (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success( _):
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssertTrue(requestError == RequestError.requestWithError(statusCode: .InternalServerError))
                }
            }
            }.execute()
    }
    
    func testCommandFailureUnknownHTTPStatusCode() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 566))
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .completionHandler {
                (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success( _):
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssertTrue(requestError == RequestError.unknownError(statusCode: 566))
                }
            }
            }.execute()
    }
    
    func testCommandFailureNoResponse() {
        let unauthorizedUrlSession = URLSessionMock()
        let urlSessionLayer = QuickHatchRequestFactory(urlSession: unauthorizedUrlSession)
        _ = HTTPRequestCommand<DataModel>(urlRequest: URLRequest(url: URL(fileURLWithPath: "")), networkFactory: urlSessionLayer)
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .completionHandler {
            (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success( _):
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssertTrue(requestError == RequestError.noResponse)
                }
            }
            }.execute()
    }

}
