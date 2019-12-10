## **Dispatcher Extension**
- QuickHatch allows you to handle the thread you want to perform your results


QuickHatch has a parameter in each of the methods that is the dispatchQueue where the results will be dispatched, the default value is main thread but you can configure it easily
```swift
public extension NetworkRequestFactory {
    func data(request: URLRequest, dispatchQueue: DispatchQueue = .main, completionHandler completion: @escaping DataCompletionHandler) -> Request
}	
```
If we want to handle our results in a background thread...

```swift
import QuickHatch

class LoginViewPresenter {
    private let networkRequestFactory: NetworkRequestFactory
    private weak var view: LoginView

    init(requestFactory: NetworkRequestFactory, view: LoginView) {
        self.networkRequestFactory = requestFactory
        self.view = view
    }

    func login(user: String, password: String) {
        let request = URLRequest("getimage.com/user=\(user)&password=\(password)")
        let backgroundThread = DispatchQueue.global(qos: .background)
        networkRequestFactory.data(urlRequest: request, dispatchQueue: backgroundThread) { result in
        switch result {
            case .success(let response):
                // show error messsage
                view?.showSuccessMessage(response.data)
            case .failure(let error):
                //show message or nothing
                view?.showErrorMessage("Error downloading profile image")
        }
    }
}	
```

The results of the login service will run on a background thread now. Super easy!
