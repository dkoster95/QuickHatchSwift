//
//  GetMethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 9/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
// swiftlint:disable force_try
class GetMethodTests: URLRequest_MethodTests {
    // Get method Tests

    func testGetRequest() {
        let request = try! URLRequest.get(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    func testGetRequestWithString() {
        let request = try! URLRequest.get(url: "www.quickhatch.com", encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    func testGetRequestWithStringError() {
        XCTAssertThrowsError(try URLRequest.get(url: "@#$%^||||???", encoding: URLEncoding.default))
    }
    
    func testGetRequestWithParams() {
        let request = try! URLRequest.get(url: commonURl,
                                          params: ["age": 12],
                                          encoding: URLEncoding.queryString,
                                          headers: [:])
        print("\(commonURl.absoluteString)?age=12")
        XCTAssertTrue(request.httpMethod == "GET")
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)?age=12")
    }
    
    func testGetRequestWithParamsAndHeaders() {
        let request = try! URLRequest.get(url: commonURl,
                                          params: ["age": 12, "name": "quickhatch"],
                                          encoding: URLEncoding.default,
                                          headers: ["auth": "123"])
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)?age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    func testGetRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.get(url: commonURl,
                                          params: ["age": 12, "name": "quickhatch"],
                                          encoding: JSONEncoding.default,
                                          headers: ["auth": "123"])
        print(request.url!.absoluteString)
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    func testGetRequestWithParamsJsonEncodingPrettyPrinted() {
        let request = try! URLRequest.get(url: commonURl,
                                          params: ["age": 12, "name": "quickhatch"],
                                          encoding: JSONEncoding.prettyPrinted,
                                          headers: ["auth": "123"])
        print(request.url!.absoluteString)
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "GET")
    }

}
