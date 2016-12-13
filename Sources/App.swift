//
//  App.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

struct App {
  
  #if os(OSX)
  /// **Mechanica**
  ///
  /// Returns true if the current app is sandboxed.
  public static var isSandboxed: Bool {
    return ProcessInfo.isSandboxed
  }
  #endif
  
  /// **Mechanica**
  ///
  /// Returns true if the current app is running Unit Tests.
  public static var isRunningUnitTests: Bool {
    return ProcessInfo.isRunningUITests
  }

  /// **Mechanica**
  ///
  /// Returns the app identifier (`bundleIdenfier` or its `executable` file name).
  public static var identifier: String? {
    if let identifier = Bundle.main.bundleIdentifier, !identifier.isBlank { //i.e. org.tinrobots.App
      return identifier
    } else if let identifier = Bundle.main.executableFileName, !identifier.isBlank { //i.e. AppExecutableName
      return identifier
    }
    return nil
  }
  
}
