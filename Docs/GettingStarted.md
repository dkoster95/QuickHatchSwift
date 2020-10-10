## **Getting Started**

- When you develop an app usually you have to fetch data from  server/s.
- due to this you will want to use a Networking framework but you want to keep the code clean, independent and mantainable.
- You may want to use libraries like Alamofire, Malibu or your own implementation using URLSession or URLConnection.
- What QuickHatch provides is a set of protocols that allows you to follow clean code standards, SOLID principles and allows you to be flexible when it comes to Networking.
- First of all, your app will use a NetworkClient (this can be Alamofire, etc), and QuickHatch provides a protocol called NetworkRequestFactory that sets what a network client should respond when making a request.

![](https://github.com/dkoster95/QuickHatchSwift/blob/master/diagram.png)

The name of this networkLayer interface in QuickHatch is NetworkRequestFactory :).
```swift

public protocol NetworkRequestFactory { 
    func data(request: URLRequest, dispatchQueue: DispatchQueue, completionHandler completion: @escaping DataCompletionHandler) -> Request
	func data(request: URLRequest, dispatchQueue: DispatchQueue) -> AnyPublisher<Data,Error>
}	
```

The very base protocol of the RequestFactory provides 2 functions to get Data out of a network request, one is using a ***completionHandler*** with a ***Request*** type return and the other one is using ***Combine's AnyPublisher*** if you choose to use Reactive Programming

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
			let presenter = ViewPresenter(requestFactory: QHRequestFactory(urlSession: URLSession.shared)
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
