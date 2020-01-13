## **Authentication Protocol**
- This is a very useful protocol when you are working with Authenticated API's and you need to authorize requests

```swift
public protocol Authentication {
    var isAuthenticated: Bool { get }
    func autenticate(params: [String: Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void)
    func authorize(request: URLRequest) -> URLRequest
    func clearCredentials()
}

public protocol RefreshableAuthentication {
    func refresh(params: [String: Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void)
}

public protocol RevokableAuthentication {
    func revoke(params: [String: Any], completionHandler completion: @escaping (Result<Any, Error>) -> Void)
}
```

QuickHatch provides these 3 protocols for Authentication management, some Auths are revokables and refreshables.

Usually you have an endpoint to fetch the set of tokens, (in your implementation you should use the authenticate method for that) and the you inject the auth token in the Authorization header for each request.


