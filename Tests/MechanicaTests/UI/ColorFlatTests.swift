//
//  ColorFlatTests.swift
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

// TODO: remove
class ColorFlatTests: XCTestCase {

  func testFlatColors() {

    XCTAssert(Color.black.hexString             == "#000000".uppercased())
    XCTAssert(Color.Flat.turquoise.hexString    == "#1abc9c".uppercased())
    XCTAssert(Color.Flat.greenSea.hexString     == "#16a085".uppercased())
    XCTAssert(Color.Flat.nephritis.hexString    == "#27ae60".uppercased())
    XCTAssert(Color.Flat.emerald.hexString      == "#2ecc71".uppercased())
    XCTAssert(Color.Flat.belizeHole.hexString   == "#2980b9".uppercased())
    XCTAssert(Color.Flat.peterRiver.hexString   == "#3498db".uppercased())
    XCTAssert(Color.Flat.wisteria.hexString     == "#8e44ad".uppercased())
    XCTAssert(Color.Flat.amethyst.hexString     == "#9b59b6".uppercased())
    XCTAssert(Color.Flat.midnightBlue.hexString == "#2c3e50".uppercased())
    XCTAssert(Color.Flat.wetAsphalt.hexString   == "#34495e".uppercased())
    XCTAssert(Color.Flat.sunFlower.hexString    == "#f1c40f".uppercased())
    XCTAssert(Color.Flat.orange.hexString       == "#f39c12".uppercased())
    XCTAssert(Color.Flat.carrot.hexString       == "#e67e22".uppercased())
    XCTAssert(Color.Flat.pumpkin.hexString      == "#d35400".uppercased())
    XCTAssert(Color.Flat.alizarin.hexString     == "#e74c3c".uppercased())
    XCTAssert(Color.Flat.pomegranate.hexString  == "#c0392b".uppercased())
    XCTAssert(Color.Flat.clouds.hexString       == "#ecf0f1".uppercased())
    XCTAssert(Color.Flat.silver.hexString       == "#bdc3c7".uppercased())
    XCTAssert(Color.Flat.concrete.hexString     == "#95a5a6".uppercased())
    XCTAssert(Color.Flat.asbestos.hexString     == "#7f8c8d".uppercased())

  }

}


