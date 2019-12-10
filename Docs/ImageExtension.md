## **Downloading Images**
- When you develop an app, you will probably use images to show content and design your UI
- QuickHatch provides an extension for downloading images from the net simple

```swift
public extension NetworkRequestFactory {
    func image(urlRequest: URLRequest, quality: CGFloat = 1, dispatchQueue: DispatchQueue = .main, completion completionHandler: @escaping (Result<UIImage,Error>) -> Void) -> Request
}
```
Now a sample of its use would be...

```swift
import QuickHatch

class LoginViewPresenter {
    private let networkRequestFactory: NetworkRequestFactory
    private var view: LoginView

    init(requestFactory: NetworkRequestFactory, view: LoginView) {
        self.networkRequestFactory = requestFactory
        self.view = view
    }

    func showProfileImage() {
        let request = URLRequest("getimage.com")
        networkRequestFactory.image(urlRequest: request) { result in
        switch result {
            case .success(let image):
                // update UI or cache image
                view.showProfileImage(image)
            case .failure(let error):
                //show message or nothing
                view.showErrorMessage("Error downloading profile image")
        }
    }
}	
```

And just like that you can use The image extension.