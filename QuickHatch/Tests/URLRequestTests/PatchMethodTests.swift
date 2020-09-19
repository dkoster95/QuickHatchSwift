//
//  PatchMethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 9/17/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class PatchMethodTests: URLRequest_MethodTests {
    // Patch method Tests
    
    func testPatchRequest() {
        let request = try! URLRequest.patch(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "PATCH")
    }
    
    func testPatchRequestWithURLString() {
        let request = try! URLRequest.patch(url: "www.quickhatch.com", encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "PATCH")
    }
    
    func testPatchRequestWithParams() {
        let request = try! URLRequest.patch(url: commonURl,
                                            params: ["age": 12],
                                            encoding: URLEncoding.default,
                                            headers: [:])
        XCTAssertTrue(request.httpMethod == "PATCH")
        XCTAssertTrue(String(data: request.httpBody!, encoding: .utf8) == "age=12")
    }
    
    func testPatchRequestWithParamsAndHeaders() {
        let request = try! URLRequest.patch(url: commonURl,
                                            params: ["age": 12, "name": "quickhatch"],
                                            encoding: URLEncoding.default,
                                            headers: ["auth": "123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PATCH")
    }
    
    func testPatchRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.patch(url: commonURl,
                                            params: ["age": 12, "name": "quickhatch"],
                                            encoding: JSONEncoding.default,
                                            headers: ["auth": "123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PATCH")
    }

}
