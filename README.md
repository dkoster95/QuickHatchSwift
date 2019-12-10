

## 🌐 QuickHatch 🌐
- **Use an abstract networking layer**
- **Use a functional module for your requests**
- **91.3 % Test coverage**
- **Keep networking simple**
---


## Features

- **NetworkRequestFactory protocol**:
	- [QuickHatch implementation](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/GettingStarted.md)
	- [Codable extensions](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/CodableExtensions.md)
	- [Image extension](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/ImageExtension.md)
	- [Data, String, JSON responses](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/Responses.md)
	- [Dispatcher extension](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/DispatcherExtension.md)
	- [Errors](https://github.com/dkoster95/QuickHatchSwift/blob/master/Docs/Error.md)
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

