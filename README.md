

![](https://github.com/dkoster95/QuickHatchSwift/blob/master/logo.png)
- **Use an abstract networking layer**
- **Use a functional module for your requests**
- **94.3 % Test coverage**
- **Keep networking simple**
---


## Features

- **NetworkRequestFactory protocol**:
	- [Getting started](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/GettingStarted.md)
	- [Codable extensions](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/CodableExtensions.md)
	- [Image extension](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/ImageExtension.md)
	- [Data, String, JSON responses](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/Responses.md)
	- [Dispatcher extension](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/DispatcherExtension.md)
	- [Errors](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/Error.md)
- **URLRequest Additions**:
	- [HTTP Methods oriented](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/URLRequestExtension.md)
- **Parameter Encoding**
	- [URLEncoding](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/URLEncoding.md)
	- [JSONEncoding](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/JSONEncoding.md)
	- [StringEncoding](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/StringEncoding.md)
- **Host Environment protocol sample**
	- [Index](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/HostEnvironment.md)
- **Authentication protocol**
	- Index

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

- iOS 11.0+ 
- WatchOS 5.0+
- TvOS 12.0+
- MacOS 10.10+
- Xcode 10.2+
- Swift 5+

---

## Installation
	### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate QuickHatch into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
git "https://github.com/dkoster95/QuickHatchSwift.git" "1.1.1"
```
Run `carthage update` to build the framework (you can specify the platform) and then drag the executable `QuickHatch.framework` into your Xcode project.
### Manually

No Package manager? no problem, you can use QuickHatch as a git submodule

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add QuickHatch as a git [submodule](https://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/dkoster95/QuickHatchSwift.git
  ```

- Open the new `QuickHatch` folder, and drag the `QuickHatch.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `QuickHatch.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.


- And that's it!
---

