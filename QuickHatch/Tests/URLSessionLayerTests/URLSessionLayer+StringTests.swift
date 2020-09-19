//
//  URLSessionLayer+StringTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/11/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class URLSessionLayer_StringTests: URLSessionLayerBase {

    func testUnauthorizedResponseUsingStringObject() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 404))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                   method: .get)) { (result: Result<Response<String>, Error>) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .requestWithError(statusCode: .notFound))
                } else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testNoResponseUsingStringObject() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: nil)
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                   method: .get)) { (result: Result<Response<String>, Error>) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .noResponse)
                } else {
                    XCTAssert(false)
                }
            }
            }.resume()
    }
    
    func testCancelledError() {
        let dataURLSession = URLSessionMock(error: NSError(domain: "", code: -999, userInfo: nil), urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        urlSessionLayer.string(request: URLRequest(url: URL(fileURLWithPath: ""))) { (result: Result<Response<String>, Error>) in
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
    
    func testUnknownErrorUsingStringObject() {
        let unauthorizedUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 524))
        let urlSessionLayer = getURLSessionLayer(urlSession: unauthorizedUrlSession)
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                   method: .get)) { (result: Result<Response<String>, Error>) in
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
    
    func testEmptyDataUsingStringObject() {
           let fakeUrlSession = URLSessionMock(urlResponse: getResponse(statusCode: 200))
           let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
           urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,
                                                      method: .get)) { (result: Result<Response<String>, Error>) in
               switch result {
               case .success:
                   XCTAssert(false)
               case .failure(let error):
                   if let requestError = error as? RequestError {
                       XCTAssert(requestError == .noResponse)
                   } else {
                       XCTAssert(false)
                   }
               }
           }.resume()
       }
    
    func testSuccessFullDataUsingObject() {
        let fakeUrlSession = URLSessionMock(data: self.getDataModelSample, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = getURLSessionLayer(urlSession: fakeUrlSession)
        urlSessionLayer.string(request: URLRequest(url: URL(string: "www.google.com")!,  method: .get)) { (result: Result<Response<String>, Error>) in
            switch result {
            case .success(let dataModel):
                print(dataModel.data)
                XCTAssert(true)
            case .failure:
                    XCTAssert(false)
            }
            }.resume()
    }

}
