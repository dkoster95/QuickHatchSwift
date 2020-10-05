//
//  CertificatePinnerTestsHelpers.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/13/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import QuickHatch

class CertificatePinnerTestHelpers {
    class func fakeChallenge(with certificate: SecCertificate?) -> URLAuthenticationChallenge {
        var serverTrust: SecTrust?
        SecTrustCreateWithCertificates([certificate] as CFArray, SecPolicyCreateBasicX509(), &serverTrust)
        let space = MockURLProtectionSpace(serverTrust: serverTrust, host: "nobody", port: 8080)
        return URLAuthenticationChallenge(protectionSpace: space,
                                          proposedCredential: nil,
                                          previousFailureCount: 0,
                                          failureResponse: nil,
                                          error: nil,
                                          sender: MockAuthenticationChallengeSender())
    }
    
    class func fakeChallenge(with certificate: SecCertificate?,
                             host: String,
                             authType: String = NSURLAuthenticationMethodServerTrust) -> URLAuthenticationChallenge {
        var serverTrust: SecTrust?
        SecTrustCreateWithCertificates([certificate] as CFArray, SecPolicyCreateBasicX509(), &serverTrust)
        let space = MockURLProtectionSpace(serverTrust: serverTrust, host: host, port: 8080, authenticationMethod: authType)
        return URLAuthenticationChallenge(protectionSpace: space,
                                          proposedCredential: nil,
                                          previousFailureCount: 0,
                                          failureResponse: nil,
                                          error: nil,
                                          sender: MockAuthenticationChallengeSender())
    }
    static let bundle = Bundle.init(for: CertificateBuilderTests.self)
    class var certificate: SecCertificate? {
        return QHCertificateBuilder.default.openDer(name: "certificate", type: "der", bundle: bundle)
    }
    
    class var davinciCertificate: SecCertificate? {
        return QHCertificateBuilder.default.openDer(name: "davinci.com", type: "der", bundle: bundle)
    }
}

class MockAuthenticationChallengeSender: NSObject, URLAuthenticationChallengeSender {
    func use(_ credential: URLCredential, for challenge: URLAuthenticationChallenge) {
        
    }
    
    func continueWithoutCredential(for challenge: URLAuthenticationChallenge) {
        
    }
    
    func cancel(_ challenge: URLAuthenticationChallenge) {
        
    }
    
}

class MockURLProtectionSpace: URLProtectionSpace {
    private let trust: SecTrust?
    init(serverTrust: SecTrust?,host: String, port: Int, authenticationMethod: String? = nil) {
        self.trust = serverTrust
        super.init(host: host, port: port, protocol: nil, realm: nil, authenticationMethod: authenticationMethod)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var serverTrust: SecTrust? {
        return trust
    }
}
