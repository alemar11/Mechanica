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

  func test_rgba() {
    XCTAssertTrue(Color.red.rgba! == (1.0, 0.0, 0.0, 1.0))
    XCTAssertTrue(Color.yellow.rgba! == (1.0, 1.0, 0.0, 1.0))
    XCTAssertTrue(Color.black.rgba! == (0.0, 0.0, 0.0, 1.0))
  }

  func test_rgba8bit() {

    do {
      let red = Color.red // 1.0, 0.0, 0.0
      XCTAssertNotNil(red.rgba8Bit)
      let (r,g,b,a) = red.rgba8Bit
      XCTAssert(r == 255)
      XCTAssert(g == 0)
      XCTAssert(b == 0)
      XCTAssert(a == 255)
    }

    do {
      let black = Color.black // 0.0, 0.0, 0.0
      XCTAssertNotNil(black.rgba8Bit)
      let (r,g,b,a) = black.rgba8Bit
      XCTAssert(r == 0)
      XCTAssert(g == 0)
      XCTAssert(b == 0)
      XCTAssert(a == 255)
    }

    //orange (255,165,0)
    do {
      #if os(iOS) || os(tvOS) || os(watchOS)
        let orange = Color(red: 255/255, green: 165/255, blue: 0, alpha: 1)
      #elseif os(OSX)
        let orange = Color(srgbRed: 255/255, green: 165/255, blue: 0, alpha: 1)
      #endif
      XCTAssertNotNil(orange.rgba8Bit)
      let (r,g,b,a) = orange.rgba8Bit
      XCTAssert(r == 255)
      XCTAssert(g == 165)
      XCTAssert(b == 0)
      XCTAssert(a == 255)
    }

    #if os(OSX)
      do {
        let orange_custom = Color(red: 255/255, green: 165/255, blue: 0, alpha: 1)
        let orange_calibrated = Color(calibratedRed: 255/255, green: 165/255, blue: 0, alpha: 1)
        let orange_device = Color(deviceRed: 255/255, green: 165/255, blue: 0, alpha: 1)
        XCTAssertNotNil(orange_custom.rgba8Bit)
        XCTAssertNotNil(orange_calibrated.rgba8Bit)
        XCTAssertNotNil(orange_device.rgba8Bit)
        XCTAssert(orange_custom.rgba8Bit == (255,165,0,255))
        XCTAssert(orange_calibrated.rgba8Bit == (255,165,0,255))
        XCTAssert(orange_device.rgba8Bit == (255,165,0,255))
      }
    #endif

  }

  func test_rgb32Bit() {
    XCTAssertTrue(Color.red.rgb32Bit == 16711680)
    XCTAssertTrue(Color.yellow.rgb32Bit == 16776960)
  }

  func test_rgba32Bit() {

    do {
      XCTAssertTrue(Color.red.rgba32Bit == 4278190335)
      let hexString = Int(Color.red.rgba32Bit).hexadecimalString()
      let red = Color(hexString: hexString)
      XCTAssertNotNil(red)
      XCTAssertEqual(red, Color.red)
    }

    do {
      XCTAssertTrue(Color.yellow.rgba32Bit == 4294902015)
      let hexString = Int(Color.yellow.rgba32Bit).hexadecimalString()
      let red = Color(hexString: hexString)
      XCTAssertNotNil(red)
      XCTAssertEqual(red, Color.yellow)
    }

  }

  func test_hex() {

    do {
      //purple (85,26,139) "#551a8b"
      let purple = Color(hexString: "#551a8b" )
      XCTAssertNotNil(purple)
      let (r,g,b,a) = purple!.rgba8Bit
      XCTAssert(r == 85)
      XCTAssert(g == 26)
      XCTAssert(b == 139)
      XCTAssert(a == 255)
    }

    do {
      //purple (85,26,139) "#551a8b"
      let purple = Color(hexString: "#551A8B" )
      XCTAssertNotNil(purple)
      let (r,g,b,a) = purple!.rgba8Bit
      XCTAssert(r == 85)
      XCTAssert(g == 26)
      XCTAssert(b == 139)
      XCTAssert(a == 255)
    }

    do {
      //green (0,128,0) "#008000"
      let green = Color(hexString: "#008000" )
      XCTAssertNotNil(green)
      let (r,g,b,a) = green!.rgba8Bit
      XCTAssert(r == 0)
      XCTAssert(g == 128)
      XCTAssert(b == 0)
      XCTAssert(a == 255)
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
      XCTAssert(red!.rgba8Bit == Color.red.rgba8Bit)

      let white = Color(hexString: "fff" )
      XCTAssertNotNil(white)
      XCTAssert(white!.rgba8Bit == Color.white.rgba8Bit)

      let yellow = Color(hexString: "ff0" )
      XCTAssertNotNil(yellow)
      XCTAssert(yellow!.rgba8Bit == Color.yellow.rgba8Bit)
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

  func test_convertingToCompatibleSRGBColor() {

    /// RGB{255, 0, 0} P3{234, 51, 35}
    let redP3 = Color(displayP3Red: 234/255, green: 51/255, blue: 35/255, alpha: 255/255)
    let redRGBA = Color.red //Color(red: 255/255, green: 0/255, blue: 0/255, alpha: 255/255)
    let redExtended = Color(red: 1.358, green: -0.074, blue:  -0.012, alpha: 255/255)

    XCTAssert(redP3.rgba8Bit == redRGBA.rgba8Bit)
    XCTAssert(redExtended.rgba8Bit == redRGBA.rgba8Bit)

    /// Converting a color from an extended sRGB space to sRGB, involves an approximation in the new RGBA values.
    /// (usingColorSpace(_:) documentation: "Although the new color might have different component values, it looks the same as the original.")

    do {
      /// RGBA{153, 102, 51}
      let brownRGBA = Color.brown

      /// P3{145, 104, 60}
      let brownP3 = Color(displayP3Red: 145/255, green: 104/255, blue: 60/255, alpha: 255/255)

      /// RGBA_FROM_P3{152, 101, 51, 255}
      let (r_p3, g_p3, b_p3, a_p3) = brownP3.rgba8Bit
      let (r, g, b, a) = brownRGBA.rgba8Bit

      XCTAssertTrue(r-1...r+1 ~= r_p3)
      XCTAssertTrue(g-1...g+1 ~= g_p3)
      XCTAssertTrue(b-1...b+1 ~= b_p3)
      XCTAssertTrue(a == a_p3)
    }

    do {
      /// RGB(52, 152, 219)
      let peterRiverRGBA = Color(red: 52/255, green: 152/255, blue: 219/255, alpha: 255/255)
      /// P3{82, 150, 213)
      let peterRiverP3 = Color(displayP3Red: 82/255, green: 150/255, blue: 213/255, alpha: 255/255)
      //let peterRiverP3 = Color(displayP3Red: 0.3210, green: 0.5880, blue: 0.8370, alpha: 255/255)
      //Color.Flat.peterRiver

      /// RGBA_FROM_P3{52, 152, 218, 255}

      let (r_p3, g_p3, b_p3, a_p3) = peterRiverP3.rgba8Bit
      let (r, g, b, a) = peterRiverRGBA.rgba8Bit

      XCTAssertTrue(r-1...r+1 ~= r_p3)
      XCTAssertTrue(g-1...g+1 ~= g_p3)
      XCTAssertTrue(b-1...b+1 ~= b_p3)
      XCTAssertTrue(a == a_p3)
    }


    do {
      /// RGB(142, 68, 173)
      let wisteriaRGBA = Color(red: 142/255, green: 68/255, blue: 173/255, alpha: 255/255)
      /// P3{132,72,168,255}}
      let wisteriaP3 = Color(displayP3Red: 132/255, green: 72/255, blue: 168/255, alpha: 255/255)

      /// RGBA_FROM_P3{141, 68, 173, 255}
      let (r_p3, g_p3, b_p3, a_p3) = wisteriaP3.rgba8Bit
      let (r, g, b, a) = wisteriaRGBA.rgba8Bit

      XCTAssertTrue(r-1...r+1 ~= r_p3)
      XCTAssertTrue(g-1...g+1 ~= g_p3)
      XCTAssertTrue(b-1...b+1 ~= b_p3)
      XCTAssertTrue(a == a_p3)
    }

  }

  func test_lightened() {
    XCTAssertEqual(Color.gray.lightened(by: 0.5), UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1))
    XCTAssertEqual(Color.red.lightened(by: 0.5), UIColor(red: 1.5, green: 0.5, blue: 0.5, alpha: 1))
    XCTAssertEqual(Color.green.lightened(by: 0.5), UIColor(red: 0.5, green: 1.5, blue: 0.5, alpha: 1))
    XCTAssertEqual(Color.blue.lightened(by: 0.5), UIColor(red: 0.5, green: 0.5, blue: 1.5, alpha: 1))
  }

  func test_darkened() {
    XCTAssertEqual(Color.gray.darkened(by: 0.5), Color(red: 0, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.red.darkened(by: 0.5), Color(red: 0.5, green: -0.5, blue: -0.5, alpha: 1))
    XCTAssertEqual(Color.green.darkened(by: 0.5), Color(red: -0.5, green: 0.5, blue: -0.5, alpha: 1))
    XCTAssertEqual(Color.blue.darkened(by: 0.5), Color(red: -0.5, green: -0.5, blue: 0.5, alpha: 1))
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

  func test_mixingColor() {
    let red = Color.red
    let yellow = Color.yellow
    let orange = red.mixing(with: yellow, by: 0.5) //half red and half yellow
    XCTAssertNotNil(orange)
    XCTAssertTrue(orange! == Color.orange)
  }


  // MARK - Initializers

  func test_initHex() {
    XCTAssertEqual(Color(hex: 0xFF0000), Color.red)
    XCTAssertEqual(Color(hex: 0x00FF00), Color.green)
    XCTAssertEqual(Color(hex: 0x0000FF), Color.blue)
    XCTAssertEqual(Color(hex: 0xFF0000, alpha: 0.5), Color.red.withAlphaComponent(0.5))
    XCTAssertEqual(Color(hex: 0x00FF00, alpha: 0.5), Color.green.withAlphaComponent(0.5))
    XCTAssertEqual(Color(hex: 0x0000FF, alpha: 0.5), Color.blue.withAlphaComponent(0.5))
  }

  // MARK - HSBA

  func test_hsba() {

    do {
      let hsba = Color.Flat.peterRiver.hsba
      XCTAssertNotNil(hsba)
      let color = Color(hue: hsba!.hue, saturation: hsba!.saturation, brightness: hsba!.brightness, alpha: hsba!.alpha)
      XCTAssertTrue( Color.Flat.peterRiver.rgba8Bit == color.rgba8Bit)
    }

    do {
      let hsba = Color.red.hsba
      XCTAssertNotNil(hsba)
      let color = Color(hue: hsba!.hue, saturation: hsba!.saturation, brightness: hsba!.brightness, alpha: hsba!.alpha)
      XCTAssertTrue( Color.red.rgba8Bit == color.rgba8Bit)
    }

    do {
      let hsba = Color.white.hsba
      XCTAssertNotNil(hsba)
      let color = Color(hue: hsba!.hue, saturation: hsba!.saturation, brightness: hsba!.brightness, alpha: hsba!.alpha)
      XCTAssertTrue( Color.white.rgba8Bit == color.rgba8Bit)
    }

  }

  func test_lightenedByIncreasingBrightness() {
    XCTAssertEqual(Color.gray.lightened(byIncreasingBrightness: 0.5), Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 1))
    XCTAssertEqual(Color.red.lightened(byIncreasingBrightness: 0.5), Color(red: 1.5, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.green.lightened(byIncreasingBrightness: 0.5), Color(red: 0, green: 1.5, blue: 0, alpha: 1))
    XCTAssertEqual(Color.blue.lightened(byIncreasingBrightness: 0.5), Color(red: 0, green: 0, blue: 1.5, alpha: 1))
  }

  func test_darkenedByDecreasingBrightness() {
    XCTAssertEqual(Color.gray.darkened(byDecreasingBrightness: 0.5), Color(red: 0, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.red.darkened(byDecreasingBrightness: 0.5), Color(red: 0.5, green: 0, blue: 0, alpha: 1))
    XCTAssertEqual(Color.green.darkened(byDecreasingBrightness: 0.5), Color(red: 0, green: 0.5, blue: 0, alpha: 1))
    XCTAssertEqual(Color.blue.darkened(byDecreasingBrightness: 0.5), Color(red: 0, green: 0, blue: 0.5, alpha: 1))
  }

  func test_shadedByIncreasingSaturation() {
    XCTAssertEqual(Color.gray.shaded(byIncreasingSaturation: 0.5), Color(red: 0.5, green: 0.25, blue: 0.25, alpha: 1))
    XCTAssertEqual(Color.red.shaded(byIncreasingSaturation: 0.5), Color(red: 1, green: -0.5, blue: -0.5, alpha: 1))
    XCTAssertEqual(Color.green.shaded(byIncreasingSaturation: 0.5), Color(red: -0.5, green: 1.0, blue:-0.5, alpha: 1))
    XCTAssertEqual(Color.blue.shaded(byIncreasingSaturation: 0.5), Color(red: -0.5, green: -0.5, blue: 1.0, alpha: 1))
  }

  func test_tintedByDecreasingSaturation() {
    XCTAssertEqual(Color.gray.tinted(byDecreasingSaturation: 0.5), Color(red: 0.5, green: 0.75, blue: 0.75, alpha: 1))
    XCTAssertEqual(Color.red.tinted(byDecreasingSaturation: 0.5), Color(red: 1, green: 0.5, blue: 0.5, alpha: 1))
    XCTAssertEqual(Color.green.tinted(byDecreasingSaturation: 0.5), Color(red: 0.5, green: 1.0, blue:0.5, alpha: 1))
    XCTAssertEqual(Color.blue.tinted(byDecreasingSaturation: 0.5), Color(red: 0.5, green: 0.5, blue: 1.0, alpha: 1))
  }
  
}
