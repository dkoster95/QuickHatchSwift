//
//  URLRequest+MethodTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/13/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import XCTest
import QuickHatch

class URLRequest_MethodTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let commonURl: URL = URL(string: "www.quickhatch.com")!
    
    // Get method Tests

    func testGetRequest() {
        let request = try! URLRequest.get(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    func testGetRequestWithParams() {
        let request = try! URLRequest.get(url: commonURl, params: ["age":12], encoding: URLEncoding.queryString, headers: [:])
        print("\(commonURl.absoluteString)?age=12")
        XCTAssertTrue(request.httpMethod == "GET")
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)?age=12")
    }
    
    func testGetRequestWithParamsAndHeaders() {
        let request = try! URLRequest.get(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding.default, headers: ["auth":"123"])
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)?age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    func testGetRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.get(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        print(request.url!.absoluteString)
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    func testGetRequestWithParamsJsonEncodingPrettyPrinted() {
        let request = try! URLRequest.get(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.prettyPrinted, headers: ["auth":"123"])
        print(request.url!.absoluteString)
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "GET")
    }
    
    // POST method Tests
    
    func testPostRequest() {
        let request = try! URLRequest.post(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "POST")
    }
    
    func testPostRequestWithParams() {
        let request = try! URLRequest.post(url: commonURl, params: ["age":12], encoding: URLEncoding.httpBody, headers: [:])
        XCTAssertTrue(request.httpMethod == "POST")
        XCTAssertTrue(String(data: request.httpBody!, encoding: .utf8) == "age=12")
    }
    
    func testPostRequestWithParamsAndHeaders() {
        let request = try! URLRequest.post(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding.default, headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "POST")
    }
    
    func testPostRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.post(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "POST")
    }
    
    // PUT methods tests
    
    func testPutRequest() {
        let request = try! URLRequest.put(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "PUT")
    }
    
    func testPutRequestWithParams() {
        let request = try! URLRequest.put(url: commonURl, params: ["age":12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "PUT")
        XCTAssertTrue(String(data: request.httpBody!, encoding: .utf8) == "age=12")
    }
    
    func testPutRequestWithParamsAndHeaders() {
        let request = try! URLRequest.put(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding.default, headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PUT")
    }
    
    func testPutRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.put(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PUT")
    }
    
    // Patch method Tests
    
    func testPatchRequest() {
        let request = try! URLRequest.patch(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "PATCH")
    }
    
    func testPatchRequestWithParams() {
        let request = try! URLRequest.patch(url: commonURl, params: ["age":12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "PATCH")
        XCTAssertTrue(String(data: request.httpBody!, encoding: .utf8) == "age=12")
    }
    
    func testPatchRequestWithParamsAndHeaders() {
        let request = try! URLRequest.patch(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding.default, headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PATCH")
    }
    
    func testPatchRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.patch(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "PATCH")
    }
    
    //DELETE Method Tests
    
    func testDeleteRequest() {
        let request = try! URLRequest.delete(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "DELETE")
    }
    
    func testDeleteRequestWithParams() {
        let request = try! URLRequest.delete(url: commonURl, params: ["age":12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "DELETE")
        XCTAssertNil(request.httpBody)
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)?age=12")
    }
    
    func testDeleteRequestWithParamsAndHeaders() {
        let request = try! URLRequest.delete(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding(destination: .httpBody), headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "DELETE")
    }
    
    func testDeleteRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.delete(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "DELETE")
    }
    
    // HEAD method tests
    
    func testHeadRequest() {
        let request = try! URLRequest.head(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "HEAD")
    }
    
    func testHeadRequestWithParams() {
        let request = try! URLRequest.head(url: commonURl, params: ["age":12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "HEAD")
        XCTAssertNil(request.httpBody)
        XCTAssertTrue(request.url!.absoluteString == "\(commonURl.absoluteString)?age=12")
    }
    
    func testHeadRequestWithParamsAndHeaders() {
        let request = try! URLRequest.head(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding(destination: .httpBody), headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "HEAD")
    }
    
    func testHeadRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.head(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "HEAD")
    }
    
    // Connect method tests
    
    func testConnectRequest() {
        let request = try! URLRequest.connect(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "CONNECT")
    }
    
    func testConnectRequestWithParams() {
        let request = try! URLRequest.connect(url: commonURl, params: ["age":12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "CONNECT")
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12")
    }
    
    func testConnectRequestWithParamsAndHeaders() {
        let request = try! URLRequest.connect(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding(destination: .httpBody), headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "CONNECT")
    }
    
    func testConnectRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.connect(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "CONNECT")
    }
    
    // Trace method tests
    
    func testTraceRequest() {
        let request = try! URLRequest.trace(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "TRACE")
    }
    
    func testTraceRequestWithParams() {
        let request = try! URLRequest.trace(url: commonURl, params: ["age":12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "TRACE")
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12")
    }
    
    func testTraceRequestWithParamsAndHeaders() {
        let request = try! URLRequest.trace(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding(destination: .httpBody), headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "TRACE")
    }
    
    func testTraceRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.trace(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "TRACE")
    }
    
    // OPTIONS Method tests
    
    func testOptionsRequest() {
        let request = try! URLRequest.options(url: commonURl, encoding: URLEncoding.default)
        XCTAssertTrue(request.url!.absoluteString == commonURl.absoluteString)
        XCTAssertTrue(request.httpMethod == "OPTIONS")
    }
    
    func testOptionsRequestWithParams() {
        let request = try! URLRequest.options(url: commonURl, params: ["age":12], encoding: URLEncoding.default, headers: [:])
        XCTAssertTrue(request.httpMethod == "OPTIONS")
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12")
    }
    
    func testOptionsRequestWithParamsAndHeaders() {
        let request = try! URLRequest.options(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: URLEncoding(destination: .httpBody), headers: ["auth":"123"])
        let body = String(data: request.httpBody!, encoding: .utf8)
        XCTAssertTrue(body == "age=12&name=quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "OPTIONS")
    }
    
    func testOptionsRequestWithParamsJsonEncoding() {
        let request = try! URLRequest.options(url: commonURl, params: ["age":12, "name": "quickhatch"], encoding: JSONEncoding.default, headers: ["auth":"123"])
        let dicBody = try! JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as! [String: Any]
        XCTAssertTrue(dicBody["age"] as! Int == 12)
        XCTAssertTrue(dicBody["name"] as! String == "quickhatch")
        XCTAssertTrue(request.allHTTPHeaderFields!["auth"] == "123")
        XCTAssertTrue(request.httpMethod == "OPTIONS")
    }
    

}
