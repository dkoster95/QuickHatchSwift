## **URLRequest Extension**
- QuickHatch provides an extension of URLRequest for you to build the requests easier and faster
```swift
public extension URLRequest {
    
    static func get(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func post(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func put(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func delete(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func patch(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func connect(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func head(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func trace(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
    static func options(url: URL, params: [String: Any] = [:], encoding: ParameterEncoding, headers: [String: String] = [:]) throws -> URLRequest
}	
```

Now Some samples...


```swift
let getUsers = URLRequest.get(url: URL("getusers.com"),
                              params: ["page":1],
                              encoding: URLEncoding.default,
                              headers: ["Authorization": "token 1232"])

let login = URLRequest.post(url: URL("lgin.com"),
                            params: ["user":"QuickHatch", "password": "quickhatch"],
                            encoding: URLEncoding.default,
                            headers: ["Authorization": "token 1232"])

let updateProfile = URLRequest.put(url: URL("profile.com"),
                                   params: ["name":"QuickHatch"],
                                   encoding: JSONEncoding.default,
                                   headers: ["Authorization": "token 1232"])
```

Building a request is so easy now!
