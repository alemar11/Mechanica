//
//  StringNSStringTests.swift
//  Mechanica
//
//  Copyright © 2016 Tinrobots.
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

class StringNSStringTests: XCTestCase {

  func test_lastPathComponent() {
    XCTAssert("/tmp/scratch.tiff".lastPathComponent == "scratch.tiff")
    XCTAssert("/tmp/scratch".lastPathComponent == "scratch")
    XCTAssert("scratch///".lastPathComponent == "scratch")
    XCTAssert("/".lastPathComponent == "/")
  }

  func test_pathExtension() {
    XCTAssert("/tmp/scratch.tiff".pathExtension == "tiff")
    XCTAssert(".scratch.tiff".pathExtension == "tiff")
    XCTAssert("/tmp/scratch".pathExtension == "")
    XCTAssert("/tmp/scratch..tiff".pathExtension == "tiff")
  }

  func test_deletingLastPathComponent() {
    XCTAssert("/tmp/scratch.tiff".deletingLastPathComponent == "/tmp")
    XCTAssert( "/tmp/lock/".deletingLastPathComponent == "/tmp")
    XCTAssert( "/tmp/".deletingLastPathComponent == "/")
    XCTAssert("/tmp".deletingLastPathComponent == "/")
    XCTAssert( "/".deletingLastPathComponent == "/")
    XCTAssert("scratch.tiff".deletingLastPathComponent == "")
  }

  func test_deletingPathExtension() {
    XCTAssert("/tmp/scratch.tiff".deletingPathExtension == "/tmp/scratch")
    XCTAssert("/tmp/".deletingPathExtension == "/tmp")
    XCTAssert("scratch.bundle/".deletingPathExtension == "scratch")
    XCTAssert("scratch..tiff".deletingPathExtension == "scratch.")
    XCTAssert(".tiff".deletingPathExtension == ".tiff")
    XCTAssert("/".deletingPathExtension == "/")
  }

  func test_pathComponents() {
    let path = "tmp/scratch";
    let pathComponents = path.pathComponents
    XCTAssert(pathComponents[0] == "tmp")
    XCTAssert(pathComponents[1] == "scratch")

    let path2 = "/tmp/scratch"
    let pathComponents2 = path2.pathComponents
    XCTAssert(pathComponents2[0] == "/")
    XCTAssert(pathComponents2[1] == "tmp")
    XCTAssert(pathComponents2[2] == "scratch")
  }

  func test_appendingPathComponent() {
    let scratch = "scratch.tiff"
    XCTAssert("/tmp".appendingPathComponent(scratch) == "/tmp/scratch.tiff")
    XCTAssert("/tmp/".appendingPathComponent(scratch) == "/tmp/scratch.tiff")
    XCTAssert("/".appendingPathComponent(scratch) == "/scratch.tiff")
    XCTAssert("".appendingPathComponent(scratch) == "scratch.tiff")
  }

  func test_appendingPathExtension() {
    let ext = "tiff"
    XCTAssert("/tmp/scratch.old".appendingPathExtension(ext) == "/tmp/scratch.old.tiff")
    XCTAssert("/tmp/scratch.".appendingPathExtension(ext) == "/tmp/scratch..tiff")
    XCTAssert("/tmp/".appendingPathExtension(ext) == "/tmp.tiff")
    XCTAssert("scratch".appendingPathExtension(ext) == "scratch.tiff")
  }

}
