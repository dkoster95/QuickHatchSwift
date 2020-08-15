//
//  CertificateBuilderTests.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/5/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import XCTest
import QuickHatch

class CertificateBuilderTests: XCTestCase {
    let subject = QHCertificateBuilder.default
    let bundle = Bundle.init(for: CertificateBuilderTests.self)
    
    func testGenerateCertFailWrongFormat() {
        let certificate = subject.openDer(name: "cacert", type: "pem", bundle: .main)
        XCTAssertNil(certificate)
    }
    
    func testGenerateCertSuccess() {
        let certificate = subject.openDer(name: "certificate", type: "der", bundle: bundle)
        XCTAssertNotNil(certificate)
    }
    
    func testOpenContentPEM() {
        let certificateData = subject.openCertificateContent(name: "cacert", type: "pem", bundle: bundle)
        XCTAssertNotNil(certificateData)
    }
    
    func testOpenContentPEMWrongBundle() {
        let certificateData = subject.openCertificateContent(name: "cacert", type: "pem", bundle: .main)
        XCTAssertNil(certificateData)
    }

}
