//
//  ColorFlatTests.swift
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

class ColorFlatTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func test_flat_colors() {
    XCTAssert(Color.black.hexString == "#000000")
    XCTAssert(Color.Flat.turquoise.hexString == "#1abc9c")
    XCTAssert(Color.Flat.greenSea.hexString == "#16a085")
    XCTAssert(Color.Flat.nephritis.hexString == "#27ae60")
    XCTAssert(Color.Flat.emerald.hexString == "#2ecc71")
    XCTAssert(Color.Flat.belizeHole.hexString == "#2980b9")
    XCTAssert(Color.Flat.peterRiver.hexString == "#3498db")
    XCTAssert(Color.Flat.wisteria.hexString == "#8e44ad")
    XCTAssert(Color.Flat.amethyst.hexString == "#9b59b6")
    XCTAssert(Color.Flat.midnightBlue.hexString == "#2c3e50")
    XCTAssert(Color.Flat.wetAsphalt.hexString == "#34495e")
    XCTAssert(Color.Flat.sunFlower.hexString == "#f1c40f")
    XCTAssert(Color.Flat.orange.hexString == "#f39c12")
    XCTAssert(Color.Flat.carrot.hexString == "#e67e22")
    XCTAssert(Color.Flat.pumpkin.hexString == "#d35400")
    XCTAssert(Color.Flat.alizarin.hexString == "#e74c3c")
    XCTAssert(Color.Flat.pomegranate.hexString == "#c0392b")
    XCTAssert(Color.Flat.clouds.hexString == "#ecf0f1")
    XCTAssert(Color.Flat.silver.hexString == "#bdc3c7")
    XCTAssert(Color.Flat.concrete.hexString == "#95a5a6")
    XCTAssert(Color.Flat.asbestos.hexString == "#7f8c8d")
    
  }
  
  func test_P3_rgba() {
    
    //P3{234,51,35}
    let redP3 = Color(displayP3Red: 234/255, green: 51/255, blue: 35/255, alpha: 255/255)
    let redRGBA = Color.red //Color(red: 255/255, green: 0/255, blue: 0/255, alpha: 255/255)
    let redExtended = Color(red: 1.358, green: -0.074, blue:  -0.012, alpha: 255/255)
    
    var a: CGFloat = 0.0
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    redP3.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    XCTAssert(redP3.rgba! == redRGBA.rgba!)
    
    let c = Color(red: 1.1, green: -0.25, blue: 0.0, alpha: 1.0)
    
    //RGBA{153,102,51,255} P3{146,104,60,255} --> P3_TO_RGBA{153,101,50,255}
    let brownP3 = Color(displayP3Red: 146/255, green: 104/255, blue: 60/255, alpha: 255/255)
    let brownRGBA = Color.brown
    //146 104 60
    
    let peterRiverP3 = Color(displayP3Red: 0.322, green: 0.588, blue: 0.835, alpha: 1.0)
    let peterRiverRGBA = Color(red: 52/255, green: 152/255, blue: 219/255, alpha: 255/255)
    //Color.Flat.peterRiver
    //rgba(52, 152, 219, 255)
    
    //XCTAssert(peterRiverP3.rgbaCompatible! == peterRiverRGBA.rgba!)
    
    
    //(142, 68, 173, 1.0)
    let wisteriaP3 = Color(displayP3Red: 132/255, green: 72/255, blue: 167/255, alpha: 255/255)
    let wisteriaRGBA = Color(red: 142/255, green: 68/255, blue: 173/255, alpha: 255/255)
    
    //XCTAssert(wisteriaP3.rgbaCompatible! == wisteriaRGBA.rgba!)
  
  }
  
  func test_randomColor() {
    let randomColor = Color.random()
    let colorSpace = randomColor.cgColor.colorSpace
    XCTAssertNotNil(colorSpace)
    let colorSpaceName = colorSpace!.name
    XCTAssertNotNil(colorSpaceName)
    
    #if os(iOS) || os(tvOS) || os(watchOS)
      XCTAssert(colorSpaceName! == CGColorSpace.extendedSRGB)
    #else
      XCTAssert(colorSpaceName! == CGColorSpace.sRGB)
    #endif
  }
  
}


