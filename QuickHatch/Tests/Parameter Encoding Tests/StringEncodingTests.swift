//
//  StringEncodingTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/14/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class StringEncodingTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringEncoding() {
        let urlString = EncodingHelpers.escape("www.quickhatch.com/{name}")
        print(urlString)
        let urlRequest = URLRequest(url: URL(string: urlString)!, method: .get)
        let stringEncoding = StringEncoding()
        let requestResult = try! stringEncoding.encode(urlRequest,
                                                  with: ["name": "dani"])
        XCTAssertTrue(requestResult.url!.absoluteString == "www.quickhatch.com/dani")
    }
    
    func testStringEncodingNoParams() {
        let urlString = EncodingHelpers.escape("www.quickhatch.com/{name}")
        print(urlString)
        let urlRequest = URLRequest(url: URL(string: urlString)!, method: .get)
        let stringEncoding = StringEncoding()
        let requestResult = try! stringEncoding.encode(urlRequest,
                                                       with: [:])
        XCTAssertTrue(requestResult.url!.absoluteString == EncodingHelpers.escape("www.quickhatch.com/{name}"))
    }
    
    func testStringEncodingManyParameters() {
        let urlString = EncodingHelpers.escape("www.quickhatch.com/{name}/{age}")
        print(urlString)
        let urlRequest = URLRequest(url: URL(string: urlString)!, method: .get)
        let stringEncoding = StringEncoding()
        let requestResult = try! stringEncoding.encode(urlRequest,
                                                       with: ["name": "dani","age": 13])
        XCTAssertTrue(requestResult.url!.absoluteString == "www.quickhatch.com/dani/13")
    }
    
    func testStringEncodingManyParametersAndHeaders() {
        let urlString = EncodingHelpers.escape("www.quickhatch.com/{name}/{age}")
        print(urlString)
        var urlRequest = URLRequest(url: URL(string: urlString)!, method: .get)
        urlRequest.addHeader(value: "header", key: "header")
        let stringEncoding = StringEncoding.urlEncoding
        let requestResult = try! stringEncoding.encode(urlRequest,
                                                       with: ["name": "dani","age": 13])
        XCTAssertTrue(requestResult.url!.absoluteString == "www.quickhatch.com/dani/13")
        XCTAssertTrue(requestResult.allHTTPHeaderFields!["header"] == "header")
    }
    
    func testStringEncodingError() {
        var urlRequest = URLRequest(url: URL(string: "www.quickhatch.com")!)
        urlRequest.url = nil
        let stringEncoding = StringEncoding()
        do {
            _ = try stringEncoding.encode(urlRequest,
                                                       with: ["name": "dani","age": 13])
        } catch _ {
            XCTAssertTrue(true)
        }
        
    }
    
    func testStringEncodingManyBodyParametersAndHeaders() {
        let urlString = EncodingHelpers.escape("www.quickhatch.com/{name}/{age}")
        print(urlString)
        var urlRequest = URLRequest(url: URL(string: urlString)!, method: .get)
        urlRequest.addHeader(value: "header", key: "header")
        let stringEncoding = StringEncoding.bodyEncoding
        let requestResult = try! stringEncoding.encode(urlRequest,
                                                       with: ["name": "dani","age": 13])
        let body = String(data: requestResult.httpBody!, encoding: .utf8)
        let split = body!.split(separator: "&")
        XCTAssertTrue(split.count == 2)
        XCTAssertTrue(split.contains("dani"))
        XCTAssertTrue(split.contains("13"))
        XCTAssertTrue(requestResult.allHTTPHeaderFields!["header"] == "header")
    }
    
    func testStringEncodingBodyParametersAndHeaders() {
        let urlString = EncodingHelpers.escape("www.quickhatch.com/{name}/{age}")
        print(urlString)
        var urlRequest = URLRequest(url: URL(string: urlString)!, method: .get)
        urlRequest.addHeader(value: "header", key: "header")
        let stringEncoding = StringEncoding.bodyEncoding
        let requestResult = try! stringEncoding.encode(urlRequest,
                                                       with: ["age": 13])
        let body = String(data: requestResult.httpBody!, encoding: .utf8)
        let split = body!.split(separator: "&")
        XCTAssertTrue(split.count == 1)
        XCTAssertTrue(split.contains("13"))
        XCTAssertTrue(requestResult.allHTTPHeaderFields!["header"] == "header")
    }
    
    func testStringEncodingBodyNoParametersAndHeaders() {
        let urlString = EncodingHelpers.escape("www.quickhatch.com/{name}/{age}")
        print(urlString)
        var urlRequest = URLRequest(url: URL(string: urlString)!, method: .get)
        urlRequest.addHeader(value: "header", key: "header")
        let stringEncoding = StringEncoding.bodyEncoding
        let requestResult = try! stringEncoding.encode(urlRequest,
                                                       with: [:])
        XCTAssertNil(requestResult.httpBody)
        XCTAssertTrue(requestResult.allHTTPHeaderFields!["header"] == "header")
    }

}
