//
//  URLSessionLayerBase.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/11/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class URLSessionLayerBase: XCTestCase {

    func getResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: URL(string:"www.google.com")!,
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
    
    func getURLSessionLayer(urlSession: URLSession, unauthorizedCode: Int = 401) -> QHRequestFactory{
        let urlSessionLayer = QHRequestFactory(urlSession: urlSession, unauthorizedCode: unauthorizedCode)
        urlSessionLayer.log(with: log)
        return urlSessionLayer
    }

}
