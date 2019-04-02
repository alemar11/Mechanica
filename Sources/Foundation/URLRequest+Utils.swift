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

extension URLRequest {
  /// **Mechanica**
  ///
  /// Returns a cURL command representation of `self`.
  ///
  /// - Parameters:
  ///   - session: an URLSession to use to get more headers, credentials or cookies.
  ///   - prettyPrinted: if true, the output will have a more readable format.
  /// - Returns: Returns a cURL command representation of `self`.
  // swiftlint:disable:next cyclomatic_complexity
  func cURLRepresentation(session: URLSession? = nil, prettyPrinted: Bool = false) -> String? {
    guard let url = url else { return nil }

    var components = ["curl -i"]

    func appendCredential(_ credential: URLCredential?) {
      guard
        let credential = credential,
        let user = credential.user,
        let password = credential.password
        else { return }
      components.append("-u \(user):\(password)")
    }

    if httpMethod == "HEAD" {
      components.append("--head")
    }

    if let method = httpMethod, method != "GET" && method != "HEAD" {
      components.append("-X \(method)")
    }

    /// Credential
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
          appendCredential(credential)
        }
      }
    }

    /// Cookies
    if
      let session = session,
      session.configuration.httpShouldSetCookies {
      if
        let cookieStorage = session.configuration.httpCookieStorage,
        let cookies = cookieStorage.cookies(for: url), !cookies.isEmpty
      {
        let string = cookies.reduce("") { $0 + "\($1.name)=\($1.value);" }
        components.append("-b \"\(string[..<string.index(before: string.endIndex)])\"")
      }
    }

    /// Headers
    /*
     https://tools.ietf.org/html/rfc7230#section-3.2.2

     A sender MUST NOT generate multiple header fields with the same field
     name in a message unless either the entire field value for that
     header field is defined as a comma-separated list [i.e., #(values)]
     or the header field is a well-known exception (as noted below).

     A recipient MAY combine multiple header fields with the same field
     name into one "field-name: field-value" pair, without changing the
     semantics of the message, by appending each subsequent field value to
     the combined field value in order, separated by a comma.  The order
     in which header fields with the same field name are received is
     therefore significant to the interpretation of the combined field
     value; a proxy MUST NOT change the order of these field values when
     forwarding a message.
     */
    var headers: [AnyHashable: Any] = [:]

    if
      let session = session,
      let additionalHeaders = session.configuration.httpAdditionalHeaders
    {
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

    /// Body
    if let bodyString = httpBodyString {
      var escapedBody = bodyString.replacingOccurrences(of: "\\\"", with: "\\\\\"")
      escapedBody = bodyString.replacingOccurrences(of: "\"", with: "\\\"")

      components.append("-d \"\(escapedBody)\"")
    }

    components.append("\"\(url.absoluteString)\"")

    let separator = !prettyPrinted ? " " :  " \\\n\t"
    return components.joined(separator: separator)
  }

  fileprivate var httpBodyString: String? {
    // The httpBodyStream and httpBody are mutually exclusive - only one can be set on a given request.
    if let httpBodyData = httpBody {
      return String(data: httpBodyData, encoding: .utf8)
    }

    let maxLength = 4096

    if let httpBodyStream = httpBodyStream {
      var data = Data()
      var buffer = [UInt8](repeating: 0, count: maxLength)

      httpBodyStream.open()
      while httpBodyStream.hasBytesAvailable {
        let length = httpBodyStream.read(&buffer, maxLength: maxLength)
        guard length != 0 else { break }

        data.append(&buffer, count: length)
      }
      httpBodyStream.close()

      guard !data.isEmpty else { return nil }

      return String(data: data, encoding: .utf8)
    }

    return nil
  }
}
#endif
