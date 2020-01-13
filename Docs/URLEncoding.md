## **Url Parameter Encoding**
- Another important feature of the framework is the **parameter encoding** for a URLRequest.


Here you see the parameter encoding protocol, simple right ?
the framework provides 3 implementations for this protocol: URL, JSON and String encoders but you can create your own implementation and then inject it into the URLRequest initializer.

```swift
public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestProtocol, with parameters: Parameters?) throws -> URLRequest
}
```

The **Url encoding** will escape and encode the parameters in the url of the request or in the body depending the destination you choose.

If you choose the body for a post request the property httpBody of the URLRequest will look like this:
params: name and password
```swift
"name=quickhatch&password=1232"
```

If you choose the URL it will look like this:
```swift
"www.theURL.com/api?name=quickhatch&password=1232"
```

Real Sample:
```swift
let getUsers = URLRequest.post(url: URL("getusers.com"),
                              params: ["page":1],
                              encoding: URLEncoding.bodyEncoding,
                              headers: ["Authorization": "token 1232"])
```
