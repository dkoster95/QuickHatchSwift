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
class URLSessionLayer_JSONTests: URLSessionLayerBase {
    var subscriptions: Set<AnyCancellable> = []
    func testNoResponseErrorJSON() {
        let dataURLSession = URLSessionMock()
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        let expectation = XCTestExpectation()
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
                                    XCTAssert(true)
                                 }).store(in: &subscriptions)
        wait(for: [expectation], timeout: 1.0)
    }

}
