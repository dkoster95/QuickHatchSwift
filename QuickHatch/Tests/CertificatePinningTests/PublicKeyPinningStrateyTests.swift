//
//  PublicKeyPinningStrateyTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/11/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class PublicKeyPinningStrateyTests: XCTestCase {
    let publicKey = "MIIBCgKCAQEAmb404aYHtIqxLT0TUcQEvnhEthC6Wm5nsjY00Ae+ErwrlS0a3Ugd/BUCKpAIiBpqy+mTzfd4By8+tDk/WFW/TnynlxQzw9dkGuc4Q1mmApK2CsGafSi5zUXqCPVQ5/lPtvjEQmOnXeC9n+7mt89wgDsAgkIGm4QvqvzBkroXDVyIQqvr5kRadcAp03viXaunGIupobTNdilAUXCzOreLNfilcriNtSHEme/i14BJej5m5Vy5xRpi8iptOpGp+OKmR5M479l1woMdCyDjhsf+cywkVJBG7xxbVO4CloiPnb0Z0wGxUJFGJ7qW55rLT009KVwe+saRWGHImI8Ynp4uYQIDAQAB"
    
    var subject: PublicKeyPinningStrategy!
    let certificate: SecCertificate? = CertificatePinnerTestHelpers.certificate
    
    func testValidationSuccessful() {
        subject = PublicKeyPinningStrategy(publicKeys: [publicKey])
        XCTAssertTrue(subject.validate(serverTrust: CertificatePinnerTestHelpers.fakeChallenge(with: certificate!).protectionSpace.serverTrust!))
    }
    
    func testValidationFailure() {
        subject = PublicKeyPinningStrategy(publicKeys: ["publicKey"])
        XCTAssertFalse(subject.validate(serverTrust: CertificatePinnerTestHelpers.fakeChallenge(with: certificate!).protectionSpace.serverTrust!))
    }

}
