//
//  URLSessionLayerBase.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/11/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class QHNetworkRequestFactoryTestCase: XCTestCase {

    func getResponse(statusCode: Int) -> HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "www.google.com")!,
                                                   statusCode: statusCode,
                                                   httpVersion: "1.1",
                                                   headerFields: nil)!
    }
    
    var getDataModelSample: Data {
        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
        if let encodedData = try? JSONEncoder().encode(dataModel) {
            return encodedData
        }
        return Data()
    }
    
    let fakeURLRequest = URLRequest(url: URL(fileURLWithPath: ""))
    
    var getArrayModelSample: Data {
        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
        let dataModel2 = DataModel(name: "dani", nick: "sp1", age: 13)
        let array = [dataModel,dataModel2]
        if let encodedData = try? JSONEncoder().encode(array) {
            return encodedData
        }
        return Data()
    }
    
    func getURLSessionLayer(urlSession: URLSessionProtocol, unauthorizedCode: Int = 401) -> QHRequestFactory {
        let urlSessionLayer = QHRequestFactory(urlSession: urlSession, unauthorizedCode: unauthorizedCode, logger: log)
        return urlSessionLayer
    }
    
    func getSessionMock(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) -> URLSessionProtocol {
        return URLSessionProtocolMock(data: data, error: error ,urlResponse: response)
    }

}
