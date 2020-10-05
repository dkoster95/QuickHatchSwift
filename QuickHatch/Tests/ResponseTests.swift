//
//  ResponseTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 3/30/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
@testable import QuickHatch

class ResponseTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private var defaultResponse: URLResponse {
        return HTTPURLResponse(url: URL(string: "www.quickhatch.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }

    func testResponse() {
        let response = Response<Int>(data: 2, httpResponse: defaultResponse)
        XCTAssert(response.data == 2)
    }
    
    func testMapResponse() {
        let response = Response<Int>(data: 2, httpResponse: defaultResponse).map { return $0.description }
        XCTAssert(response.data == "2")
    }
    
    func testFilterResponse() {
        let response = Response<Int>(data: 2, httpResponse: defaultResponse).filter { return $0 % 2 == 0 }
        XCTAssertNotNil(response.data)
    }
    
    func testFlatMapResponse() {
        let response = Response<Int>(data: 2, httpResponse: defaultResponse)
            .flatMap { return Response<(String,Int)>(data: ($0.description, $0), httpResponse: defaultResponse) }
        XCTAssert(response.data.0 == "2")
        XCTAssert(response.data.1 == 2)
    }

}
