//
//  URLSessionPinningDelegate.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class URLSessionPinningDelegateTests: XCTestCase {
    var subject: URLSessionPinningDelegate!
    let urlSessionMock = URLSessionMock()
    let certificatePinnerMock = CertificatePinnerMock()
    
    override func setUp() {
        subject = URLSessionPinningDelegate(certificatePinner: certificatePinnerMock)
    }
    
    func testNoServerTrust() {
        let expectation = XCTestExpectation()
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: nil)
        subject.urlSession(urlSessionMock, didReceive: challenge) { (result, credential) in
            XCTAssertEqual(result, .cancelAuthenticationChallenge)
            XCTAssertNil(credential)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testServerTrustFalse() {
        let expectation = XCTestExpectation()
        certificatePinnerMock.isServerTrusted = false
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: CertificatePinnerTestHelpers.certificate)
        subject.urlSession(urlSessionMock, didReceive: challenge) { (result, credential) in
            XCTAssertEqual(result, .cancelAuthenticationChallenge)
            XCTAssertNil(credential)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testServerTrusted() {
        let expectation = XCTestExpectation()
        certificatePinnerMock.isServerTrusted = true
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: CertificatePinnerTestHelpers.certificate)
        subject.urlSession(urlSessionMock, didReceive: challenge) { (result, credential) in
            XCTAssertEqual(result, .useCredential)
            XCTAssertNotNil(credential)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

}
