

## 🌐QuickHatch🌐
- **Use an abstract networking layer**
- **Use a functional module for your requests**
- **91.3 % Test coverage**
---


## Features

- **NetworkRequestFactory protocol**:
	- QuickHatch implementation
	- Codable extensions
	- Image extension
	- Data, String, JSON responses
	- Dispatcher extension
	- Errors
- **URLRequest Additions**:
	- Methods oriented
	- Headers
- **Parameter Encoding**
	- URLEncoding
	- JSONEncoding
	- StringEncoding
- **Host Environment protocol sample**
- **Authentication protocol**


- **Command Module (functional)**
	- Build request
	- Set completion handler
	- Handle errors
	- Manage traffic
	- Authenticate command
	- Log command data
	- Dispatcher results on 
	- Manage response
---

## Requirements

- iOS 11.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 10.2+
- Swift 5+

---

## Installation
	### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate QuickHatch into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
git "https://dk_davinci@bitbucket.org/davinci_team/quickhatch.git" "1.0.2"
```

### Manually

No Package manager? no problem, you can use QuickHatch as a git submodule

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add QuickHatch as a git [submodule](https://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://dk_davinci@bitbucket.org/davinci_team/quickhatch.git
  ```

- Open the new `QuickHatch` folder, and drag the `QuickHatch.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `QuickHatch.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `QuickHatch.xcodeproj` folders each with two different versions of the `QuickHatch.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `QuickHatch.framework`.

- Select the top `QuickHatch.framework` for iOS and the bottom one for macOS.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `QuickHatch` will be listed as either `QuickHatch iOS`, `QuickHatch macOS`, `QuickHatch tvOS` or `QuickHatch watchOS`.

- And that's it!
---

## **Getting Started**

- When you develop an app usually you have to fetch data from  server/s.
- due to this you will want to use a Networking framework but you want to keep the code clean, independent and mantainable.
- You may want to use libraries like Alamofire, Malibu or your own implementation using URLSession or URLConnection.
- What QuickHatch provides is a set of protocols that allows you to follow clean code standards, SOLID principles and allows you to be flexible when it comes to Networking.
- First of all, your app will use a NetworkClient (this can be Alamofire, etc), and QuickHatch provides a protocol called NetworkRequestFactory that sets what a network client should respond when making a request.


```swift

public protocol NetworkRequestFactory {
    func log(with logger: Logger) 
    func json(request: URLRequest,dispatchQueue: DispatchQueue, completionHandler completion: @escaping AnyCompletionHandler) -> Request
    func string(request: URLRequest,dispatchQueue: DispatchQueue, completionHandler completion: @escaping StringCompletionHandler) -> Request
    func data(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping DataCompletionHandler) -> Request
}	
```

As you can see this is a protocol that provides functions to set response to a request based on the type of response you want to deal with.
It also provides a function to set a logging system. In this case we can deal with ***json***, ***string*** and ***data*** responses.

Now lets say your app is using a MVP (Model-View-Presenter) pattern and you want to use QuickHatch to map your networking layer.
Lets show a sample of how that would be:

First we have our presenter, class in charge of connecting View and Models.
Keep in mind these its just a sample, you should always use clean code principles such as SOLID or KISS.


```swift
	class ViewPresenter: Presenter {
		private var requestFactory: NetworkRequestFactory
		var view: View?
		
		init(requestFactory: NetworkRequestFactory) {
			self.requestFactory = requestFactory
		}
		
		func fetchData(username: String) {
			view?.showLoading()
			// Here you initialize the URLRequest object, for now we will use a quickHatch get request
			let yourRequest = URLRequest.get(url: URL("www.google.com",
											 parameters: ["username": username],
											 parameterEncoding: URLEncoding.queryString)
			requestFactory.data(request: yourRequest, dispatch: .main) { result in 
				view?.stopLoading()
				switch result {
					case .success(let data):
						view?.showSuccessAlert(data)
					case .failure(let error):
						view?.showErrorAlert(error)
				}
			
			}.resume()
		}
	}
```

Here we have a View type (protocol), a fetchData method that is going to use the NetworkFactory to get the data from somewhere using a data response and we have the initializer where we are injecting the networkFactory.
Now previously if we used some NetworkClient framework here we would be using the implementation class instead of the protocol and we would be attached to that framework,
but with QuickHatch you are attaching yourself to a protocol, and the implementation can change anytime.

And now we have the code of our view and the dependency injector: 

```swift
	struct DependencyInjector {
		func initializeSampleView() {
			let presenter = ViewPresenter(requestFactory: QuickHatchRequestFactory(urlSession: URLSession.shared)
			let sampleView = SampleView(presenter: presenter)
			application.rootView = sampleView
		}
	}
```

```swift
	class SampleView: View {
	
		private var presenter: ViewPresenter
		private var textField: TextField
		
		init(presenter: Presenter) {
			self.presenter = presenter
			self.presenter.view = self
		}
		
		@IBAction buttonTapped() {
			presenter.fetchData(textField.text)
		}
		
		func stopLoading() {
			// stop spinner 
		}
		
		func showLoading() {
			// start spinner
		}
		
		func showSuccessAlert(data: Data) {
			// show alert for success case 
		}
		
		func showErrorAlert(error: Error) {
			// show alert for error case
		}
	}
```

Great! now we have a presenter that uses an abstract networking layer, and we can switch the implementation by changing the code in the dependencyInjector,
in this case we used the NetworkFactory implementation that QuickHatch provides, this one is initizalized with a URLSession object.
If we want to use an Alamofire Implementation:
you go to the dependency injector and set the new implementation.

```swift
	let presenter = ViewPresenter(requestFactory: AlamofireRequestFactory())
```

---

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