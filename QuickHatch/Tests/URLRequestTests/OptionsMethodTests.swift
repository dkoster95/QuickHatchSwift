//
//  OptionsMethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 9/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch
// swiftlint:disable force_try
// swiftlint:disable force_cast
class OptionsMethodTests: URLRequest_MethodTests {
    // OPTIONS Method tests
    
    func testOptionsRequest() {
        let request = try! URLRequest.options(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "OPTIONS")
    }
    
    func testOptionsRequestWithURLString() {
        let request = try! URLRequest.options(url: "www.quickhatch.com", encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "OPTIONS")
    }
    
    func testOptionsRequestWithParams() {
        let request = try! URLRequest.options(url: commonURl,
                                              params: ["age": 12],
                                              encoding: URLEncoding.default,
                                              headers: [:])
        XCTAssertTrue(request.httpMethod == "OPTIONS")
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12")
    }
    
    func testOptionsRequestWithParamsAndHeaders() {
        let request = try! URLRequest.options(url: commonURl,
                                              params: ["age": 12, "name": "quickhatch"],
                                              encoding: URLEncoding(destination: .httpBody),
                                              headers: ["auth": "123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "OPTIONS")
    }
    
    func testOptionsRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.options(url: commonURl,
                                              params: ["age": 12, "name": "quickhatch"],
                                              encoding: JSONEncoding.default,
                                              headers: ["auth": "123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "OPTIONS")
    }

}
