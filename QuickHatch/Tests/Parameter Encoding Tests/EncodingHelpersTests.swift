//
//  EncodingHelpersTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/14/19.
//  Copyright © 2019 Daniel Koster. All rights reserved.
//

import XCTest
import QuickHatch

class EncodingHelpersTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testQueryComponentsWithBool() {
        let bool: Bool = true
        let result = EncodingHelpers.queryComponents(fromKey: "boolValue", value: bool)
        XCTAssertTrue(result[0].0 == "boolValue")
        XCTAssertTrue(result[0].1 == "1")
    }
    
    func testQueryComponentsWithBoolFalse() {
        let bool: Bool = false
        let result = EncodingHelpers.queryComponents(fromKey: "boolValue", value: bool)
        XCTAssertTrue(result[0].0 == "boolValue")
        XCTAssertTrue(result[0].1 == "0")
    }
    
    func testQueryComponentsWithInt() {
        let int = 2
        let result = EncodingHelpers.queryComponents(fromKey: "intValue", value: int)
        XCTAssertTrue(result[0].0 == "intValue")
        XCTAssertTrue(result[0].1 == "2")
    }
    
    func testQueryComponentsWithString() {
        let string = "quickhatch"
        let result = EncodingHelpers.queryComponents(fromKey: "stringValue", value: string)
        XCTAssertTrue(result[0].0 == "stringValue")
        XCTAssertTrue(result[0].1 == "quickhatch")
    }
    
    func testQueryComponentsWithArray() {
        let string = "quickhatch"
        let int = 2
        let array = [string,int] as [Any]
        let result = EncodingHelpers.queryComponents(fromKey: "arrayValue", value: array)
        XCTAssertTrue(result[0].0 == "arrayValue")
        XCTAssertTrue(result[0].1 == "quickhatch")
        XCTAssertTrue(result[1].0 == "arrayValue")
        XCTAssertTrue(result[1].1 == "2")
    }
    
    func testQueryComponentsWithDic() {
        let string = "quickhatch"
        let int = 2
        let dic = ["string":string,"int":int] as [String: Any]
        let result = EncodingHelpers.queryComponents(fromKey: "dicValue", value: dic)
        print(result)
        let containsString = !result.filter({
            return $0 == EncodingHelpers.escape("dicValue[string]") && $1 == "quickhatch"
        }).isEmpty
        let containsInt = !result.filter({
            return $0 == EncodingHelpers.escape("dicValue[int]") && $1 == "2"
        }).isEmpty
        XCTAssertTrue(containsString && containsInt)
    }
    
    func testEscapedString() {
        let expected = "%5Bint%5D"
        XCTAssertTrue(EncodingHelpers.escape("[int]") == expected)
    }
    
    func testBoolStringValue() {
        let bool = false
        XCTAssert(bool.stringValue == "false")
    }
    
    func testBoolStringValueTrue() {
        let bool = true
        XCTAssert(bool.stringValue == "true")
    }

    func testBoolIntValueTrue() {
        let bool = true
        XCTAssert(bool.intValue == 1)
    }
    
    func testBoolIntValueFalse() {
        let bool = false
        XCTAssert(bool.intValue == 0)
    }
}
