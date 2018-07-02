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
@testable import Mechanica

enum Resource {

  case glasses
  case glassesWithoutAlpha
  case robot
  case apple
  case scaledToFit(name: String)
  case scaledToFill(name: String)

  var url: URL {
    switch self {
    case .glasses:
      return Resource.folderURL.appendingPathComponent("glasses.png")
    case .glassesWithoutAlpha:
      return Resource.folderURL.appendingPathComponent("glasses_without_alpha.jpeg")
    case .robot:
      return Resource.folderURL.appendingPathComponent("robot.png")
    case .apple:
      return Resource.folderURL.appendingPathComponent("Images/Original/apple.jpg")
    case .scaledToFit(let name):
      return Resource.folderURL.appendingPathComponent("Images/Modified/AspectScaleToFit/\(name)")
    case .scaledToFill(let name):
      return Resource.folderURL.appendingPathComponent("Images/Modified/AspectScaleToFill/\(name)")
    }
  }

  var data : Data {
    return try! Data(contentsOf: url)
  }

  static var folderURL: URL {
    var resources = URL(fileURLWithPath: #file, isDirectory: false).deletingLastPathComponents(2)
    resources.appendPathComponent("Resources")
    return resources
  }

}
