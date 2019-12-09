//
//  URLSessionDataTasksTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/15/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import XCTest
import QuickHatch

class URLSessionDataTasksTests: XCTestCase {

    func testAuthorizedError() {
        let error = RequestError.cancelled
        XCTAssert(!error.isUnauthorized)
    }
    
    func testUnauthorizedError() {
        let error = RequestError.unauthorized
        XCTAssert(error.isUnauthorized)
    }
    
    func testRequestWasCancelled() {
        let error = NSError(domain: "", code: -999, userInfo: nil)
        XCTAssert(error.requestWasCancelled)
    }
    
    func testRequestWasCancelledFail() {
        let error = NSError(domain: "", code: -99, userInfo: nil)
        XCTAssert(!error.requestWasCancelled)
    }
    
    func testHTTPStatusCode() {
        let httpStatus = 200
        XCTAssertNotNil(HTTPStatusCode(rawValue: httpStatus))
    }
    
    func testHTTPStatusCodeIsSuccess() {
        let httpStatus = 200
        let status = HTTPStatusCode(rawValue: httpStatus)!
        XCTAssert(status.isSuccess)
    }
    
    func testHTTPStatusCodeIsInfo() {
        let httpStatus = 100
        let status = HTTPStatusCode(rawValue: httpStatus)!
        XCTAssert(status.isInformational)
    }
    
    func testHTTPStatusCodeIsClientError() {
        let httpStatus = 404
        let status = HTTPStatusCode(rawValue: httpStatus)!
        XCTAssert(status.isClientError)
    }
    
    func testHTTPStatusCodeIsServer() {
        let httpStatus = 500
        let status = HTTPStatusCode(rawValue: httpStatus)!
        XCTAssert(status.isServerError)
        print(status.description)
        XCTAssert(status.description == "500 - internal server error")
        XCTAssert(status.debugDescription == "HTTPStatusCode:500 - internal server error")
    }
    
    func testHTTPStatusCodeIsRedirection() {
        let httpStatus = 300
        let status = HTTPStatusCode(rawValue: httpStatus)!
        XCTAssert(status.isRedirection)
    }

}
