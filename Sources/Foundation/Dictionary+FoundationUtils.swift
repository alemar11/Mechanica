//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

#if canImport(Foundation)
import Foundation

extension Dictionary {

  // MARK: - JSON

  /// **Mechanica**
  ///
  /// Returns a Dictionary from a given JSON String.
  public init?(json: String) {
    if
      let jsonData = json.data(using: .utf8, allowLossyConversion: true),
      let jsonDictionary = (try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)) as? Dictionary
    {
      self = jsonDictionary
    } else {
      return nil
    }
  }

  /// **Mechanica**
  ///
  /// Returns a JSON Data from dictionary.
  ///
  /// - Parameter prettify: *true* to prettify data (defaults to *false*).
  /// - Returns: optional JSON Data.
  public func jsonData(prettify: Bool = false) -> Data? {
    guard JSONSerialization.isValidJSONObject(self) else { return nil }

    let options = (prettify == true) ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions()

    return try? JSONSerialization.data(withJSONObject: self, options: options)
  }

  /// **Mechanica**
  ///
  /// Returns a JSON String from dictionary.
  ///
  /// - Parameter prettify: *true* to prettify string (defaults to *false*).
  /// - Returns: optional JSON String.
  public func jsonString(prettify: Bool = false) -> String? {
    guard let jsonData = jsonData(prettify: prettify) else { return nil }
    
    return String(data: jsonData, encoding: .utf8)
  }

}
#endif
