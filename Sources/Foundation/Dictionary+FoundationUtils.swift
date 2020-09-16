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
