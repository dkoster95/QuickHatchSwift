##**Using Codable extensions**

Codable (Encodable & Decodable) is a protocol launched by Apple to encode and decode JSONs very easily, 
QuickHatch provides an extension for mapping responses to an object or an array.

This is a sample for an **object** mapping using QuickHatch:

```swift
	struct User: Codable {
		var name: String
		var age: Int
	}
	
	let request = networkRequestFactory.object(yourRequest: request) { (result: Result<User, Error>) in 
		switch result {
			case .success(let object):
				//do something
			case .failure(let error):
				//handle error
		}
	}
	request.resume()
```

And for an **array**...
```swift
	let request = networkRequestFactory.array(yourRequest: request) { (result: Result<[User], Error>) in 
		switch result {
			case .success(let array):
				//do something
			case .failure(let error):
				//handle error
		}
	}
	request.resume()
```

---
