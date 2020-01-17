//
//  CommandAuthRefresherTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 10/16/19.
//  Copyright © 2019 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class CommandAuthRefresherTests: CommandTestBase {

    let successRefresher = MockAuthenticationRefresher(data: ["value": "success"])
    let failureRefresher = MockAuthenticationRefresher(error: RequestError.noResponse)
    let trafficController = TrafficControllerSet()

//    func testSuccessRefresher() {
//        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 401))
//        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
//            .log(with: log)
//            .manageTraffic(with: trafficController, and: "key")
//            .refresh(authenticationRefresher: successRefresher)
//            .completionHandler { (result: Result<Response<DataModel>, Error>) in
//                switch result {
//                case .success(let value):
//                    print(value.data.nick)
//                    XCTAssertTrue(value.data.nick == "sp")
//                case .failure( _):
//                    print("value")
//                    //XCTAssertTrue(false)
//                }
//                
//        }.execute()
//    }
//    
//    func testFailureRefresh() {
//        let urlSession = URLSessionMock(data: getDataModelSample, urlResponse: getResponse(statusCode: 401))
//        _ = HTTPRequestCommand<DataModel>(urlRequest: buildRequest(), networkFactory: QuickHatchRequestFactory(urlSession: urlSession))
//            .log(with: log)
//            .manageTraffic(with: trafficController, and: "key")
//            .refresh(authenticationRefresher: successRefresher)
//            .completionHandler { (result: Result<Response<DataModel>, Error>) in
//                switch result {
//                case .success(let value):
//                    print(value.data.nick)
//                    XCTAssertTrue(value.data.nick == "sp")
//                case .failure( _):
//                    XCTAssertTrue(false)
//                }
//                
//        }.execute()
//    }

    

}
