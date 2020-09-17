//
//  CertificatePinnerTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/13/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class CertificatePinnerTests: XCTestCase {
    var subject: QHCertificatePinner!
    let certificate: SecCertificate? = CertificatePinnerTestHelpers.certificate
    let davinciCertificate: SecCertificate? = CertificatePinnerTestHelpers.davinciCertificate
    
    override func setUp() {
        subject = QHCertificatePinner(pinningStrategies: ["quickhatch.com": [CertificatePinningStrategy(certificates: [certificate!])]])
    }

    func testNilAuthenticationMethod() {
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: nil)
        XCTAssertFalse(subject.isServerTrusted(challenge: challenge))
    }
    
    func testNilCertificate() {
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: nil, host: "")
        XCTAssertFalse(subject.isServerTrusted(challenge: challenge))
    }
    
    func testNoHost() {
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: certificate, host: "nohost")
        XCTAssertTrue(subject.isServerTrusted(challenge: challenge))
    }
    
    func testInvalidCertificateHost() {
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: davinciCertificate, host: "quickhatch.com")
        XCTAssertFalse(subject.isServerTrusted(challenge: challenge))
    }
    
    func testValidCertificateHost() {
        let challenge = CertificatePinnerTestHelpers.fakeChallenge(with: certificate, host: "quickhatch.com")
        XCTAssertTrue(subject.isServerTrusted(challenge: challenge))
    }

}
