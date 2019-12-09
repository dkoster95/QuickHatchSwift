//
//  QuickHatch_AlamofireTests.swift
//  QuickHatch+AlamofireTests
//
//  Created by Daniel Koster on 8/9/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch_Alamofire
import Alamofire
import QuickHatch

class URLSessionLayerTests: XCTestCase {
    
//    fileprivate func getResponse(statusCode: Int) -> HTTPURLResponse {
//        return HTTPURLResponse(url: URL(string:"www.google.com")!,
//                               statusCode: statusCode,
//                               httpVersion: "1.1",
//                               headerFields: nil)!
//    }
//
//    var getDataModelSample: Data {
//        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
//        return try! JSONEncoder().encode(dataModel)
//    }
//
//    var getArrayModelSample: Data {
//        let dataModel = DataModel(name: "dan", nick: "sp", age: 12)
//        let dataModel2 = DataModel(name: "dani", nick: "sp1", age: 13)
//        let array = [dataModel,dataModel2]
//        return try! JSONEncoder().encode(array)
//    }
//
//    private func getURLSessionLayer(urlSession: URLSession, unauthorizedCode: Int = 401) -> AlamofireRequestFactory {
//        let session = Alamofire.Session(session: urlSession, delegate: SessionDelegate(), rootQueue: .main)
//        let urlSessionLayer = AlamofireRequestFactory(alamofireSession: session)
//        urlSessionLayer.log(with: QuickHatch.log)
//        return urlSessionLayer
//    }
//
//    func testUnauthorizedResponseUsingCodableObject() {
//        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
//        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
//        urlSessionLayer.object(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<DataModel, Error>) in
//            switch result {
//            case .success( _):
//                XCTAssert(false)
//            case .failure(let error):
//                if let requestError = error as? RequestError {
//                    XCTAssert(requestError == .unauthorized)
//                }
//                else {
//                    XCTAssert(false)
//                }
//            }
//            }.resume()
//    }
//    func testUnauthorizedResponseUsingDataObject() {
//        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 401))
//        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
//        urlSessionLayer.data(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<Data, Error>) in
//            switch result {
//            case .success( _):
//                XCTAssert(false)
//            case .failure(let error):
//                XCTAssertTrue(error.isUnauthorized)
//                if let requestError = error as? RequestError {
//                    XCTAssert(requestError == .unauthorized)
//                }
//                else {
//                    XCTAssert(false)
//                }
//            }
//            }.resume()
//    }
//
//    func testUnauthorizedResponseUsingStringObject() {
//        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 404))
//        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
//        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<String, Error>) in
//            switch result {
//            case .success( _):
//                XCTAssert(false)
//            case .failure(let error):
//                if let requestError = error as? RequestError {
//                    XCTAssert(requestError == .requestWithError(statusCode: .NotFound))
//                }
//                else {
//                    XCTAssert(false)
//                }
//            }
//            }.resume()
//    }
//
//    func testNoResponseUsingStringObject() {
//        let unauthorizedUrlSession = URLSessionMock(urlResponse: nil)
//        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
//        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<String, Error>) in
//            switch result {
//            case .success( _):
//                XCTAssert(false)
//            case .failure(let error):
//                if let requestError = error as? RequestError {
//                    XCTAssert(requestError == .noResponse)
//                }
//                else {
//                    XCTAssert(false)
//                }
//            }
//            }.resume()
//    }
//
//    func testSerializationError() {
//        let data = try! JSONSerialization.data(withJSONObject: ["name": "hey"], options: .prettyPrinted)
//        let dataURLSession = URLSessionMock(data: data, urlResponse: getResponse(statusCode: 200))
//        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
//        urlSessionLayer.object(request: URLRequest(url: URL(fileURLWithPath: ""))) { (result: Result<DataModel, Error>) in
//            switch result {
//            case .failure(let error):
//                if let reqError = error as? RequestError {
//                    XCTAssert(reqError == RequestError.serializationError)
//                }
//            case .success( _):
//                XCTAssert(false)
//            }
//            }.resume()
//    }
//
//    func testCancelledError() {
//        let dataURLSession = URLSessionMock(error: NSError(domain: "", code: -999, userInfo: nil), urlResponse: getResponse(statusCode: 200))
//        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
//        urlSessionLayer.object(request: URLRequest(url: URL(fileURLWithPath: ""))) { (result: Result<DataModel, Error>) in
//            switch result {
//            case .failure(let error):
//                if let reqError = error as? RequestError {
//                    XCTAssert(reqError == RequestError.cancelled)
//                }
//            case .success( _):
//                XCTAssert(false)
//            }
//            }.resume()
//    }
//
//    func testNoResponseErrorJSON() {
//        let dataURLSession = URLSessionMock()
//        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
//        urlSessionLayer.json(request: URLRequest(url: URL(fileURLWithPath: ""))) { result in
//            switch result {
//            case .failure(let error):
//                if let reqError = error as? RequestError {
//                    XCTAssert(reqError == RequestError.noResponse)
//                }
//            case .success( _):
//                XCTAssert(false)
//            }
//            }.resume()
//    }
//
//    func testUnknownErrorUsingStringObject() {
//        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 524))
//        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
//        urlSessionLayer.object(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<DataModel, Error>) in
//            switch result {
//            case .success( _):
//                XCTAssert(false)
//            case .failure(let error):
//                if let requestError = error as? RequestError {
//                    XCTAssert(requestError == .unknownError(statusCode: 524))
//                }
//                else {
//                    XCTAssert(false)
//                }
//            }
//            }.resume()
//    }
//
//    func testEmptyDataUsingStringObject() {
//        let fakeUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 200))
//        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
//        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<String, Error>) in
//            switch result {
//            case .success( _):
//                XCTAssert(false)
//            case .failure(let error):
//                if let requestError = error as? RequestError {
//                    XCTAssert(requestError == .noResponse)
//                }
//                else {
//                    XCTAssert(false)
//                }
//            }
//            }.resume()
//    }
//
//    func testSuccessFullDataUsingObject() {
//        let fakeUrlSession = URLSessionMock(data: self.getDataModelSample, urlResponse: getResponse(statusCode: 200))
//        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
//        urlSessionLayer.object(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<DataModel, Error>) in
//            switch result {
//            case .success(let dataModel):
//                XCTAssert(dataModel.age! == 12)
//            case .failure(_):
//                XCTAssert(false)
//            }
//            }.resume()
//    }
//
//    func testSuccessFullDataUsingArray() {
//        let fakeUrlSession = URLSessionMock(data: self.getArrayModelSample, urlResponse: getResponse(statusCode: 200))
//        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
//        urlSessionLayer.array(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<[DataModel], Error>) in
//            switch result {
//            case .success(let dataModel):
//                XCTAssert(dataModel.count == 2)
//                XCTAssert(dataModel[0].age! == 12)
//            case .failure(_):
//                XCTAssert(false)
//            }
//            }.resume()
//    }
//
//    func testFailureSerializationDataUsingObject() {
//        let fakeUrlSession = URLSessionMock(data: self.getArrayModelSample, urlResponse: getResponse(statusCode: 200))
//        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
//        urlSessionLayer.object(request: URLRequest(url: URL(string: "www.google.com")!, method: .get)){
//            (result: Result<DataModel, Error>) in
//            switch result {
//            case .success(_):
//                XCTAssert(false)
//            case .failure(let error):
//                if let requestError = error as? RequestError {
//                    XCTAssert(requestError == .serializationError)
//                }
//                else {
//                    XCTAssert(false)
//                }
//            }
//            }.resume()
//    }
    
    
}
