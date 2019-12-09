//
//  URLSessionLayerTests.swift
//  NetworkingLayerTests
//
//  Created by Daniel Koster on 6/5/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class URLSessionLayerTests: URLSessionLayerBase {

    func testUnauthorizedResponseUsingCodableObject() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.object(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
            (result: Result<Response<DataModel>, Error>) in
            switch result {
            case .success( _):
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .unauthorized)
                }
                else {
                    XCTAssert(false)
                }
            }
        }.resume()
    }
    func testUnauthorizedResponseUsingDataObject() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.data(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
            (result: Result<Response<Data>, Error>) in
            switch result {
            case .success( _):
                XCTAssert(false)
            case .failure(let error):
                XCTAssertTrue(error.isUnauthorized)
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .unauthorized)
                }
                else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testSerializationError() {
        let data = try! JSONSerialization.data(withJSONObject: ["name": "hey"], options: .prettyPrinted)
        let dataURLSession = URLSessionMock(data: data, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        urlSessionLayer.array(request: URLRequest(url: URL(fileURLWithPath: ""))) { (result: Result<Response<[DataModel]>, Error>) in
            switch result {
            case .failure(let error):
                if let reqError = error as? RequestError {
                    XCTAssert(reqError == RequestError.serializationError)
                }
            case .success( _):
                XCTAssert(false)
            }
        }.resume()
    }
    
    func testSuccessFullDataUsingArray() {
        let fakeUrlSession = URLSessionMock(data: self.getArrayModelSample, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
        urlSessionLayer.array(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
            (result: Result<Response<Array<DataModel>>, Error>) in
            switch result {
            case .success(let dataModel):
                XCTAssert(dataModel.data.count == 2)
                XCTAssert(dataModel.data[0].age! == 12)
            case .failure(_):
                XCTAssert(false)
            }
            }.resume()
    }
    
    func testUnauthorizedResponseUsingDataArray() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.array(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
            (result: Result<Response<[DataModel]>, Error>) in
            switch result {
            case .success( _):
                XCTAssert(false)
            case .failure(let error):
                XCTAssertTrue(error.isUnauthorized)
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .unauthorized)
                }
                else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
}
