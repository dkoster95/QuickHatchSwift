//
//  CommandTestBase.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/16/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import XCTest
import QuickHatch

class CommandTestBase: XCTestCase {
    func getResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "www.quickhatch.com")!,
                               statusCode: statusCode,
                               httpVersion: "1.1",
                               headerFields: nil)!
    }
    
    var getDataModelSample: Data {
        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
        return try! JSONEncoder().encode(dataModel)
    }
    
    var getArrayModelSample: Data {
        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
        let dataModel2 = DataModel(name: "dani", nick: "sp1", age: 13)
        let array = [dataModel,dataModel2]
        return try! JSONEncoder().encode(array)
    }
    
    func buildRequest() -> URLRequest {
        return try! URLRequest.get(url: URL(fileURLWithPath: ""),
                              encoding: URLEncoding.default)
    }
}
