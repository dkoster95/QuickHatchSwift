## **Errors**
- If an error is returned in a network request QuickHatch provides an enum with errors
```swift
public enum RequestError: Error, Equatable {
    case unauthorized
    case unknownError(statusCode: Int)
    case cancelled
    case noResponse
    case requestWithError(statusCode:HTTPStatusCode)
    case serializationError
    case invalidParameters
    case noInternetConnection
    case malformedRequest
}	
```
Now if we want to check what error is..
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
        networkRequestFactory.data(urlRequest: request) { result in
        switch result {
            case .success(let response):
                // show error messsage
                view?.showSuccessMessage(response.data)
            case .failure(let error):
                //show message or nothing
                if let requestError = error as? RequestError,
                    requestError == .unauthorized {
                    //show auth error
                }
                view?.showErrorMessage("Error downloading profile image")
        }
    }
}	
```
In this sample we are checking whether the error is unauthorized type or not.
