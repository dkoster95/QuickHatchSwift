//
//  URLSessionLayer+JSONTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/11/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
import Combine

@available(iOS 13.0, *)
class QHNetworkRequestFactory_DataTests: QHNetworkRequestFactoryTestCase {
    var subscriptions: Set<AnyCancellable> = []
    func testUnknownErrorData() {
        let dataURLSession = URLSessionProtocolMock()
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        let expectation = XCTestExpectation()
        dataURLSession.urlError = URLError(.badURL)
        urlSessionLayer.data(request: URLRequest(url: URL(fileURLWithPath: ""))).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                let errorMapped = RequestError.map(error: error)
                XCTAssertEqual(errorMapped, .other(error: NSError(domain: "", code: 2, userInfo: nil)))
                expectation.fulfill()
            case .finished: break
            }
        }, receiveValue: { _ in
            expectation.fulfill()
            XCTAssert(false)
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testData() {
        let dataURLSession = URLSessionMock(data: getDataModelSample, error: nil, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        let expectation = XCTestExpectation()
        urlSessionLayer.data(request: URLRequest(url: URL(fileURLWithPath: ""))).sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
                XCTAssertFalse(true)
                expectation.fulfill()
            case .finished: break
            }
        }, receiveValue: { _ in
            expectation.fulfill()
            XCTAssert(true)
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testUnauthorizedData() {
        let dataURLSession = URLSessionMock(data: nil, error: nil, urlResponse: getResponse(statusCode: 400))
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        let expectation = XCTestExpectation()
        urlSessionLayer.data(request: URLRequest(url: URL(fileURLWithPath: ""))).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                let errorMapped = RequestError.map(error: error)
                XCTAssertEqual(errorMapped, RequestError.requestWithError(statusCode: .badRequest))
                expectation.fulfill()
            case .finished: break
            }
        }, receiveValue: { _ in
            expectation.fulfill()
            XCTAssert(false)
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
}
