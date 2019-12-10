## **Using Codable extensions**

Codable (Encodable & Decodable) is a protocol launched by Apple to encode and decode JSONs very easily, 
QuickHatch provides an extension for mapping responses to an object or an array.

This is a sample for an **object** mapping using QuickHatch:

```swift
	struct User: Codable {
		var name: String
		var age: Int
	}
	
	let request = networkRequestFactory.object(request: yourRequest) { (result: Result<Response<User>, Error>) in 
		switch result {
			case .success(let response):
				//do something
			case .failure(let error):
				//handle error
		}
	}
	request.resume()
```

And for an **array**...
```swift
	let request = networkRequestFactory.array(request: yourRequest) { (result: Result<Response<[User]>, Error>) in 
		switch result {
			case .success(let response):
				//do something
			case .failure(let error):
				//handle error
		}
	}
	request.resume()
```

---
