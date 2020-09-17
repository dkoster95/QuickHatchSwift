//
//  CertificateBuilder.swift
//  QuickHatch
//
//  Created by Daniel Koster on 8/4/20.
//  Copyright © 2020 DaVinci Labs. All rights reserved.
//

import Foundation

public protocol CertificateBuilder {
    func openDer(name: String, type: String, bundle: Bundle) -> SecCertificate?
    func openCertificateContent(name: String, type: String, bundle: Bundle) -> Data?
}

public class QHCertificateBuilder: CertificateBuilder {
    
    private let logger: Logger
    public static var `default` = QHCertificateBuilder(logger: Log(LogsShortcuts.certificatePinner))
    
    public init(logger: Logger) {
        self.logger = logger
    }
    
    public func openDer(name: String, type: String, bundle: Bundle) -> SecCertificate? {
        if let path = bundle.path(forResource: name, ofType: type) {
            do {
                let content = try Data(contentsOf: URL(fileURLWithPath: path))
                return SecCertificateCreateWithData(nil, content as CFData)
            } catch let error {
                logger.error("Error while reading certificate: \(error)")
            }
        }
        return nil
    }
    
    public func openCertificateContent(name: String, type: String, bundle: Bundle) -> Data? {
        if let path = bundle.path(forResource: name, ofType: type) {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path))
            } catch let error {
                logger.error("Error while reading certificate: \(error)")
            }
        }
        return nil
    }
}
