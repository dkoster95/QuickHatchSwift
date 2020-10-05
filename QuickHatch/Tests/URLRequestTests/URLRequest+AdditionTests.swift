//
//  URLRequest+AdditionTests.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/13/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

@testable import QuickHatch
import XCTest
// swiftlint:disable force_try
// swiftlint:disable force_cast
class URLRequest_AdditionTests: URLRequest_MethodTests {
    
    func testAddHeader() {
        var request = URLRequest(url: commonURl, method: .get)
        request.allHTTPHeaderFields = Headers.defaultHTTPHeaders
        request.allHTTPHeaderFields!["User-Agent"] = nil
        request.addHeader(value: "quickhatch", key: "Framework")
        print(request.allHTTPHeaderFields!)
        XCTAssertTrue(request.allHTTPHeaderFields!["Framework"] == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["Accept-Encoding"] == "gzip;q=1.0, compress;q=0.5")
        XCTAssertTrue(request.allHTTPHeaderFields!["Accept-Language"] == "en;q=1.0")
    }
    
    func testAuthenticate() {
        var request = URLRequest(url: commonURl, method: .get)
        let auth = MockAuthentication()
        request = auth.authorize(request: request)
        print(request.allHTTPHeaderFields!)
        XCTAssertTrue(request.allHTTPHeaderFields!["Authorization"] == "Auth 12312")
    }
    
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
        XCTAssertTrue(dicBody["age"] as? Int == 12)
        XCTAssertTrue(dicBody["name"] as? String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "TRACE")
    }
}
