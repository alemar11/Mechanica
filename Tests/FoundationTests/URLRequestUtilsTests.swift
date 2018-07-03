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

import XCTest
import Foundation
@testable import Mechanica

extension URLRequestUtilsTests {
  static var allTests = [
    ("testCURLRepresentation", testCURLRepresentation),
    ("testCURLRepresentationWithBodyStream", testCURLRepresentationWithBodyStream),
    //("testCURLRepresentationWithURLSession", testCURLRepresentationWithURLSession), //TODO: it's not compiling on Linux
  ]
}

final class URLRequestUtilsTests: XCTestCase {

  func testCURLRepresentation() throws {

    do {
      // Given, When
      let url = URL(string: "https://api.github.com/users/alemar11")!
      var request = URLRequest(url: url)
      request.allHTTPHeaderFields = ["Accept": "application/vnd.github.v3.full+json"]
      // Then
      XCTAssertEqual(request.cURLRepresentation(prettyPrinted: false), "curl -i -H \"Accept: application/vnd.github.v3.full+json\" \"https://api.github.com/users/alemar11\"")
      XCTAssertEqual(request.cURLRepresentation(prettyPrinted: true), "curl -i \\\n\t-H \"Accept: application/vnd.github.v3.full+json\" \\\n\t\"https://api.github.com/users/alemar11\"")
    }

    do {
      // Given, When
      let url = URL(string: "http://localhost:3000/test")!
      var request = URLRequest(url: url)
      request.allHTTPHeaderFields = ["Content-Type": "application/json"]
      request.httpMethod = "POST"
      let body = ["key1": "value1", "key2": "value2"]
      let data = try JSONSerialization.data(withJSONObject: body)
      request.httpBody = data

      // Then
      let prettyCURL = request.cURLRepresentation(prettyPrinted: false)!
      let value1 = "curl -i -X POST -H \"Content-Type: application/json\" -d \"{\\\"key1\\\":\\\"value1\\\",\\\"key2\\\":\\\"value2\\\"}\" \"http://localhost:3000/test\""
      let value2 = "curl -i -X POST -H \"Content-Type: application/json\" -d \"{\\\"key2\\\":\\\"value2\\\",\\\"key1\\\":\\\"value1\\\"}\" \"http://localhost:3000/test\""
      XCTAssertTrue(prettyCURL == value1 || prettyCURL == value2)

      let cURL = request.cURLRepresentation(prettyPrinted: true)!
      let value1_pretty = "curl -i \\\n\t-X POST \\\n\t-H \"Content-Type: application/json\" \\\n\t-d \"{\\\"key1\\\":\\\"value1\\\",\\\"key2\\\":\\\"value2\\\"}\" \\\n\t\"http://localhost:3000/test\""
      let value2_pretty = "curl -i \\\n\t-X POST \\\n\t-H \"Content-Type: application/json\" \\\n\t-d \"{\\\"key2\\\":\\\"value2\\\",\\\"key1\\\":\\\"value1\\\"}\" \\\n\t\"http://localhost:3000/test\""
      XCTAssertTrue(cURL == value1_pretty || cURL == value2_pretty)
    }

    do {
      // Given, When
      var components = URLComponents(string: "http://localhost:3000/test")!
      components.queryItems = [
        URLQueryItem(name: "q1", value: "v1"),
        URLQueryItem(name: "q2", value: "v2")
      ]
      let url = components.url!
      var request = URLRequest(url: url)
      request.allHTTPHeaderFields = ["Content-Type": "application/json"]
      // Then
      XCTAssertEqual(request.cURLRepresentation(prettyPrinted: false)!, "curl -i -H \"Content-Type: application/json\" \"http://localhost:3000/test?q1=v1&q2=v2\"")
      XCTAssertEqual(request.cURLRepresentation(prettyPrinted: true)!, "curl -i \\\n\t-H \"Content-Type: application/json\" \\\n\t\"http://localhost:3000/test?q1=v1&q2=v2\"")
    }

    do {
      // Given, When
      let url = URL(string: "http://www.tinrobots.org")!
      var request = URLRequest(url: url)
      request.httpMethod = "HEAD"
      // Then
      XCTAssertEqual(request.cURLRepresentation(prettyPrinted: false), "curl -i --head \"http://www.tinrobots.org\"")
      XCTAssertEqual(request.cURLRepresentation(prettyPrinted: true), "curl -i \\\n\t--head \\\n\t\"http://www.tinrobots.org\"")
    }

  }

  func testCURLRepresentationWithBodyStream() throws {
    // Given
    let url = URL(string: "http://localhost:3000/test")!
    var request = URLRequest(url: url)

    request.allHTTPHeaderFields = ["Content-Type": "application/json"]
    request.httpMethod = "POST"

    let body = ["key1": "value1", "key2": "value2"]
    let data = try JSONSerialization.data(withJSONObject: body)
    request.httpBodyStream = InputStream(data: data)

    // When, Then
    let cURL = request.cURLRepresentation(prettyPrinted: false)!
    let value1 = "curl -i -X POST -H \"Content-Type: application/json\" -d \"{\\\"key1\\\":\\\"value1\\\",\\\"key2\\\":\\\"value2\\\"}\" \"http://localhost:3000/test\""
    let value2 = "curl -i -X POST -H \"Content-Type: application/json\" -d \"{\\\"key2\\\":\\\"value2\\\",\\\"key1\\\":\\\"value1\\\"}\" \"http://localhost:3000/test\""

    XCTAssertTrue(cURL == value1 || cURL == value2)


    // create a copy because otherwise the httpBodyStream is lost
    var request2 = request
    request2.httpBodyStream = InputStream(data: data)

    let prettyCURL = request2.cURLRepresentation(prettyPrinted: true)!
    let value1_pretty = "curl -i \\\n\t-X POST \\\n\t-H \"Content-Type: application/json\" \\\n\t-d \"{\\\"key1\\\":\\\"value1\\\",\\\"key2\\\":\\\"value2\\\"}\" \\\n\t\"http://localhost:3000/test\""
    let value2_pretty = "curl -i \\\n\t-X POST \\\n\t-H \"Content-Type: application/json\" \\\n\t-d \"{\\\"key2\\\":\\\"value2\\\",\\\"key1\\\":\\\"value1\\\"}\" \\\n\t\"http://localhost:3000/test\""

    XCTAssertTrue(prettyCURL == value1_pretty || prettyCURL == value2_pretty)
  }

  #if os(iOS) || os(tvOS) || os(macOS)

  func testCURLRepresentationWithURLSession() throws {
    // Given
    var urlString = "http://example.com"
    urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!

    let url = URL(string: urlString)!
    var request = URLRequest(url: url)

    request.allHTTPHeaderFields = ["Content-Type": "application/json"]

    let credential = URLCredential(user: "AaA", password: "BBb", persistence: .forSession)
    let host = url.host!
    let protectionSpace = URLProtectionSpace(host: host, port: url.port ?? 0, protocol: url.scheme, realm: host, authenticationMethod: NSURLAuthenticationMethodHTTPBasic)

    let configuration = URLSessionConfiguration.default
    configuration.httpCookieAcceptPolicy = .always
    configuration.httpShouldSetCookies = true
    configuration.httpAdditionalHeaders = ["Content-Type": "application/json", "Test": "Mechanica"]

    let date = Date(timeIntervalSinceNow: 31536000)
    var cookieProperties = [HTTPCookiePropertyKey: Any]()
    cookieProperties[.name] = "cookiename"
    cookieProperties[.value] = "cookievalue"
    cookieProperties[.domain] = urlString
    cookieProperties[.path] = "/"
    cookieProperties[.version] = NSNumber(value: 11)
    cookieProperties[.expires] = date
    let cookie = HTTPCookie(properties: cookieProperties)!

    let storage = MockHTTPCookieStorage()
    storage.setCookies([cookie], for: url, mainDocumentURL: nil)
    configuration.httpCookieStorage = storage

    let session = URLSession(configuration: configuration)
    URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)

    // When, Then
    let cURL = request.cURLRepresentation(session: session, prettyPrinted: false)!
    let expectedValue = "curl -i -u AaA:BBb -b \"cookiename=cookievalue\" -H \"Content-Type: application/json\" -H \"Test: Mechanica\" \"http://example.com\""
    XCTAssertTrue(cURL == expectedValue)
  }

  class MockHTTPCookieStorage: HTTPCookieStorage {
    var _cookies = [URL: [HTTPCookie]]()

    override init() {
      super.init() // not compiling on Linux
    }

    override func setCookies(_ cookies: [HTTPCookie], for URL: URL?, mainDocumentURL: URL?) {
      guard let url = URL else { return }
      _cookies[url] = cookies
    }

    override func cookies(for URL: URL) -> [HTTPCookie]? {
      return _cookies[URL]
    }
  }
  #endif

}
