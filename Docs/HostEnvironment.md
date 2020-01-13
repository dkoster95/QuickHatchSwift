## **Host Environment classes**

 - QuickHatch also provides a set of protocols to make your API specification easy to make.
 - Usually our app consume many services from a server(sometimes more than one)
 - That server usually has 3 environments (QA, Staging and Production)

 ```swift
public protocol HostEnvironment {
    var baseURL: String { get }
    var headers: [String: String] { get }
}
  ```

  This is the base protocol for a Host, baseURL and headers.
  
  For a sophisticated implementation we have the next protocols:
   ```swift
  public protocol ServerEnvironmentConfiguration: Any {
    var headers: [String: String] { get }
    var qa: HostEnvironment { get }
    var staging: HostEnvironment { get }
    var production: HostEnvironment { get }
}


public enum Environment: String {
    case qa = "QA"
    case staging = "Staging"
    case production = "Prod"
}

public extension Environment {
    func getCurrentEnvironment(server: ServerEnvironmentConfiguration) -> HostEnvironment {
        switch self {
        case .qa:
            return server.qa
        case .staging:
            return server.staging
        case .production:
            return server.production
        }
    }
}

public protocol GenericAPI {
    var hostEnvironment: HostEnvironment { get set }
    var path: String { get }
}
```


  For example lets say we are building an app with a server called QuickHatchServer and we have a User API with getUsers, fetchUserById and deleteUser.

  Also the server has 3 environments with 3 diferent URLs and headers.

  First lets create a class for our server specification with 3 environments
```swift
     class QuickHatchServer: ServerEnvironmentConfiguration {
         var headers: [String: Any] {
             return ["User-Agent":"QuickHatch"]
         }
         var qa: HostEnvironment { 
             return GenericHostEnvironment(headers: headers, baseURL: "quickhatch-qa.com")
          }
         var staging: HostEnvironment { 
            return GenericHostEnvironment(headers: headers, baseURL: "quickhatch-stg.com")
         }
         var production: HostEnvironment { 
            return GenericHostEnvironment(headers: headers, baseURL: "quickhatch-prod.com")
         }
     }
```
(GenericHostEnvironment is an implementation of HostEnvironment initalized with headers and baseURL)
Now we have our server class there with all the environments and headers configured (Keep in mind this is just an example to show how it works)

Lets say we have a config class where we decide which server we re gonna use (QA, Staging or Prod)
```swift
    class AppConfig {
        static func getHost(environment: Environment) -> HostEnvironment {
            let quickhatchServer = QuickHatchServer()
            return environment.getCurrentEnvironment(server: quickhatchServer)
        }
    }
```

And now we are gonna create our API struct

```swift
    struct UserAPI: GenericAPI {
        var hostEnvironment: HostEnvironment 
        var path: String { return "/api/" }

        init(hostEnvironment: HostEnvironment) {
            self.hostEnvironment = hostEnvironment
        }

        func getUsers(authentication: Authentication) -> URLRequest {
            let stringURL = "\(hostEnvironment.baseURL)\(path)getusers.com"
            let request = URLRequest.post(url: URL(stringURL),
                                          encoding: URLEncoding.default)
            return authentication.authorize(request: request)
        }

        func fetchUser(authentication: Authentication, id: String) -> URLRequest {
            let stringURL = "\(hostEnvironment.baseURL)\(path)getusers.com/{id}"
            let request = URLRequest.get(url: URL(stringURL),
                                         params: ["id": id],
                                         encoding: StringEncoding.urlEncoding)
            return authentication.authorize(request: request)
        }

        func deleteUser(authentication: Authentication, id: String) -> URLRequest {
            let stringURL = "\(hostEnvironment.baseURL)\(path)getusers.com"
            let request = URLRequest.delete(url: URL(stringURL),
                                            params: ["id":id]
                                            encoding: URLEncoding.default)
            return authentication.authorize(request: request)
        }
    }
```

And thats it for your API specification!
Keep in mind that in this example we used an authentication that inject a field in the Authorization header, dont freak out!

Now the only thing you need is instantiate the API injecting the host

```swift
    let host = AppConfig.getHost(environment: .qa)
    let userApi = UserAPI(hostEnvironment: host)

    let getUsersRequest = userApi.getUsers(authentication: yourAuthImplementation)
    // Now we handle the response with QuickHatch implementation
    requestFactory.array(request: getUsersRequest) { (result: Result<User,Error>) in 
        switch result {
            case .success(let response):
                print(response.data)
                //array printed
            case .failure(let error):
                print(error)
                //error printed
        }
    }
```

How Simple is to make your requests with QuickHatch!
