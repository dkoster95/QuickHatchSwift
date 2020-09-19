//
//  URLSessionLayer+ObjectTests.swift
//  QuickHatch
//
//  Created by Daniel Koster on 10/18/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch
import XCTest

class URLSessionLayer_ObjectTests: URLSessionLayerBase {
    
    func testFailureSerializationDataUsingObject() {
        let fakeUrlSession = URLSessionMock(data: self.getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
        urlSessionLayer.response(request: URLRequest(url: URL(string: "www.google.com")!,
                                                     method: .get)) { (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .serializationError(error: RequestError.unauthorized))
                } else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testSerializationError() {
        let data = try! JSONSerialization.data(withJSONObject: ["name": "hey"], options: .prettyPrinted)
        let dataURLSession = URLSessionMock(data: data, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        urlSessionLayer.response(request: URLRequest(url: URL(fileURLWithPath: ""))) { (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .failure(let error):
                if let reqError = error as? RequestError {
                    XCTAssert(reqError == RequestError.serializationError(error: RequestError.unauthorized))
                }
            case .success:
                XCTAssert(false)
            }
        }.resume()
    }
    
    func testSuccessFullDataUsingObject() {
        let fakeUrlSession = URLSessionMock(data: self.getDataModelSample, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
        urlSessionLayer.response(request: URLRequest(url: URL(string: "www.google.com")!,
                                                     method: .get)) { (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success(let dataModel):
                XCTAssert(dataModel.data.age! == 12)
            case .failure:
                    XCTAssert(false)
            }
            }.resume()
    }
    func testUnknownErrorUsingStringObject() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 524))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.response(request: URLRequest(url: URL(string: "www.google.com")!,
                                                     method: .get)) { (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .unknownError(statusCode: 524))
                } else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testCancelledError() {
        let dataURLSession = URLSessionMock(error: NSError(domain: "", code: -999, userInfo: nil), urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        urlSessionLayer.response(request: URLRequest(url: URL(fileURLWithPath: ""))) { (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .failure(let error):
                if let reqError = error as? RequestError {
                    XCTAssert(reqError == RequestError.cancelled)
                }
            case .success:
                XCTAssert(false)
            }
            }.resume()
    }
    
}
