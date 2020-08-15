//
//  CertificatePinningStrategyTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/5/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class CertificatePinningStrategyTests: XCTestCase {
    var subject: CertificatePinningStrategy!
    let bundle = Bundle.init(for: CertificateBuilderTests.self)
    let certificate: SecCertificate? = CertificatePinnerTestHelpers.certificate
    let davinciCertificate: SecCertificate? = CertificatePinnerTestHelpers.davinciCertificate
    
    override func setUp() {
        let certificates = [certificate!]
        subject = CertificatePinningStrategy(certificates: certificates)
    }
    
    func testSuccessCase() {
        XCTAssertTrue(subject.validate(serverTrust: CertificatePinnerTestHelpers.fakeChallenge(with: certificate!).protectionSpace.serverTrust!))
    }
    
    func testFailureCase() {
        XCTAssertFalse(subject.validate(serverTrust: CertificatePinnerTestHelpers.fakeChallenge(with: davinciCertificate!).protectionSpace.serverTrust!))
    }

}

