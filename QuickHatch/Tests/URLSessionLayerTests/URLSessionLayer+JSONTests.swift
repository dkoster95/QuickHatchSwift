//
//  URLSessionLayer+JSONTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/11/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class URLSessionLayer_JSONTests: URLSessionLayerBase {

    func testNoResponseErrorJSON() {
        let dataURLSession = URLSessionMock()
        let urlSessionLayer = getURLSessionLayer(urlSession: dataURLSession)
        urlSessionLayer.json(request: URLRequest(url: URL(fileURLWithPath: ""))) { result in
            switch result {
            case .failure(let error):
                if let reqError = error as? RequestError {
                    XCTAssert(reqError == RequestError.noResponse)
                }
            case .success:
                XCTAssert(false)
            }
            }.resume()
    }

}
