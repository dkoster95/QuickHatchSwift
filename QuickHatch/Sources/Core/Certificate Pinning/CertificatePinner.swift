//
//  CertificatePinner.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/4/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol CertificatePinner {
    func isServerTrusted(challenge: URLAuthenticationChallenge) -> Bool
}

public class QHCertificatePinner: CertificatePinner {
    private let pinningStrategies: [String: [PinningStrategy]]
    
    public init(pinningStrategies: [String: [PinningStrategy]]) {
        self.pinningStrategies = pinningStrategies
    }
    
    public func isServerTrusted(challenge: URLAuthenticationChallenge) -> Bool {
        guard challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust else {
            return false
        }
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            return false
        }
        var secretResult = SecTrustResultType.invalid
        let status = SecTrustEvaluate(serverTrust, &secretResult)
        guard status == errSecSuccess else {
            return false
        }
        return pinningStrategies[challenge.protectionSpace.host]?.contains(where: { return $0.validate(serverTrust: serverTrust) }) ?? true
    }
    
}
