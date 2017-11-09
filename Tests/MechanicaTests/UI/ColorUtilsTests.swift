//
//  ColorUtilsTests.swift
//  Mechanica
//
//  Copyright © 2016-2017 Tinrobots.
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

class ColorUtilsTests: XCTestCase {

  // MARK - RGBA

  func testRGBA() {
    XCTAssertTrue(Color.red.rgba! == (1.0, 0.0, 0.0, 1.0))
    XCTAssertTrue(Color.yellow.rgba! == (1.0, 1.0, 0.0, 1.0))
    XCTAssertTrue(Color.black.rgba! == (0.0, 0.0, 0.0, 1.0))
  }

  func testRGBAInt() {
    XCTAssertTrue(Color.red.rgbaComponents! == (255, 0, 0, 255))
    XCTAssertTrue(Color.yellow.rgbaComponents! == (255, 255, 0, 255))
    XCTAssertTrue(Color.black.rgbaComponents! == (0, 0, 0, 255))
  }

  func testHex() {

    do {
      // purple (85,26,139) "#551a8b"
      let purple = Color(hexString: "#551a8b" )
      XCTAssertNotNil(purple)

      let (r,g,b,a) = purple!.rgba!
      XCTAssert(r * 255 == 85)
      XCTAssert(g * 255 == 26)
      XCTAssert(b * 255 == 139)
      XCTAssert(a * 255 == 255)
    }

    do {
      // purple (85,26,139) "#551a8b"
      let purple = Color(hexString: "#551A8B" )
      XCTAssertNotNil(purple)
      let (r,g,b,a) = purple!.rgba!
      XCTAssert(r * 255 == 85)
      XCTAssert(g * 255 == 26)
      XCTAssert(b * 255 == 139)
      XCTAssert(a * 255 == 255)
    }

    do {
      // green (0,128,0) "#008000"
      let green = Color(hexString: "#008000" )
      XCTAssertNotNil(green)
      let (r,g,b,a) = green!.rgba!
      XCTAssert(r * 255 == 0)
      XCTAssert(g * 255 == 128)
      XCTAssert(b * 255 == 0)
      XCTAssert(a * 255 == 255)
    }

    do {
      let aqua = Color(hexString: "#0ff" )
      XCTAssertNotNil(aqua)

      let black = Color(hexString: "#000" )
      XCTAssertNotNil(black)

      let blue = Color(hexString: "#00f" )
      XCTAssertNotNil(blue)

      let fuchsia = Color(hexString: "#f0f" )
      XCTAssertNotNil(fuchsia)

      let lime = Color(hexString: "0f0" )
      XCTAssertNotNil(lime)

      let red = Color(hexString: "f00" )
      XCTAssertNotNil(red)
      XCTAssert(red!.rgba! == Color.red.rgba!)

      let white = Color(hexString: "fff" )
      XCTAssertNotNil(white)
      XCTAssert(white!.rgba! == Color.white.rgba!)

      let yellow = Color(hexString: "ff0" )
      XCTAssertNotNil(yellow)
      XCTAssert(yellow!.rgba! == Color.yellow.rgba!)

    }

    do {
      let wrongColor = Color(hexString: "#551A8B1" )
      XCTAssertNil(wrongColor)
      let wrongColor2 = Color(hexString: "#551A8" )
      XCTAssertNil(wrongColor2)
      let wrongColor3 = Color(hexString: "#" )
      XCTAssertNil(wrongColor3)
      let wrongColor4 = Color(hexString: " #551A8B" )
      XCTAssertNil(wrongColor4)
      let wrongColor5 = Color(hexString: "ff  " )
      XCTAssertNil(wrongColor5)
      let wrongColor6 = Color(hexString: "" )
      XCTAssertNil(wrongColor6)
    }

  }

  @available(iOS 10, tvOS 10, watchOS 3, macOS 10.12, *)
  func testConvertingToCompatibleSRGBColor() {
    // Given, When
    /// RGB{255, 0, 0} P3{234, 51, 35}
    let redP3 = Color(displayP3Red: 234/255, green: 51/255, blue: 35/255, alpha: 255/255)
    let redRGBA = Color.red // Color(red: 255/255, green: 0/255, blue: 0/255, alpha: 255/255)
    let redExtended = Color(red: 1.358, green: -0.074, blue:  -0.012, alpha: 255/255)
    // Then
    XCTAssert(redP3.rgba! == redRGBA.rgba!)
    XCTAssert(redExtended.rgba! == redRGBA.rgba!)

    /// Converting a color from an extended sRGB space to sRGB, involves an approximation in the new RGBA values.
    /// (usingColorSpace(_:) documentation: "Although the new color might have different component values, it looks the same as the original.")

    do {
      // Given, When
      /// RGBA{153, 102, 51}
      let brownRGBA = Color.brown
      /// P3{145, 104, 60}
      let brownP3 = Color(displayP3Red: 145/255, green: 104/255, blue: 60/255, alpha: 255/255)
      /// RGBA_FROM_P3{152, 101, 51, 255}
      let (r_p3, g_p3, b_p3, a_p3) = brownP3.rgba!
      let (r, g, b, a) = brownRGBA.rgba!
      // Then
      XCTAssertEqual(Double(r_p3) * 255, Double(r) * 255, accuracy: 1.0)
      XCTAssertEqual(Double(g_p3) * 255, Double(g) * 255, accuracy: 1.0)
      XCTAssertEqual(Double(b_p3) * 255, Double(b) * 255, accuracy: 1.0)
      XCTAssertTrue(a == a_p3)
    }

    do {
      // Given, When
      /// RGB(52, 152, 219)
      let peterRiverRGBA = Color(red: 52/255, green: 152/255, blue: 219/255, alpha: 255/255)
      /// P3{82, 150, 213)
      let peterRiverP3 = Color(displayP3Red: 82/255, green: 150/255, blue: 213/255, alpha: 255/255)
      /// RGBA_FROM_P3{52, 152, 218, 255}
      let (r_p3, g_p3, b_p3, a_p3) = peterRiverP3.rgba!
      let (r, g, b, a) = peterRiverRGBA.rgba!
      // Then
      XCTAssertTrue(r * 255 - 1...r * 255 + 1 ~= r_p3 * 255)
      XCTAssertTrue(g * 255 - 1...g * 255 + 1 ~= g_p3 * 255)
      XCTAssertTrue(b * 255 - 1...b * 255 + 1 ~= b_p3 * 255)
      XCTAssertTrue(a == a_p3)
    }

    do {
      // Given, When
      /// RGB(142, 68, 173)
      let wisteriaRGBA = Color(red: 142/255, green: 68/255, blue: 173/255, alpha: 255/255)
      /// P3{132,72,168,255}}
      let wisteriaP3 = Color(displayP3Red: 132/255, green: 72/255, blue: 168/255, alpha: 255/255)
      /// RGBA_FROM_P3{141, 68, 173, 255}
      let (r_p3, g_p3, b_p3, a_p3) = wisteriaP3.rgba!
      let (r, g, b, a) = wisteriaRGBA.rgba!
      // Then
      XCTAssertEqual(Double(r_p3) * 255, Double(r) * 255, accuracy: 1.0)
      XCTAssertEqual(Double(g_p3) * 255, Double(g) * 255, accuracy: 1.0)
      XCTAssertEqual(Double(b_p3) * 255, Double(b) * 255, accuracy: 1.0)
      XCTAssertTrue(a == a_p3)
    }

  }

  func testLightened() {
    // Given, When
    let gray = Color(red:0.5, green:0.5, blue: 0.5, alpha: 1)
    // Then

    XCTAssertEqual(gray.lightened(by: 0.5), Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 1))
    XCTAssertEqual(Color.red.lightened(by: 0.5), Color(red: 1.5, green: 0.5, blue: 0.5, alpha: 1))
    XCTAssertEqual(Color.green.lightened(by: 0.5), Color(red: 0.5, green: 1.5, blue: 0.5, alpha: 1))
    XCTAssertEqual(Color.blue.lightened(by: 0.5), Color(red: 0.5, green: 0.5, blue: 1.5, alpha: 1))
  }

  func testDarkened() {
    // Given, When
    let gray = Color(red:0.5, green:0.5, blue: 0.5, alpha: 1)
    // Then
    XCTAssertEqual(gray.darkened(by: 0.5), Color(red: 0, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.red.darkened(by: 0.5), Color(red: 0.5, green: -0.5, blue: -0.5, alpha: 1))
    XCTAssertEqual(Color.green.darkened(by: 0.5), Color(red: -0.5, green: 0.5, blue: -0.5, alpha: 1))
    XCTAssertEqual(Color.blue.darkened(by: 0.5), Color(red: -0.5, green: -0.5, blue: 0.5, alpha: 1))
  }


  func testRandomColor() {
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

  func testMixingColor() {
    // Given, When
    let red = Color(red: 1.0, green: 0, blue: 0, alpha: 1.0)
    let yellow = Color(red: 1.0, green: 1.0, blue: 0, alpha: 1.0)
    let expectedOrange = Color(red: 1.0, green: 0.5, blue: 0, alpha: 1.0)
    let orange = red.mixing(with: yellow, by: 0.5) //half red and half yellow
    // Then
    XCTAssertNotNil(orange)
    XCTAssertTrue(orange! == expectedOrange)
  }


  // MARK - Initializers

  func testInitHex() {
    // Given, When
    let red = Color(red: 1.0, green: 0, blue: 0, alpha: 1.0)
    let green = Color(red: 0, green: 1.0, blue: 0, alpha: 1.0)
    let blue = Color(red: 0, green: 0, blue: 1.0, alpha: 1.0)
    // Then
    XCTAssertEqual(Color(hex: 0xFF0000), red)
    XCTAssertEqual(Color(hex:16711680), red)
    XCTAssertEqual(Color(hex: 0x00FF00), green)
    XCTAssertEqual(Color(hex: 0x0000FF), blue)
    XCTAssertEqual(Color(hex: 0xFF0000, alpha: 0.5), red.withAlphaComponent(0.5))
    XCTAssertEqual(Color(hex: 0x00FF00, alpha: 0.5), green.withAlphaComponent(0.5))
    XCTAssertEqual(Color(hex: 0x0000FF, alpha: 0.5), blue.withAlphaComponent(0.5))
  }

  // MARK - HSBA

  func testHsba() {

    do {
      let hsba = Color.Flat.peterRiver.hsba
      XCTAssertNotNil(hsba)
      let color = Color(hue: hsba!.hue, saturation: hsba!.saturation, brightness: hsba!.brightness, alpha: hsba!.alpha)
      let peterRiverRGBA = Color.Flat.peterRiver.rgba!
      let colorRGBA = color.rgba!
      XCTAssertEqual(Double(peterRiverRGBA.red) * 255, Double(colorRGBA.red) * 255, accuracy: 1.0)
      XCTAssertEqual(Double(peterRiverRGBA.green) * 255, Double(colorRGBA.green) * 255, accuracy: 1.0)
      XCTAssertTrue(peterRiverRGBA.blue * 255 == colorRGBA.blue * 255)
      XCTAssertTrue(peterRiverRGBA.alpha * 255 == colorRGBA.alpha * 255)
    }

    do {
      // Given, When
      let hsba = Color.red.hsba
      XCTAssertNotNil(hsba)
      let color = Color(hue: hsba!.hue, saturation: hsba!.saturation, brightness: hsba!.brightness, alpha: hsba!.alpha)
      let redRGBA = Color.red.rgba!
      let colorRGBA = color.rgba!
      // Then
      XCTAssertTrue(redRGBA.red * 255 == colorRGBA.red * 255)
      XCTAssertTrue(redRGBA.green * 255 == colorRGBA.green * 255)
      XCTAssertTrue(redRGBA.blue * 255 == colorRGBA.blue * 255)
      XCTAssertTrue(redRGBA.alpha * 255 == colorRGBA.alpha * 255)
      XCTAssertTrue(Color.red.rgbaComponents! == color.rgbaComponents!)
    }

    do {
      // Given, When
      let white = Color(red: 0, green: 0, blue: 0, alpha: 1.0)
      let hsba = white.hsba
      XCTAssertNotNil(hsba)
      let color = Color(hue: hsba!.hue, saturation: hsba!.saturation, brightness: hsba!.brightness, alpha: hsba!.alpha)
      let whiteRGBA = white.rgba!
      let colorRGBA = color.rgba!
      // Then
      XCTAssertTrue(whiteRGBA.red * 255 == colorRGBA.red * 255)
      XCTAssertTrue(whiteRGBA.green * 255 == colorRGBA.green * 255)
      XCTAssertTrue(whiteRGBA.blue * 255 == colorRGBA.blue * 255)
      XCTAssertTrue(whiteRGBA.alpha * 255 == colorRGBA.alpha * 255)
      XCTAssertTrue(white.rgbaComponents! == color.rgbaComponents!)
    }

  }

  func testChangingBrightness() {
    // Given
    let gray = Color(red:0.5, green:0.5, blue: 0.5, alpha: 1)

    // When, Then
    XCTAssertEqual(gray.changingBrightness(by: 0.0), gray)
    XCTAssertEqual(gray.changingBrightness(by: 0.5), Color(red: 1.0, green: 1.0, blue: 1.0, alpha:1))
    XCTAssertEqual(Color.red.changingBrightness(by: 0.5), Color(red: 1.5, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.green.changingBrightness(by: 0.5), Color(red: 0, green: 1.5, blue: 0, alpha: 1))
    XCTAssertEqual(Color.blue.changingBrightness(by: 0.5), Color(red: 0, green: 0, blue: 1.5, alpha: 1))

    XCTAssertEqual(gray.changingBrightness(by: -0.0), gray)
    XCTAssertEqual(gray.changingBrightness(by: -0.5), Color(red: 0, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.red.changingBrightness(by: -0.5), Color(red: 0.5, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.green.changingBrightness(by: -0.5), Color(red: 0, green: 0.5, blue: 0, alpha: 1))
    XCTAssertEqual(Color.blue.changingBrightness(by: -0.5), Color(red: 0, green: 0, blue: 0.5, alpha: 1))
  }

  func testChangingSaturation() {
    // Given
    let gray = Color(red:0.5, green:0.5, blue: 0.5, alpha: 1)

    // When, Then
    XCTAssertEqual(gray.changingSaturation(by: 0.0), gray)
    XCTAssertEqual(gray.changingSaturation(by: 0.5), Color(red: 0.5, green: 0.25, blue: 0.25, alpha: 1))
    XCTAssertEqual(Color.red.changingSaturation(by: 0.5), Color(red: 1, green: -0.5, blue: -0.5, alpha: 1))
    XCTAssertEqual(Color.green.changingSaturation(by: 0.5), Color(red: -0.5, green: 1.0, blue:-0.5, alpha: 1))
    XCTAssertEqual(Color.blue.changingSaturation(by: 0.5), Color(red: -0.5, green: -0.5, blue: 1.0, alpha: 1))

    XCTAssertEqual(gray.changingSaturation(by: -0.0), gray)
    XCTAssertEqual(gray.changingSaturation(by: -0.5), Color(red: 0.5, green: 0.75, blue: 0.75, alpha: 1))
    XCTAssertEqual(Color.red.changingSaturation(by: -0.5), Color(red: 1, green: 0.5, blue: 0.5, alpha: 1))
    XCTAssertEqual(Color.green.changingSaturation(by: -0.5), Color(red: 0.5, green: 1.0, blue:0.5, alpha: 1))
    XCTAssertEqual(Color.blue.changingSaturation(by: -0.5), Color(red: 0.5, green: 0.5, blue: 1.0, alpha: 1))
  }

}



