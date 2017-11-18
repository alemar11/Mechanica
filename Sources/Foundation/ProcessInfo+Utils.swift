//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

extension ProcessInfo {

  /// **Mechanica**
  ///
  ///  Returns true if SwiftPackage tests are running.
  public static var isRunningSwiftPackageTests: Bool {
    let testArguments = processInfo.arguments.filter { $0.ends(with: "xctest")}
    return processInfo.environment["XCTestConfigurationFilePath"] == nil && testArguments.count > 0
  }

  /// **Mechanica**
  ///
  ///  Returns true if Xcode or SwiftPackage Unit Tests are running.
  public static var isRunningUnitTests: Bool {
    return isRunningXcodeUnitTests || isRunningSwiftPackageTests
  }

  /// **Mechanica**
  ///
  ///  Returns true if Xcode Unit Tests are running.
  public static var isRunningXcodeUnitTests: Bool {
    return processInfo.environment["XCTestConfigurationFilePath"].hasValue
  }

  #if os(macOS)
  /// **Mechanica**
  ///
  ///  Returns true if the app is sandboxed.
  public static var isSandboxed: Bool {
    return processInfo.environment["APP_SANDBOX_CONTAINER_ID"].hasValue
  }
  #endif

}
