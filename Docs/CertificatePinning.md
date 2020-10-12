## **iOS Security: Certificate Pinning**
As developers we need our apps to: work properly (obviously), be easy to mantain, testable, scalable and **SECURE**.
Users will trust their confidential data to our apps and we need to handle that carefully and prevent leaks or flaws that can cause data loss or exposure.

I always recommend to follow OWASP and their Mobile Apps Top 10 security threats and the solutions for it
(https://owasp.org/www-project-mobile-top-10/)

The threat that is treated by QuickHatch is Top 3 Insecure Communication (https://owasp.org/www-project-mobile-top-10/2016-risks/m3-insecure-communication).

The Certificate Pinning Module is made to prevent Man in the middle attacks (you can find more detailed information in the OWASP links) but basically what we are preventing is that an attacker is able to see all your network traffic.

Certificate Pinning works on top of HTTPS requests and what is gonna do is to verify the authenticity of the SSL Certificate used by the server and the connection between your device and server.

For more information about TLS/SSL handshake and how it works check OWASP links.
https://owasp.org/www-community/controls/Certificate_and_Public_Key_Pinning

The module has 2 strategies to validate the certificate: Pin the certificate and pin the public key.
which one to choose ? Its up to you, if you choose to pin the certificate you will have to update the app bundle every time the certificate is updated, however if you pin the public key you wont have this problem because the public key is not going to change, but you may violate the key rotation standard (its always good to change the keys of your app).
Lets jump right to the Code:

```swift
    public protocol CertificatePinner {
        func isServerTrusted(challenge: URLAuthenticationChallenge) -> Bool
    }
```

First of all we have a protocol CertificatePinner with only one function that is to check wether the server we are receiving is trusted by our app or not. **URLAuthenticationChallenge** is the swift class that contains information about the server certficate.
```swift
public class QHCertificatePinner: CertificatePinner {
    private let pinningStrategies: [String: [PinningStrategy]]
    
    public init(pinningStrategies: [String: [PinningStrategy]]) {
        self.pinningStrategies = pinningStrategies
    }
    ....
    ...
```

Here is the QuickHatch implementation: you initialize your pinner with a dictionary of hosts (string) with pinning strategies for those hosts.

The pinning strategy protocol:
```swift
public protocol PinningStrategy {
    func validate(serverTrust: SecTrust) -> Bool
}
```

CertificatePinning strategy:
```swift
public class CertificatePinningStrategy: PinningStrategy {
    private let certificates: [SecCertificate]
    
    public init(certificates: [SecCertificate])
```
its initialized with an array of Certificates (included in your bundle) and the validate function will use those certificates.

The public key strategy:
```swift
public class PublicKeyPinningStrategy: PinningStrategy {
    private let publicKeys: [String]
    private let hasher: Hasher
    
    public init(publicKeys: [String], hasher: Hasher = CCSHA256Hasher.shared)
```
This implementation is initialized with an array of public keys (hash) and with a hasher class that is gonna apply the hashing to the public key coming in the **URLAuthenticationChallenge** and is gonna compare 2 strings to validate.


Real Example:
```swift

let pinner = QHCertificatePinner(pinningStrategies: ["quickhatch.com": [CertificatePinningStrategy(certificates: [certificate],
                                                                        PublicKeyPinningStrategy(publicKeys: ["your public key has"],
                                                                                                 hasher: youHasher))
                                                                        ]
                                                    ])
```

In this case we set 2 pinning strategies for **quickhatch.com** one public key pinning with one public key and your own hasher implementation and one Certificate pinning strategy with one certificate.

By default if the host doesnt have a pinning strategy set it will return as trusted.

All of this look great and fancy but where do we use our pinner ???

The answer is URLSession method **urlSession(_ session: URLSession,didReceive challenge: URLAuthenticationChallenge,completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void)** so There is a class implementing URLSessionDelegate, you can use this class to initialize your urlsession or you can subclass it you choice.
```swift
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
```