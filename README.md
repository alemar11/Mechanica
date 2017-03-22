![Mechanica: Swift Utils](https://raw.githubusercontent.com/tinrobots/Mechanica/assets/mechanica.png)

[![Swift 3.0.2](https://img.shields.io/badge/Swift-3.0.2-orange.svg?style=flat)](https://developer.apple.com/swift) 
![Platform iOS 10](https://img.shields.io/badge/Platform-iOS%2010%2BS%20|%20macOS%2010.12+%20|%20tvOS%2010+%20|%20watchOS%203+-blue.svg) 

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/alemar11/Console/blob/master/LICENSE)


|Branch|Build Status|Code Coverage|
|----|----|----|
|Develop|![Build Status](https://travis-ci.org/tinrobots/Mechanica.svg?branch=develop)|![Code Coverage](https://img.shields.io/codecov/c/github/tinrobots/Mechanica/develop.svg)|
|Master|[![Build Status](https://travis-ci.org/tinrobots/Mechanica.svg?branch=master)](https://travis-ci.org/tinrobots/Mechanica)| ![Code Coverage](https://img.shields.io/codecov/c/github/tinrobots/Mechanica/master.svg)|

## Mechanica

A library of Swift utils to ease your iOS / macOS / watchOS / tvOS development.

- [Requirements](#requirements)
- [Installation](#installation)
- [License](#license)

## Requirements

- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 8.1+
- Swift 3.0+

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Mechanica into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "tinrobots/Mechanica" ~> 0.1.0
```

Run `carthage update` to build the framework and drag the built `Mechanica.framework` into your Xcode project.

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate Mechanica into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
$ git init
```

- Add Mechanica as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
$ git submodule add https://github.com/tinrobots/Mechanica.git
```

- Open the new `Mechanica` folder, and drag the `Mechanica.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Mechanica.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `Mechanica.xcodeproj` folders each with two different versions of the `Mechanica.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `Mechanica.framework`.

- Select the top `Mechanica.framework` for iOS and the bottom one for macOS.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `Mechanica` will be listed as either `Mechanica iOS`, `Mechanica macOS`, `Mechanica tvOS` or `Mechanica watchOS`.


## License

Mechanica is released under the MIT license. See LICENSE for details.