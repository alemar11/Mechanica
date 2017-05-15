//
//  AnyUtils.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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
  if (!value.starts(with: "(")) { return value }
  //return (some is Any.Type) ? "\(String(describing: some))" : "\(String(describing: type(of: some)))"
  
  //match a word inside "(" and " in" https://regex101.com/r/eO6eB7/10
  let pattern = "(?<=\\()[^()]{1,10}(?=\\sin)"
//  let regex = try! NSRegularExpression(pattern: pattern, options: [])
//  // (4):
//  let matches = regex.matches(in: value, options: [], range: NSRange(location: 0, length: value.characters.count))
//  
//  let j = String.matches(for: pattern, in: value)
  
  if let result = value.range(of: pattern, options: .regularExpression) {
    return value[result]
  }
  
  return value
}

extension String {
static func matches(for regex: String, in text: String) -> [String] {
  
  do {
    let regex = try NSRegularExpression(pattern: regex)
    let nsString = text as NSString
    let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
    return results.map { nsString.substring(with: $0.range)}
  } catch let error {
    print("invalid regex: \(error.localizedDescription)")
    return []
  }
}
}
