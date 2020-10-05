//
//  PollingRequestTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 4/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
// swiftlint:disable force_try
// swiftlint:disable force_cast
class PollingRequestTests: URLSessionLayerBase {
    
    private var responsesForPolling: [(Data?,Error?,URLResponse?)] {
        let mock = DataModel.getMock()
        let mockSuccess = DataModel(name: "dn", nick: "nick", age: 17)
        let dataEncoded = try! JSONEncoder().encode(mock)
        let dataSuccessEncoded = try! JSONEncoder().encode(mockSuccess)
        let response = HTTPURLResponse(url: URL(string: "quickhatch.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        return [(dataSuccessEncoded,nil,response),
                (dataEncoded,nil,response),
                (dataEncoded,nil,response),
                (dataEncoded,nil,response),
                (dataEncoded,nil,response)]
    }
    
    private var mock: Data {
        let mock = DataModel.getMock()
        return try! JSONEncoder().encode(mock)
    }
    
    func testAttemptsOverflow() {
        let expectation = XCTestExpectation()
        let dataEncoded = mock
        let factory = getURLSessionLayer(urlSession: URLSessionMock(data: dataEncoded,
                                                                    error: nil,
                                                                    urlResponse: HTTPURLResponse(url: URL(string: "quickhatch.com")!,
                                                                                                 statusCode: 200,
                                                                                                 httpVersion: nil,
                                                                                                 headerFields: nil)))
        factory.response(request: try! URLRequest.get(url: "quickhatch.com", encoding: URLEncoding.default),
                         completionHandler: { (result: Result<Response<DataModel>,Error>) in
                            let resultFlatted = result.flatMapError { error in
                                return .failure(error as! RequestPollingError)
                            }
                            switch resultFlatted {
                            case .failure(let pollingError):
                                XCTAssertEqual(pollingError, .attemptsOverflow)
                            case .success:
                                XCTAssert(false)
                            }
                            expectation.fulfill()
        },
                         numberOfAttempts: 7,
                         stopCondition: { (result: Result<Response<DataModel>,Error>) in
                            return try! result.get().data.age! > 21
            }).resume()
        wait(for: [expectation], timeout: 2)
    }
    
    func testPollingSucceeded() {
        let expectation = XCTestExpectation()
        let dataEncoded = mock
        let factory = getURLSessionLayer(urlSession: URLSessionMock(data: dataEncoded,
                                                                    error: nil,
                                                                    urlResponse: HTTPURLResponse(url: URL(string: "quickhatch.com")!,
                                                                                                 statusCode: 200,
                                                                                                 httpVersion: nil,
                                                                                                 headerFields: nil)))
        factory.response(request: try! URLRequest.get(url: "quickhatch.com", encoding: URLEncoding.default),
                         completionHandler: { (result: Result<Response<DataModel>,Error>) in
                            let resultFlatted = result.flatMapError { error in
                                return .failure(error as! RequestPollingError)
                            }
                            switch resultFlatted {
                            case .failure:
                                XCTAssert(false)
                            case .success(let response):
                                XCTAssert(response.data.age == 21)
                            }
                            expectation.fulfill()
        },
                         numberOfAttempts: 7,
                         stopCondition: { (result: Result<Response<DataModel>,Error>) in
                            return try! result.get().data.age! == 21
            }).resume()
        wait(for: [expectation], timeout: 2)
    }
    
    func testPollingSucceededWithAttempts() {
        let expectation = XCTestExpectation()
        let factory = getURLSessionLayer(urlSession: URLSessionMockResponses(responses: responsesForPolling))
        factory.response(request: try! URLRequest.get(url: "quickhatch.com", encoding: URLEncoding.default),
                         completionHandler: { (result: Result<Response<DataModel>,Error>) in
                            let resultFlatted = result.flatMapError { error in
                                return .failure(error as! RequestPollingError)
                            }
                            switch resultFlatted {
                            case .failure:
                                XCTAssert(false)
                            case .success(let response):
                                XCTAssert(response.data.age == 17)
                            }
                            expectation.fulfill()
        },
                         numberOfAttempts: 4,
                         stopCondition: { (result: Result<Response<DataModel>,Error>) in
                            return try! result.get().data.age! < 21
            }).resume()
        wait(for: [expectation], timeout: 2)
    }

}
