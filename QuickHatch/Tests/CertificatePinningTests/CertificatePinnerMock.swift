//
//  CertificatePinnerMock.swift
//  QuickHatchTests
//
//  Created by Daniel Koster on 8/14/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation
import QuickHatch

class CertificatePinnerMock: CertificatePinner {
    var isServerTrusted = true
    func isServerTrusted(challenge: URLAuthenticationChallenge) -> Bool {
        return isServerTrusted
    }
}
