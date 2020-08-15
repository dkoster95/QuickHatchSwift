//
//  QHDownloadRequestTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 5/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class QHDownloadRequestTests: XCTestCase {
    var subject: QHDownloadRequest!
    
    override func setUp() {
        let config = MockDownloadRequestConfiguration()
        subject = QHDownloadRequest(configuration: config,
                                    urlRequest: try! URLRequest.get(url: "quickhatch.com",
                                                                    encoding: URLEncoding.default))
    }

    func testProgress() {
        let expectation = XCTestExpectation(description: "progress expectation")
        //defer { wait(for: [expectation], timeout: 2.0)}
        var valuesExpected = [100.0,80.0,60.0]
        subject.progress { value in
            print(value)
            XCTAssertEqual(value, valuesExpected.popLast())
            if valuesExpected.isEmpty { expectation.fulfill() }
            }.download { result in }.resume()
        wait(for: [expectation], timeout: 2.0)
    }

}
