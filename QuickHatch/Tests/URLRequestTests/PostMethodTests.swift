//
//  PostMethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 9/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
// swiftlint:disable force_try
// swiftlint:disable force_cast
class PostMethodTests: URLRequest_MethodTests {
    // POST method Tests
    
    func testPostRequest() {
        let request = try! URLRequest.post(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "POST")
    }
    
    func testPostRequestWithURLString() {
        let request = try! URLRequest.post(url: "www.quickhatch.com", encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "POST")
    }
    
    func testPostRequestWithParams() {
        let request = try! URLRequest.post(url: commonURl, params: ["age": 12], encoding: URLEncoding.httpBody, headers: [:])
        XCTAssertTrue(request.httpMethod == "POST")
        XCTAssertTrue(String(data: request.httpBody!, encoding: .utf8) == "age=12")
    }
    
    func testPostRequestWithParamsAndHeaders() {
        let request = try! URLRequest.post(url: commonURl,
                                           params: ["age": 12, "name": "quickhatch"],
                                           encoding: URLEncoding.default,
                                           headers: ["auth": "123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "POST")
    }
    
    func testPostRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.post(url: commonURl,
                                           params: ["age": 12, "name": "quickhatch"],
                                           encoding: JSONEncoding.default,
                                           headers: ["auth": "123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "POST")
    }

}
