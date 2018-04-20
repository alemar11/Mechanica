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
  // swiftlint:disable:next cyclomatic_complexity
  func cURLRepresentation(session: URLSession? = nil, credential: URLCredential? = nil, prettyPrinted: Bool = false) -> String? {
    var components = ["curl -i"]
    guard let url = url else { return nil }

    if httpMethod == "HEAD" {
      components.append("--head")
    }

    if let method = httpMethod, method != "GET" && method != "HEAD" {
      components.append("-X \(method)")
    }

    if
      let session = session,
      let host = url.host,
      let credentialStorage = session.configuration.urlCredentialStorage
    {
      let protectionSpace = URLProtectionSpace(
        host: host,
        port: url.port ?? 0,
        protocol: url.scheme,
        realm: host,
        authenticationMethod: NSURLAuthenticationMethodHTTPBasic
      )

      if let credentials = credentialStorage.credentials(for: protectionSpace)?.values {
        for credential in credentials {
          guard let user = credential.user, let password = credential.password else { continue }
          components.append("-u \(user):\(password)")
        }

      } else {
        if
          let credential = credential,
          let user = credential.user,
          let password = credential.password
        {
          components.append("-u \(user):\(password)")
        }
      }
    }

    if let session = session, session.configuration.httpShouldSetCookies {
      if
        let cookieStorage = session.configuration.httpCookieStorage,
        let cookies = cookieStorage.cookies(for: url), !cookies.isEmpty
      {
        let string = cookies.reduce("") { $0 + "\($1.name)=\($1.value);" }
        components.append("-b \"\(string[..<string.index(before: string.endIndex)])\"")
      }
    }

    var headers: [AnyHashable: Any] = [:]

    if let session = session, let additionalHeaders = session.configuration.httpAdditionalHeaders {
      for (field, value) in additionalHeaders where field != AnyHashable("Cookie") {
        headers[field] = value
      }
    }

    if let headerFields = allHTTPHeaderFields {
      for (field, value) in headerFields where field != "Cookie" {
        headers[field] = value
      }
    }

    for (field, value) in headers {
      let escapedValue = String(describing: value).replacingOccurrences(of: "\"", with: "\\\"")
      components.append("-H \"\(field): \(escapedValue)\"")
    }

    if let httpBodyData = httpBody, let httpBody = String(data: httpBodyData, encoding: .utf8) {
      var escapedBody = httpBody.replacingOccurrences(of: "\\\"", with: "\\\\\"")
      escapedBody = escapedBody.replacingOccurrences(of: "\"", with: "\\\"")

      components.append("-d \"\(escapedBody)\"")
    }

    components.append("\"\(url.absoluteString)\"")

    let separator = !prettyPrinted ? " " :  " \\\n\t"
    return components.joined(separator: separator)
  }

}
