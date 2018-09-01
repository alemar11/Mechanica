//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

extension Data {

  /// **Mechanica**
  ///
  /// Returns `self` as an array of bytes.
  public var bytes: [UInt8] {
    return [UInt8](self)
  }

  /// **Mechanica**
  ///
  /// Returns an hexadecimal string representation of the content.
  #warning ("work in progress")
  public var hexEncodedString: String {
    // https://stackoverflow.com/questions/39075043/how-to-convert-data-to-hex-string-in-swift
    return reduce("") {$0 + String(format: "%02x", $1)}
  }

// TODO
//  func hexEncodedString(uppercase: Bool = false) -> String {
//    let hexDigits = Array((uppercase ? "0123456789ABCDEF" : "0123456789abcdef").utf16)
//    var chars: [unichar] = []
//    chars.reserveCapacity(2 * count)
//    for byte in self {
//      chars.append(hexDigits[Int(byte / 16)])
//      chars.append(hexDigits[Int(byte % 16)])
//    }
//    return String(utf16CodeUnits: chars, count: chars.count)
//  }
//
//  private static let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }
//
//  public func hexEncodedString2() -> String {
//    return String(self.reduce(into: "".unicodeScalars) { (result, value) in
//      result.append(Data.hexAlphabet[Int(value/16)])
//      result.append(Data.hexAlphabet[Int(value%16)])
//    })
//  }

}
#endif
