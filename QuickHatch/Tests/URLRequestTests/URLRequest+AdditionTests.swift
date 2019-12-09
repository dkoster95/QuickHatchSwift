//
//  URLRequest+AdditionTests.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/13/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

@testable import QuickHatch
import XCTest

class URLRequest_AdditionTests: XCTestCase {
    
    let commonURl: URL = URL(string: "www.quickhatch.com")!
    
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
}
