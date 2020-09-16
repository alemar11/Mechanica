#if canImport(Foundation)

import Foundation

extension ProcessInfo {
  /// **Mechanica**
  ///
  ///  Returns true if SwiftPackage tests are running.
  public static var isRunningSwiftPackageTests: Bool {
    // TODO: is it still ok in 2020?
    let testArguments = processInfo.arguments.filter { $0.ends(with: "xctest") }
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

  /// **Mechanica**
  ///
  /// - Returns: Returns the system (re)starting date.
  public static var systemStartingDate: Date {
    return Date(timeIntervalSinceNow: -processInfo.systemUptime)
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

#endif
