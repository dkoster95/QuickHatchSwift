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
    

    let authentication = MockAuthentication()

    
    func testSuccessCaseWithObjectAndCompletionHandler() {
        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QHRequestFactory(urlSession: urlSession))
            .dataResponse (resultHandler: { data in
                XCTAssertTrue(data.nick == "sp")
                
            }).resume()
    }
    
    func testSuccessCaseWithArrayAndCompletionHandler() {
        let urlSession = URLSessionMock(data: getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        let command = HTTPRequestCommand<[DataModel]>(urlRequest: buildRequest(), networkFactory: QHRequestFactory(urlSession: urlSession))
            .dataResponse (resultHandler:{ dataArray in
                XCTAssert(dataArray.count == 2)
                XCTAssert(dataArray[0].name! == "dan")
            })
        command.resume()
    }
    
    func testSuccessCaseWithArrayAndResults() {
        let urlSession = URLSessionMock(data: getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<[DataModel]>(urlRequest: buildRequest(), networkFactory: QHRequestFactory(urlSession: urlSession))
            .responseHeaders{ headers in
                XCTAssert(headers.url!.absoluteString == "www.quickhatch.com")
            }
            .dataResponse (resultHandler:{ dataModels in
                XCTAssert(dataModels.count == 2)
                XCTAssert(dataModels[0].name! == "dan")
            }).resume()
        
    }
    
    func testSuccessCaseWithObjectAndResult() {
        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QHRequestFactory(urlSession: urlSession))
            .dataResponse(resultHandler: { dataModel in
                XCTAssert(dataModel.name! == "dan")
            }).resume()
    }
    
    func testSuccessCaseWithObjectAndResultWithAuth() {
        let urlRequest = buildRequest()
        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 200))
        _ = HTTPRequestCommand<DataModel>(urlRequest: urlRequest, networkFactory: QHRequestFactory(urlSession: urlSession))
            .authenticate(authentication: authentication)
            XCTAssert(self.authentication.urlRequestResult!.allHTTPHeaderFields!["Authorization"] == "Auth 12312")
    }
    
    func testCancelAction() {
        let urlRequest = buildRequest()
        let urlSession = URLSessionMockWithDelay(error: NSError(domain: "", code: -999, userInfo: nil), urlResponse: getResponse(statusCode: 200),delay: 2)
        let command = HTTPRequestCommand<DataModel>(urlRequest: urlRequest, networkFactory: QHRequestFactory(urlSession: urlSession))
            .authenticate(authentication: authentication)
            .dataResponse(resultHandler: { dataModel in
                XCTAssert(false)
            },errorHandler: { error in
                if let reqError = error as? RequestError {
                    XCTAssert(reqError == .cancelled)
                }
            })
        command.resume()
        command.cancel()
    }
    
    func testCancelActionWhenDiscarded() {
        let urlRequest = buildRequest()
        let urlSession = URLSessionMockWithDelay(error: NSError(domain: "", code: -999, userInfo: nil), urlResponse: getResponse(statusCode: 200),delay: 2)
        let command = HTTPRequestCommand<DataModel>(urlRequest: urlRequest, networkFactory: QHRequestFactory(urlSession: urlSession))
            .authenticate(authentication: authentication)
            .discardIfCancelled()
            .dataResponse(resultHandler: { dataModel in
                XCTAssert(false)
            },errorHandler: { error in
                XCTAssert(false)
            })
        command.resume()
        command.cancel()
    }
}
