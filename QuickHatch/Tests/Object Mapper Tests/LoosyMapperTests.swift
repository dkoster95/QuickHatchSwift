//
//  LoosyMapperTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/15/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class LoosyMapperTests: XCTestCase {

    let object: [String: Any] = ["name": "dan",
                  "age": 12]
    var array:[Any] { return [object,object] }
    
    func testGenericObjectRelationalMapper() {
        let obj = ObjectRelationalMapper(JSON: [:])
        XCTAssert(obj.toJSON.isEmpty)
    }
    
    func testObjectMapping() {
        let objectMapped = LoosyMapper<DataTest>().mapObject(dict: object)
        XCTAssert(objectMapped!.name == "dan")
    }
    
    func testToJSONMapping() {
        let objectMapped = LoosyMapper<DataTest>().mapObject(dict: object)
        let toJSON = objectMapped!.toJSON
        XCTAssert((toJSON["name"] as! String) == "dan")
        XCTAssert((toJSON["age"] as! Int) == 12)
    }
    
    func testObjectMappingError() {
        let objectMapped = LoosyMapper<DataTest>().mapObject(dict: "object")
        XCTAssertNil(objectMapped)
    }
    
    func testArrayMapping() {
        let arrayMapped = LoosyMapper<DataTest>().mapArray(dict: array)
        XCTAssert(!arrayMapped.isEmpty)
    }
    
    func testArrayMappingError() {
        let arrayMapped = LoosyMapper<DataTest>().mapArray(dict: "array")
        XCTAssert(arrayMapped.isEmpty)
    }
    
    func testToJSONArrayMapping() {
        let arrayMapped = LoosyMapper<DataTest>().mapArray(dict: array)
        XCTAssert(LoosyMapper<DataTest>().toJSONArray(array: arrayMapped).count == 2)
    }

}
