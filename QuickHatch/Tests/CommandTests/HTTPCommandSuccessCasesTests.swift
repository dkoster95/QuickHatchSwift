//
//  HTTPCommandSuccessCasesTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/15/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class HTTPCommandSuccessCasesTests: CommandTestBase {
    
//    private var getDataModelSample: Data {
//        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
//        return try! JSONEncoder().encode(dataModel)
//    }
//    
    let authentication = MockAuthentication()
//    
//    private var getArrayModelSample: Data {
//        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
//        let dataModel2 = DataModel(name: "dani", nick: "sp1", age: 13)
//        let array = [dataModel,dataModel2]
//        return try! JSONEncoder().encode(array)
//    }
//    
//    fileprivate func getResponse(statusCode: Int) -> HTTPURLResponse {
//        return HTTPURLResponse(url: URL(string:"www.google.com")!,
//                               statusCode: statusCode,
//                               httpVersion: "1.1",
//                               headerFields: nil)!
//    }
    let trafficController = StaticTrafficController()
    
//    private func buildRequest() -> URLRequest {
//        return try! URLRequest.get(url: URL(fileURLWithPath: ""),
//                                   encoding: URLEncoding.default)
//    }
    
    func testSuccessCaseWithObjectAndCompletionHandler() {
        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .completionHandler { (result: Result<Response<DataModel>, Error>) in
                switch result {
                case .success(let value):
                    print(value.data.nick)
                    XCTAssertTrue(value.data.nick == "sp")
                case .failure( _):
                    XCTAssertTrue(false)
                }
                
        }.execute()
    }
    
    func testSuccessCaseWithArrayAndCompletionHandler() {
        let urlSession = URLSessionMock(data: getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .completionHandler { (result: Result<Response<Array<DataModel>>, Error>) in
                XCTAssert(!self.trafficController.isCommandRunning(key: "key"))
                switch result {
                case .success(let array):
                    XCTAssert(array.data.count == 2)
                    XCTAssert(array.data[0].name! == "dan")
                case .failure( _):
                    XCTAssertTrue(false)
                }
                
            }.execute()
    }
    
    func testSuccessCaseWithArrayAndResults() {
        let urlSession = URLSessionMock(data: getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .onResults { dataModels in
                XCTAssert(dataModels.count == 2)
                XCTAssert(dataModels[0].name! == "dan")
                XCTAssert(!self.trafficController.isCommandRunning(key: "key"))
            }.execute()
    }
    
    func testSuccessCaseWithObjectAndResult() {
        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .onResult { dataModel in
                XCTAssert(dataModel.name! == "dan")
                XCTAssert(!self.trafficController.isCommandRunning(key: "key"))
            }.execute()
    }
    
    func testSuccessCaseWithObjectAndResultWithAuth() {
        let urlRequest = buildRequest()
        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: urlRequest, networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .authenticate(authentication: authentication)
            XCTAssert(self.authentication.urlRequestResult!.allHTTPHeaderFields!["Authorization"] == "Auth 12312")
    }
    
    func testCancelAction() {
        let urlRequest = buildRequest()
        let urlSession = URLSessionMockWithDelay(error: NSError(domain: "", code: -999, userInfo: nil), urlResponse: getResponse(statusCode: 200),delay: 2)
        let command = HTTPRequestCommand<DataModel>(urlRequest: urlRequest, networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
            .log(with: log)
            .manageTraffic(with: trafficController, and: "key")
            .authenticate(authentication: authentication)
            .onResult { dataModel in
                XCTAssert(false)
            }.handleError { error in
                if let reqError = error as? RequestError {
                    XCTAssert(reqError == .cancelled)
                }
            }
        command.execute()
        command.cancel()
    }
}
