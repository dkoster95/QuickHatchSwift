//
//  URLSessionLayer+StringTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/11/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class QHNetworkRequestFactory_StringTests: QHNetworkRequestFactoryTestCase {

    func testUnauthorizedResponseUsingStringObject() {
        let unauthorizedUrlSession = URLSessionProtocolMock(urlResponse: getResponse(statusCode: 404))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                   method: .get)) { (result: Result<Response<String>, Error>) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .requestWithError(statusCode: .notFound))
                } else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testNoResponseUsingStringObject() {
        let unauthorizedUrlSession = URLSessionProtocolMock(urlResponse: nil)
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                   method: .get)) { (result: Result<Response<String>, Error>) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .noResponse)
                } else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testCancelledError() {
        let dataURLSession = URLSessionProtocolMock(error: NSError(domain: "", code: -999, userInfo: nil), urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        urlSessionLayer.string(request: URLRequest(url: URL(fileURLWithPath: ""))) { (result: Result<Response<String>, Error>) in
            switch result {
            case .failure(let error):
                if let reqError = error as? RequestError {
                    XCTAssert(reqError == RequestError.cancelled)
                }
            case .success:
                XCTAssert(false)
            }
            }.resume()
    }
    
    func testUnknownErrorUsingStringObject() {
        let unauthorizedUrlSession = URLSessionProtocolMock(urlResponse: getResponse(statusCode: 524))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                   method: .get)) { (result: Result<Response<String>, Error>) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .unknownError(statusCode: 524))
                } else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testEmptyDataUsingStringObject() {
           let fakeUrlSession = URLSessionProtocolMock(urlResponse: getResponse(statusCode: 200))
           let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
           urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                      method: .get)) { (result: Result<Response<String>, Error>) in
               switch result {
               case .success:
                   XCTAssert(false)
               case .failure(let error):
                   if let requestError = error as? RequestError {
                       XCTAssert(requestError == .noResponse)
                   } else {
                       XCTAssert(false)
                   }
               }
           }.resume()
       }
    
    func testSuccessFullDataUsingObject() {
        let fakeUrlSession = URLSessionProtocolMock(data: self.getDataModelSample, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
        let expectation = XCTestExpectation()
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,  method: .get)) { (result: Result<Response<String>, Error>) in
            switch result {
            case .success(let dataModel):
                print(dataModel.data)
                expectation.fulfill()
                XCTAssert(true)
            case .failure:
                expectation.fulfill()
                XCTAssert(false)
            }
            }.resume()
        wait(for: [expectation], timeout: 1.0)
    }

}
