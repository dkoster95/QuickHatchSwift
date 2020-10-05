//
//  PutMethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 9/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import QuickHatch
import XCTest
// swiftlint:disable force_try
// swiftlint:disable force_cast
class PutMethodTests: URLRequest_MethodTests {
    // PUT methods tests
    
    func testPutRequest() {
        let request = try! URLRequest.put(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "PUT")
    }
    
    func testPutRequestWithURLString() {
        let request = try! URLRequest.put(url: "www.quickhatch.com", encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "PUT")
    }
    
    func testPutRequestWithParams() {
        let request = try! URLRequest.put(url: commonURl,
                                          params: ["age": 12],
                                          encoding: URLEncoding.default,
                                          headers: [:])
        XCTAssertTrue(request.httpMethod == "PUT")
        XCTAssertTrue(String(data: request.httpBody!, encoding: .utf8) == "age=12")
    }
    
    func testPutRequestWithParamsAndHeaders() {
        let request = try! URLRequest.put(url: commonURl,
                                          params: ["age": 12, "name": "quickhatch"],
                                          encoding: URLEncoding.default,
                                          headers: ["auth": "123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PUT")
    }
    
    func testPutRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.put(url: commonURl,
                                          params: ["age": 12, "name": "quickhatch"],
                                          encoding: JSONEncoding.default,
                                          headers: ["auth": "123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PUT")
    }

}
