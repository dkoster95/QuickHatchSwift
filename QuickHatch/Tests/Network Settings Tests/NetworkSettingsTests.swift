//
//  NetworkSettingsTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/13/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import XCTest
import QuickHatch

class NetworkSettingsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkEnvironment() {
        let genericNetworkEnv = GenericHostEnvironment(headers: [:], baseURL: "www.quickhatch.com")
        XCTAssertTrue(genericNetworkEnv.baseURL == "www.quickhatch.com")
    }
    
    func testServerSettingsQA() {
        let mock = MockServer()
        XCTAssertTrue(mock.headers["Framework"] == "quickhatch")
        XCTAssertTrue(Environment.qa.getCurrentEnvironment(server: mock).baseURL == "www.quickhatch.com/qa")
    }
    
    func testServerSettingsProd() {
        let mock = MockServer()
        XCTAssertTrue(mock.headers["Framework"] == "quickhatch")
        XCTAssertTrue(Environment.production.getCurrentEnvironment(server: mock).baseURL == "www.quickhatch.com/prod")
    }
    
    func testServerSettingsStaging() {
        let mock = MockServer()
        XCTAssertTrue(mock.headers["Framework"] == "quickhatch")
        XCTAssertTrue(Environment.staging.getCurrentEnvironment(server: mock).baseURL == "www.quickhatch.com/stg")
    }

}
