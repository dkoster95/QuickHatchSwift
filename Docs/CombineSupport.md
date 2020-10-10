## **Using Combine extension**

The network Request Factory also has support for swift Combine if you decide to go full Reactive programming.

```swift
    func image(urlRequest: URLRequest,
               dispatchQueue: DispatchQueue = .main,
               quality: CGFloat) -> AnyPublisher<UIImage, Error>
    
    func response<CodableData: Codable>(urlRequest: URLRequest,
                                        dispatchQueue: DispatchQueue = .main,
                                        jsonDecoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<CodableData, Error>
    
    func string(urlRequest: URLRequest,
                dispatchQueue: DispatchQueue = .main,
                jsonDecoder: JSONDecoder = JSONDecoder())-> AnyPublisher<String, Error>

```
This is a sample for a **response** mapping using QuickHatch Combine function:

```swift
	struct User: Codable {
		var name: String
		var age: Int
	}
    var subscriptions: Set<AnyCancellable> = []
	
	let request = networkRequestFactory.response(request: yourRequest)
                    .sink(receiveCompletion: { receiveCompletion in 

                    }, 
                    receiveValue: { (value: User) in 
                    }).store(in: &subscriptions)
```


---