//
//  Integer+Random.swift
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

import Foundation

extension Integer {

  /// **Mechanica**
  ///
  /// Returns a random value.
  public static func random() -> Self {
    var result: Self = 0
    //    withUnsafeMutablePointer(to: &result) { resultPtr in
    //      arc4random_buf(UnsafeMutablePointer(resultPtr), MemoryLayout<Self>.size)
    //    }
    arc4random_buf(UnsafeMutablePointer(&result), MemoryLayout<Self>.size)
    return result
  }

}


/// **Mechanica**
///
/// Types adopting the `FixedWidthInteger` protocol can be used as `Integer` with a fixed width.
public protocol FixedWidthInteger : Integer {

  /// **Mechanica**
  ///
  /// max value
  static var max: Self { get }

  /// **Mechanica**
  ///
  /// min value
  static var min: Self { get }
}

extension UInt64: FixedWidthInteger {}
extension Int64:  FixedWidthInteger {}
extension UInt32: FixedWidthInteger {}
extension Int32:  FixedWidthInteger {}
extension UInt16: FixedWidthInteger {}
extension Int16:  FixedWidthInteger {}
extension UInt8:  FixedWidthInteger {}
extension Int8:   FixedWidthInteger {}
extension UInt:   FixedWidthInteger {}
extension Int:    FixedWidthInteger {}

extension FixedWidthInteger {

  internal static func bitwiseCeil<T : FixedWidthInteger>(x: T) -> T {
    var i = ~T.min
    while ~i < x {
      i = T.multiplyWithOverflow(i, 2).0
    }
    return ~i
  }

  //  public static func random(max: Self) -> Self {
  //    let m = bitwiseCeil(x: max)
  //    var result: Self = 0 //FIXED HERE
  //    repeat {
  //      arc4random_buf(&result, MemoryLayout<Self>.size)
  //      //print("result_before: \(result)")
  //      result &= m
  //
  //      print("result_after: \(result)")
  //
  //    } while result > max
  //    return result
  //  }



}

extension FixedWidthInteger where Stride: SignedInteger {

  static func random(max: Self) -> Self {
    print(max)
    print(Self.self.min)
    return random(in: Self.min...max)
  }

  public static func random(interval: CountableClosedRange<Self>) -> Self {
    let a = interval.lowerBound
    let b = interval.upperBound

    func random(max: Self) -> Self {
      let m = bitwiseCeil(x: max)
      var result: Self = 0 //FIXED HERE
      repeat {
        arc4random_buf(&result, MemoryLayout<Self>.size)
        result &= m

      } while result > max
      return result
    }
    return a + random(max: b - a)
  }


  //  public static func random(interval: CountableClosedRange<Self>) -> Self {
  //    let a = interval.lowerBound
  //    let b = interval.upperBound
  //    return a + random(max: b - a)
  //  }

  /// **Mechanica**
  ///
  /// Returns a random FixedWidthInteger bounded by a closed interval range.
  //  public static func random(in range: CountableClosedRange<Self>) -> Self {
  //    let rangeSize = range.upperBound - range.lowerBound
  //    guard (rangeSize != 0) else { return range.upperBound }
  //    var randomValue = random()
  //    let (result, overflow) = subtractWithOverflow(range.upperBound, range.lowerBound)
  //    let maxDivisible = overflow ? max - ~result : result
  //    while randomValue < maxDivisible {
  //      randomValue = random()
  //    }
  //    return (randomValue % rangeSize) + range.lowerBound
  //  }
  //  public static func random(in range: CountableClosedRange<Self>) -> Self {
  //    let lowerBound = range.lowerBound
  //    let upperBound = range.upperBound
  //    let rangeSize = upperBound - lowerBound
  //    guard (rangeSize != 0) else { return upperBound }
  //    let (result, _) = subtractWithOverflow(upperBound, lowerBound)
  //    let r = random(interval: 0...result)
  //    return addWithOverflow(lowerBound, r).0
  //  }

  public static func random(in range: CountableClosedRange<Self>) -> Self {
    let lowerBound = range.lowerBound
    let upperBound = range.upperBound
    guard (lowerBound != upperBound) else { return lowerBound }
    let (result, overflow) = subtractWithOverflow(upperBound, lowerBound)

    //let r = random(interval: 0...result)

    func random(max: Self) -> Self {
      let m = bitwiseCeil(x: max)
      var result: Self = 0 //FIXED HERE
      repeat {
        arc4random_buf(&result, MemoryLayout<Self>.size)
        result &= m
      } while result > max
      return result
    }


    if (overflow) {
      //let lb = (lowerBound < 0) ? lowerBound * -1 : lowerBound

      //TODO: fix
      var (lb,overflow) = multiplyWithOverflow(lowerBound, -1)
      if (overflow){
        lb = (lb + 1) * -1
        print(lb)
      }
      let ub = (upperBound < 0) ? upperBound * -1 : upperBound
      let randomMin = random(max: lb) * -1
      let randomMax = random(max: ub)
      let randomValue = randomMax + randomMin
      return randomValue
    } else {
      let randomValue = random(max: result)
      return addWithOverflow(lowerBound, randomValue).0
    }
  }


  /// **Mechanica**
  ///
  /// Returns a random FixedWidthInteger between `min` and `max` values.
  internal static func random(min: Self, max: Self) -> Self {
    return random(in: min...max)
  }
  
}
