//
//  CertificatePinnerStrategy.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/4/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public class CertificatePinningStrategy: PinningStrategy {
    private let certificates: [SecCertificate]
    
    public init(certificates: [SecCertificate]) {
        self.certificates = certificates
    }
    
    public func validate(serverTrust: SecTrust) -> Bool {
        if let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
            return certificates.map({ return $0.toData }).contains(certificate.toData)
        }
        return false
    }
}

extension SecCertificate {
    var toData: Data {
        return SecCertificateCopyData(self) as Data
    }
}
