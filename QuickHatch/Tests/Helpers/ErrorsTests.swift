//
//  ErrorsTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/11/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class ErrorsTests: XCTestCase {

    func testUnAuthorizedError() {
        let error = RequestError.unauthorized
        XCTAssertTrue(error.isUnauthorized)
    }
    
    func testUnAuthorizedErrorFailed() {
        let error = RequestError.cancelled
        XCTAssertFalse(error.isUnauthorized)
    }
    
    func testUnAuthorizedErrorFalse() {
        let error = NSError(domain: "error", code: 20100, userInfo: nil)
        XCTAssertFalse(error.isUnauthorized)
    }

}
