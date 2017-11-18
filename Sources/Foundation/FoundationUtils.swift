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

/// **Mechanica**
///
/// Returns the type name as `String`.
public func typeName(of some: Any) -> String {
  let value = (some is Any.Type) ? "\(some)" : "\(type(of: some))"

  if !value.starts(with: "(") { return value }

  // match a word inside "(" and " in" https://regex101.com/r/eO6eB7/10
  let pattern = "(?<=\\()[^()]{1,10}(?=\\sin)"
  //if let result = value.range(of: pattern, options: .regularExpression) { return value[result] }
  if let result = value.firstRange(matching: pattern) { return String(value[result]) }

  return value
}

/// **Mechanica**
///
/// Returns the app identifier (`bundleIdenfier` or its `executable` file name).
internal var appIdentifier: String? {
  //TODO: review
  if let identifier = Bundle.main.bundleIdentifier, !identifier.isBlank { //i.e. org.tinrobots.App
    return identifier
  } else if let identifier = Bundle.main.executableFileName, !identifier.isBlank { //i.e. AppExecutableName
    return identifier
  }
  return nil
}
