//
//  TraceMethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 9/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
class TraceMethodTests: URLRequest_MethodTests {

    // Trace method tests
    
    func testTraceRequest() {
        let request = try! URLRequest.trace(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "TRACE")
    }
    
    func testTraceRequestWithURLString() {
        let request = try! URLRequest.trace(url: "www.quickhatch.com", encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "TRACE")
    }
    
    func testTraceRequestWithParams() {
        let request = try! URLRequest.trace(url: commonURl, params: ["age": 12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "TRACE")
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12")
    }
    
    func testTraceRequestWithParamsAndHeaders() {
        let request = try! URLRequest.trace(url: commonURl,
                                            params: ["age": 12, "name": "quickhatch"],
                                            encoding: URLEncoding(destination: .httpBody),
                                            headers: ["auth": "123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "TRACE")
    }
    
    func testTraceRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.trace(url: commonURl,
                                            params: ["age": 12, "name": "quickhatch"],
                                            encoding: JSONEncoding.default,
                                            headers: ["auth": "123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "TRACE")
    }

}
