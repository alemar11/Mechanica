//
//  FloatingPoint+Utils.swift
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

import Foundation

extension FloatingPoint {
  
  /// Returns a `new` rounded `FloatingPoint` to specified number of decimal `places`.
  public func roundedToDecimalPlaces(_ places: Int) -> Self {
    guard places >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<places { divisor.multiply(by: 10) }
    return (self * divisor).rounded() / divisor
  }
  
  /// Rounds `self` to specified number of decimal `places`.
  public mutating func roundToDecimalPlaces(_ places: Int) {
    self = roundedToDecimalPlaces(places)
  }
  
  /// Returns a `new` ceiled `FloatingPoint` to specified number of decimal `places`.
  public func ceiledToDecimalPlaces(_ places: Int) -> Self {
    guard places >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<places { divisor.multiply(by: 10) }
    return ceil(self * divisor) / divisor //equals to (self * divisor).rounded(.up) / divisor
  }
  
  /// Ceils `self` to specified number of decimal `places`.
  public mutating func ceilToDecimalPlaces(_ places: Int) {
    self = ceiledToDecimalPlaces(places)
  }
  
  /// Returns a `new` floored `FloatingPoint` to specified number of decimal `places`.
  public func flooredToDecimalPlaces(_ places: Int) -> Self {
    guard places >= 0 else { return self }
    var divisor: Self = 1
    for _ in 0..<places { divisor.multiply(by: 10) }
    return floor(self * divisor) / divisor
  }
  
  /// Floors `self` to specified number of decimal `places`.
  public mutating func floorToDecimalPlaces(_ places: Int) {
    self = ceiledToDecimalPlaces(places)
  }
  
}
