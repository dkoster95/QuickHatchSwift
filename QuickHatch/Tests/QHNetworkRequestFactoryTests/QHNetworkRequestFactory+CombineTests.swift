//
//  NetworkRequestFactory+CombineTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/7/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
import Combine

@available(iOS 13.0, *)
class QHNetworkRequestFactory_CombineTests: QHNetworkRequestFactoryTestCase {
    var subscriptions: Set<AnyCancellable> = []
    fileprivate var imageData: Data {
        let bundle = Bundle.init(for: QHNetworkRequestFactory_ImageTests.self)
        let image = UIImage(named: "swifticon", in: bundle, compatibleWith: nil)
        return image!.pngData()!
    }
    func testResponseSuccessCase() {
        let expectation = XCTestExpectation()
        let fakeUrlSession = URLSessionMock(data: self.getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        let subject = getURLSessionLayer(urlSession: fakeUrlSession)
        subject.response(urlRequest: fakeURLRequest).sink(receiveCompletion: { completion in
            switch completion {
            case .failure: XCTAssert(false)
            case .finished: break
            }
            expectation.fulfill()
        }, receiveValue: { (value: [DataModel]) in
            XCTAssertEqual(value.count, 2)
            expectation.fulfill()
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testResponseSerializationErrorCase() {
        let expectation = XCTestExpectation()
        let fakeUrlSession = URLSessionMock(data: self.getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        let subject = getURLSessionLayer(urlSession: fakeUrlSession)
        subject.response(urlRequest: fakeURLRequest).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error): XCTAssertEqual(RequestError.serializationError(error: MockError.mock), RequestError.map(error: error))
            case .finished: break
            }
            expectation.fulfill()
        }, receiveValue: { (_ : DataModel) in
            XCTAssert(false)
            expectation.fulfill()
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testBadRequestError() {
        let expectation = XCTestExpectation()
        let dataURLSession = URLSessionProtocolMock(data: Data(), urlResponse: getResponse(statusCode: 400))
        let subject = getURLSessionLayer(urlSession: dataURLSession)
        subject.response(urlRequest: fakeURLRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(RequestError.requestWithError(statusCode: .badRequest), RequestError.map(error: error))
                case .finished: break
                }
                expectation.fulfill()
            }, receiveValue: { (_ : DataModel) in
                XCTAssert(false)
                expectation.fulfill()
            }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testCancelledError() {
        let expectation = XCTestExpectation()
        let dataURLSession = URLSessionProtocolMock()
        dataURLSession.urlError = URLError(.cancelled)
        let subject = getURLSessionLayer(urlSession: dataURLSession)
        subject.response(urlRequest: fakeURLRequest)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(RequestError.cancelled, RequestError.map(error: error))
                case .finished: break
                }
                expectation.fulfill()
            }, receiveValue: { (_ : DataModel) in
                XCTAssert(false)
                expectation.fulfill()
            }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testStringSuccessCase() {
        let expectation = XCTestExpectation()
        let fakeUrlSession = URLSessionMock(data: "Hello this is a string".data(using: .utf8), urlResponse: getResponse(statusCode: 200))
        let subject = getURLSessionLayer(urlSession: fakeUrlSession)
        subject.string(urlRequest: fakeURLRequest).sink(receiveCompletion: { completion in
            switch completion {
            case .failure: XCTAssert(false)
            case .finished: break
            }
            expectation.fulfill()
        }, receiveValue: { string in
            XCTAssertEqual(string, "Hello this is a string")
            expectation.fulfill()
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testImageSerializationErrorCase() {
        let expectation = XCTestExpectation()
        let fakeUrlSession = URLSessionMock(data: self.getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        let subject = getURLSessionLayer(urlSession: fakeUrlSession)
        subject.image(urlRequest: fakeURLRequest, quality: 1.0).sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error): XCTAssertEqual(RequestError.serializationError(error: MockError.mock), RequestError.map(error: error))
            case .finished: break
            }
            expectation.fulfill()
        }, receiveValue: { _ in
            XCTAssert(false)
            expectation.fulfill()
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testImageSuccessCase() {
        let expectation = XCTestExpectation()
        let fakeUrlSession = URLSessionMock(data: self.imageData, urlResponse: getResponse(statusCode: 200))
        let subject = getURLSessionLayer(urlSession: fakeUrlSession)
        subject.image(urlRequest: fakeURLRequest,quality: 1.0).sink(receiveCompletion: { completion in
            switch completion {
            case .failure: XCTAssert(false)
            case .finished: break
            }
            expectation.fulfill()
        }, receiveValue: { _ in
            XCTAssert(true)
            expectation.fulfill()
        }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }

}

enum MockError: Error {
    case mock
}
