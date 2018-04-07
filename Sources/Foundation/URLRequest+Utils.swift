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

import Foundation

extension URLRequest {

  /// **Mechanica**
  ///
  /// Returns a cURL command representation of `self`.
  /// - Note: Logging URL requests in whole may expose sensitive data: make sure to disable this feature for production builds.
  private var cURL: String? { //TODO: work in progress, add a pretty param?
    guard let url = url else { return nil }

    var baseCommand = "curl -i -k \(url.absoluteString)"

    if httpMethod == "HEAD" {
      baseCommand += " --head"
    }

    var command = [baseCommand]

    if let method = httpMethod, method != "GET" && method != "HEAD" {
      command.append("-X \(method)")
    }

    if let headers = allHTTPHeaderFields {
      for (key, value) in headers where key != "Cookie" {
        command.append("-H '\(key): \(value)'")
      }
    }

    if let data = httpBody, let body = String(data: data, encoding: .utf8) {
      //let escapedBody = body.replacingOccurrences(of: "'", with: "'\\''")
      command.append("-d '\(body)'")
    }

    return command.joined(separator: " \\\n\t")
  }

}
