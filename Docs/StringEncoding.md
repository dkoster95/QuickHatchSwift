## **String Parameter Encoding**
- Another important feature of the framework is the **parameter encoding** for a URLRequest


Here you see the parameter encoding protocol, simple right ?
the framework provides 3 implementations for this protocol URL, JSON and String encodings but you can create your own implementation and then inject it into the URLRequest initializer.

```swift
public protocol ParameterEncoding {
    func encode(_ urlRequest: URLRequestProtocol, with parameters: Parameters?) throws -> URLRequest
}
```

The String encoding will escape and encode the parameters in the body or the URL, you can configure that.

It will look like this if you choose the body:
params: name and password
```swift
httpBody = "quickhatch&1234"
```

But if you choose the URL as destination:
There is an interesting mapping provided by the Encoder
you have page and max(per page) as parameters
```swift
    let getUsers = URLRequest.get(url: URL("getusers.com/{page}/{max}"),
                                  params: ["page":1,"maxperpage":30],
                                  encoding: StringEncoding.urlEncoding,
                                  headers: ["Authorization": "token 1232"])
    yourURL will be "getusers.com/1/30"
```


