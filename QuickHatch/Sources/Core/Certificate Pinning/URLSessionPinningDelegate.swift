//
//  URLSessionPinningDelegate.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/4/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public class URLSessionPinningDelegate: NSObject, URLSessionDelegate {
    private let certificatePinner: CertificatePinner
    
    public init(certificatePinner: CertificatePinner) {
        self.certificatePinner = certificatePinner
    }
    
    public func urlSession(_ session: URLSession,
                           didReceive challenge: URLAuthenticationChallenge,
                           completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        if certificatePinner.isServerTrusted(challenge: challenge) {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
            return
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
    
}
