## **JSON Parameter Encoding**
- Another important feature of the framework is the **parameter encoding** for a URLRequest


Here you see the parameter encoding protocol, simple right ?
the framework provides 3 implementations for this protocol URL, JSON and String encodings but you can create your own implementation and then inject it into the URLRequest initializer.

```swift
public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestProtocol, with parameters: Parameters?) throws -> URLRequest
}
```

The JSON encoding will escape and encode the parameters in the body.

It will look like this
params: name and password
```swift
{
    "name": "quickhatch",
    "password": "1234"
}
```

Real Sample:
```swift
let getUsers = URLRequest.post(url: URL("getusers.com"),
                              params: ["page":1],
                              encoding: JSONEncoding.default,
                              headers: ["Authorization": "token 1232"])
```