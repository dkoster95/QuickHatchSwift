//
//  URLSessionLayer+ImageTests.swift
//  NetworkingLayerTests
//
//  Created by Daniel Koster on 6/10/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class QHNetworkRequestFactory_ImageTests: QHNetworkRequestFactoryTestCase {
    fileprivate var imageData: Data {
        let bundle = Bundle.init(for: QHNetworkRequestFactory_ImageTests.self)
        let image = UIImage(named: "swifticon", in: bundle, compatibleWith: nil)
        return image!.pngData()!
    }
    
    fileprivate var urlRequest: URLRequest {
        return URLRequest(url: URL(string: "www.google.com")!)
    }

    func testSerializationError() {
        let fakeUrlSession = URLSessionProtocolMock(data: self.getDataModelSample, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = QHRequestFactory(urlSession: fakeUrlSession)
        urlSessionLayer.image(urlRequest: urlRequest) { result in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .serializationError(error: ImageError.malformedError))
                } else {
                    
                }
            }
        }.resume()
        
    }
    
    func testError() {
        let fakeUrlSession = URLSessionProtocolMock(urlResponse: getResponse(statusCode: 404))
        let urlSessionLayer = QHRequestFactory(urlSession: fakeUrlSession)
        urlSessionLayer.image(urlRequest: urlRequest) { result in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure(let error):
                if let requestError = error as? RequestError {
                    XCTAssert(requestError == .requestWithError(statusCode: .notFound))
                }
            }
            }.resume()
        
    }
    
    func testSuccess() {
        let fakeUrlSession = URLSessionProtocolMock(data: self.imageData, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = QHRequestFactory(urlSession: fakeUrlSession)
        urlSessionLayer.image(urlRequest: urlRequest) { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
            }.resume()
    }
    
    func testSuccessWithHalfQuality() {
        let fakeUrlSession = URLSessionProtocolMock(data: self.imageData, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = QHRequestFactory(urlSession: fakeUrlSession)
        urlSessionLayer.image(urlRequest: urlRequest,quality: 0.5) { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
            }.resume()
    }
    
    func testSuccessWith200Quality() {
        let fakeUrlSession = URLSessionProtocolMock(data: self.imageData, urlResponse: getResponse(statusCode: 200))
        let urlSessionLayer = QHRequestFactory(urlSession: fakeUrlSession)
        urlSessionLayer.image(urlRequest: urlRequest,quality: 2) { result in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
            }.resume()
    }

}
