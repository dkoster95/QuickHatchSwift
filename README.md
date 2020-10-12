

![](https://github.com/dkoster95/QuickHatchSwift/blob/master/logo.png)
- **Use an abstract networking layer**
- **Use a functional module for your requests**
- **92.4 % Test coverage**
- **Keep networking simple**
---


## Features

- **NetworkRequestFactory protocol**:
	- [Getting started](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/GettingStarted.md)
	- [Codable extension](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/CodableExtensions.md)
	- [Image extension](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/ImageExtension.md)
	- [Data, String responses](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/Responses.md)
	- [Combine Support](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/CombineSupport.md)
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
	- [Index](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/AuthenticationDoc.md)
- **Certificate Pinning**
	- [Index](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/CertificatePinning.md)
---

## Requirements

- iOS 12.0+ 
- WatchOS 5.0+
- TvOS 12.0+
- MacOS 10.14+
- Xcode 10.2+
- Swift 5+

---

## Installation
	### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate QuickHatch into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
git "https://github.com/dkoster95/QuickHatchSwift.git" "1.1.7"
```
Run `carthage update` to build the framework (you can specify the platform) and then drag the executable `QuickHatch.framework` into your Xcode project.
## Swift Package Manager
QuickHatch has support for SPM, you just need to go to Xcode in the menu File/Swift Packages/Add package dependency
and you select the version of QuickHatch.
	
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

