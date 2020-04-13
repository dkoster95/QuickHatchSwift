//
//  RequestMonitorTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 4/13/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class RequestMonitorTests: XCTestCase {
    var subject = RequestMonitor()
    

    func testAddRequest() {
        let request = MockRequest()
        subject["test"] = request
        XCTAssertNotNil(subject["test"])
    }
    
    func testCancelRequest() {
        let request = MockRequest()
        let request2 = MockRequest()
        subject["test"] = request
        XCTAssertNotNil(subject["test"])
        subject["test"] = request2
        XCTAssertNotNil(subject["test"])
        XCTAssertTrue(request.requestCancelled)
    }
    
    func testFilter() {
        let request = MockRequest()
        let request2 = MockRequest()
        subject["test"] = request
        XCTAssertNotNil(subject["test"])
        subject["test"] = request2
        XCTAssertNotNil(subject["test"])
        XCTAssertTrue(request.requestCancelled)
        let newMonitor = subject.filter { $0 != "test" }
        XCTAssertNil(newMonitor["test"])
    }

}
