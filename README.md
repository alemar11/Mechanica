![Mechanica: Swift Utils](https://raw.githubusercontent.com/tinrobots/Mechanica/assets/mechanica.png)

[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-orange.svg?style=flat)](https://developer.apple.com/swift)
![Platforms](https://img.shields.io/badge/Platform-iOS%2010%2B%20|%20macOS%2010.12+%20|%20tvOS%2010+%20|%20watchOS%203+|%20Ubuntu%20Linux-blue.svg) 

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Mechanica.svg)](https://cocoapods.org/pods/Mechanica)

|Branch|TravisCI Build Status (all os)|CircleCI Build Status (linux)|Code Coverage
|----|----|----|----|
|Master|[![TravisCI](https://travis-ci.org/tinrobots/Mechanica.svg?branch=master)](https://travis-ci.org/tinrobots/Mechanica)|![CircleCI](https://circleci.com/gh/tinrobots/Mechanica/tree/master.svg?style=shield)|[![codecov](https://codecov.io/gh/tinrobots/Mechanica/branch/master/graph/badge.svg)](https://codecov.io/gh/tinrobots/Mechanica)
|Develop|![TravisCI](https://travis-ci.org/tinrobots/Mechanica.svg?branch=develop)|![CircleCI](https://circleci.com/gh/tinrobots/Mechanica/tree/develop.svg?style=shield)|[![codecov](https://codecov.io/gh/tinrobots/Mechanica/branch/develop/graph/badge.svg)](https://codecov.io/gh/tinrobots/Mechanica)

## Mechanica
[![GitHub release](https://img.shields.io/github/release/tinrobots/Mechanica.svg)](https://github.com/tinrobots/Mechanica/releases) 

A library of Swift utils to ease your iOS, macOS, watchOS, tvOS and Linux development.

- [Requirements](#requirements)
- [Documentation](#documentation)
- [Installation](#installation)
- [License](#license)
- [Contributing](#contributing)

## Requirements

- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Xcode 9.3
- Swift 4.1

## Documentation

Documentation is [available online](http://www.tinrobots.org/Mechanica/).

> [http://www.tinrobots.org/Mechanica/](http://www.tinrobots.org/Mechanica/)

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1.0+ is required to build Mechanica 1.0.0+.

To integrate Mechanica into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'Mechanica', '~> 1.6'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Mechanica into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "tinrobots/Mechanica" ~> 1.6.0
```

Run `carthage update` to build the framework and drag the built `Mechanica.framework` into your Xcode project.

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 
Once you have your Swift package set up, adding Mechanica as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/tinrobots/Mechanica.git", from: "1.6.0")
]
```

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

[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/tinrobots/Mechanica/blob/master/LICENSE.md))

Mechanica is released under the MIT license. See [LICENSE](./LICENSE.md) for details.

## Contributing

Pull requests are welcome!  
[Show your ❤ with a ★](https://github.com/tinrobots/mechanica/stargazers)