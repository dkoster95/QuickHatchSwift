//
//  HeadMethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 9/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
// swiftlint:disable force_try
// swiftlint:disable force_cast
class HeadMethodTests: URLRequest_MethodTests {
    // HEAD method tests
    
    func testHeadRequest() {
        let request = try! URLRequest.head(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "HEAD")
    }
    
    func testHeadRequestWithURLString() {
        let request = try! URLRequest.head(url: "www.quickhatch.com", encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "HEAD")
    }
    
    func testHeadRequestWithParams() {
        let request = try! URLRequest.head(url: commonURl, params: ["age": 12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "HEAD")
        XCTAssertNil(request.httpBody)
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)?age=12")
    }
    
    func testHeadRequestWithParamsAndHeaders() {
        let request = try! URLRequest.head(url: commonURl,
                                           params: ["age": 12, "name": "quickhatch"],
                                           encoding: URLEncoding(destination: .httpBody),
                                           headers: ["auth": "123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "HEAD")
    }
    
    func testHeadRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.head(url: commonURl,
                                           params: ["age": 12, "name": "quickhatch"],
                                           encoding: JSONEncoding.default,
                                           headers: ["auth": "123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "HEAD")
    }

}
