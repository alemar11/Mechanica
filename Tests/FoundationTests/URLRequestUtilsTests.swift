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
@testable import Mechanica

extension URLRequestUtilsTests {
  static var allTests = [
    ("testCURL", testCURL),
    ]
}

final class URLRequestUtilsTests: XCTestCase {
  
  func testCURL() throws {
    
    do {
      let url = URL(string: "https://api.github.com/users/alemar11")!
      var request = URLRequest(url: url)
      request.allHTTPHeaderFields = ["Accept": "application/vnd.github.v3.full+json"]
      
      XCTAssertEqual(request.cURL(prettyPrinted: false), "curl -i https://api.github.com/users/alemar11 -H 'Accept: application/vnd.github.v3.full+json'")
      XCTAssertEqual(request.cURL(prettyPrinted: true), "curl -i https://api.github.com/users/alemar11 \\\n\t-H 'Accept: application/vnd.github.v3.full+json'")
    }
    
    do {
      let url = URL(string: "http://localhost:3000/test")!
      var request = URLRequest(url: url)
      request.allHTTPHeaderFields = ["Content-Type": "application/json"]
      request.httpMethod = "POST"
      let body = ["key1": "value1", "key2": "value"]
      let data = try JSONSerialization.data(withJSONObject: body)
      request.httpBody = data
      
      XCTAssertEqual(request.cURL(prettyPrinted: false)!, "curl -i http://localhost:3000/test -X POST -H \'Content-Type: application/json\' -d \'{\"key2\":\"value\",\"key1\":\"value1\"}\'")
      XCTAssertEqual(request.cURL(prettyPrinted: true)!, "curl -i http://localhost:3000/test \\\n\t-X POST \\\n\t-H \'Content-Type: application/json\' \\\n\t-d \'{\"key2\":\"value\",\"key1\":\"value1\"}\'")
    }
    
    do {
      let url = URL(string: "http://www.tinrobots.org")!
      var request = URLRequest(url: url)
      request.httpMethod = "HEAD"
      
      XCTAssertEqual(request.cURL(prettyPrinted: false), "curl -i http://www.tinrobots.org --head")
    }
    
  }
  
}
