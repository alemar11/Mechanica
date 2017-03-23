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

public protocol Randomizable {
  static func random(min: Self, max: Self) -> Self
}

extension UInt64: Randomizable {}
extension Int64:  Randomizable {}
extension UInt32: Randomizable {}
extension Int32:  Randomizable {}
extension UInt16: Randomizable {}
extension Int16:  Randomizable {}
extension UInt8:  Randomizable {}
extension Int8:   Randomizable {}
extension UInt:   Randomizable {}
extension Int:    Randomizable {}

fileprivate let _wordSize = __WORDSIZE

fileprivate func arc4random <T: ExpressibleByIntegerLiteral> (type: T.Type) -> T {
  var result:T = 0
  arc4random_buf(&result, Int(MemoryLayout<T>.size))
  return result
}

//  MARK: - UnsignedInteger

extension UInt {
  public static func random(min: UInt = min, max: UInt = max) -> UInt {
    switch (_wordSize) {
    case 32: return UInt(UInt32.random(min: UInt32(min), max: UInt32(max)))
    case 64: return UInt(UInt64.random(min: UInt64(min), max: UInt64(max)))
    default: return min
    }
  }
}

extension UInt64 {
  public static func random(min: UInt64 = min, max: UInt64 = max) -> UInt64 {
    guard (min != max) else { return min }
    var m: UInt64
    let u = max - min
    var r = arc4random(type: UInt64.self)
    
    if u > UInt64(Int64.max) {
      m = 1 + ~u
    } else {
      //m = ((max - (u * 2)) + 1) % u //crashes if min = 0
      m = ((max - u) + 1) % u
    }
    
    while r < m {
      r = arc4random(type: UInt64.self)
    }
    
    return (r % u) + min
  }
}

extension UInt32 {
  public static func random(min: UInt32 = min, max: UInt32 = max) -> UInt32 {
    guard (min != max) else { return min }
    return arc4random_uniform(max - min) + min
  }
}

extension UInt16 {
  public static func random(min: UInt16 = min, max: UInt16 = max) -> UInt16 {
    guard (min != max) else { return min }
    return UInt16(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
  }
}

extension UInt8 {
  public static func random(min: UInt8 = min, max: UInt8 = max) -> UInt8 {
    guard (min != max) else { return min }
    return UInt8(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
  }
}

//  MARK: - SignedInteger

extension Int {
  public static func random(min: Int = min, max: Int = max) -> Int {
    switch (_wordSize) {
    case 32: return Int(Int32.random(min: Int32(min), max: Int32(max)))
    case 64: return Int(Int64.random(min: Int64(min), max: Int64(max)))
    default: return min
    }
  }
}

extension Int64 {
  public static func random(min: Int64 = min, max: Int64 = max) -> Int64 {
    guard (min != max) else { return min }
    let (s, overflow) = Int64.subtractWithOverflow(max, min)
    let u = overflow ? UInt64.max - UInt64(~s) : UInt64(s)
    let r = UInt64.random(max: u)
    
    if r > UInt64(Int64.max)  {
      return Int64(r - (UInt64(~min) + 1))
    } else {
      return Int64(r) + min
    }
  }
}

extension Int32 {
  public static func random(min: Int32 = min, max: Int32 = max) -> Int32 {
    guard (min != max) else { return min }
    let r = arc4random_uniform(UInt32(Int64(max) - Int64(min)))
    return Int32(Int64(r) + Int64(min))
  }
}


extension Int16 {
  public static func random(min: Int16 = min, max: Int16 = max) -> Int16 {
    guard (min != max) else { return min }
    let r = arc4random_uniform(UInt32(Int32(max) - Int32(min)))
    return Int16(Int32(r) + Int32(min))
  }
}

extension Int8 {
  public static func random(min: Int8 = min, max: Int8 = max) -> Int8 {
    guard (min != max) else { return min }
    let r = arc4random_uniform(UInt32(Int32(max) - Int32(min)))
    return Int8(Int32(r) + Int32(min))
  }
}

//  MARK: - Integer

public extension Integer where Stride: SignedInteger, Self:Randomizable {
  
  public static func random(in range: CountableClosedRange<Self>) -> Self {
    return Self.random(min: range.lowerBound, max:range.upperBound)
  }
  
  public static func random(in range: CountableRange<Self>) -> Self {
    return Self.random(min: range.lowerBound, max:range.upperBound-1)
  }
  
}


//private let _wordSize = __WORDSIZE
//
//extension Integer {
//
//  /// **Mechanica**
//  ///
//  /// Returns a random value.
//  public static func random() -> Self {
//    var result: Self = 0
//    //    withUnsafeMutablePointer(to: &result) { resultPtr in
//    //      arc4random_buf(UnsafeMutablePointer(resultPtr), MemoryLayout<Self>.size)
//    //    }
//    arc4random_buf(UnsafeMutablePointer(&result), MemoryLayout<Self>.size)
//    return result
//  }
//
//}
//
//
//public func arc4random <T: ExpressibleByIntegerLiteral> (type: T.Type) -> T {
//  var result:T = 0
//  arc4random_buf(&result, Int(MemoryLayout<T>.size))
//  return result
//}
//
///// **Mechanica**
/////
///// Types adopting the `FixedWidthInteger` protocol can be used as `Integer` with a fixed width.
//public protocol FixedWidthInteger : Integer {
//
//  /// **Mechanica**
//  ///
//  /// max value
//  static var max: Self { get }
//
//  /// **Mechanica**
//  ///
//  /// min value
//  static var min: Self { get }
//}
//
//extension UInt64: FixedWidthInteger {}
//extension Int64:  FixedWidthInteger {}
//extension UInt32: FixedWidthInteger {}
//extension Int32:  FixedWidthInteger {}
//extension UInt16: FixedWidthInteger {}
//extension Int16:  FixedWidthInteger {}
//extension UInt8:  FixedWidthInteger {}
//extension Int8:   FixedWidthInteger {}
//extension UInt:   FixedWidthInteger {}
//extension Int:    FixedWidthInteger {}
//
//extension FixedWidthInteger {
//
//  internal static func bitwiseCeil<T : FixedWidthInteger>(x: T) -> T {
//    var i = ~T.min
//    while ~i < x {
//      i = T.multiplyWithOverflow(i, 2).0
//    }
//    return ~i
//  }
//
//  //  public static func random(max: Self) -> Self {
//  //    let m = bitwiseCeil(x: max)
//  //    var result: Self = 0 //FIXED HERE
//  //    repeat {
//  //      arc4random_buf(&result, MemoryLayout<Self>.size)
//  //      //print("result_before: \(result)")
//  //      result &= m
//  //
//  //      print("result_after: \(result)")
//  //
//  //    } while result > max
//  //    return result
//  //  }
//
//
//
//}
//
//extension FixedWidthInteger where Stride: SignedInteger {
//
//  static func random(max: Self) -> Self {
//    print(max)
//    print(Self.self.min)
//    return random(in: Self.min...max)
//  }
//
//  public static func random(interval: CountableClosedRange<Self>) -> Self {
//    let a = interval.minBound
//    let b = interval.maxBound
//
//    func random(max: Self) -> Self {
//      let m = bitwiseCeil(x: max)
//      var result: Self = 0 //FIXED HERE
//      repeat {
//        arc4random_buf(&result, MemoryLayout<Self>.size)
//        result &= m
//
//      } while result > max
//      return result
//    }
//    return a + random(max: b - a)
//  }
//
//
//  //  public static func random(interval: CountableClosedRange<Self>) -> Self {
//  //    let a = interval.minBound
//  //    let b = interval.maxBound
//  //    return a + random(max: b - a)
//  //  }
//
//  /// **Mechanica**
//  ///
//  /// Returns a random FixedWidthInteger bounded by a closed interval range.
//  //  public static func random(in range: CountableClosedRange<Self>) -> Self {
//  //    let rangeSize = range.maxBound - range.minBound
//  //    guard (rangeSize != 0) else { return range.maxBound }
//  //    var randomValue = random()
//  //    let (result, overflow) = subtractWithOverflow(range.maxBound, range.minBound)
//  //    let maxDivisible = overflow ? max - ~result : result
//  //    while randomValue < maxDivisible {
//  //      randomValue = random()
//  //    }
//  //    return (randomValue % rangeSize) + range.minBound
//  //  }
//  //  public static func random(in range: CountableClosedRange<Self>) -> Self {
//  //    let minBound = range.minBound
//  //    let maxBound = range.maxBound
//  //    let rangeSize = maxBound - minBound
//  //    guard (rangeSize != 0) else { return maxBound }
//  //    let (result, _) = subtractWithOverflow(maxBound, minBound)
//  //    let r = random(interval: 0...result)
//  //    return addWithOverflow(minBound, r).0
//  //  }
//
//  public static func random(in range: CountableClosedRange<Self>) -> Self {
//    let minBound = range.minBound
//    let maxBound = range.maxBound
//    guard (minBound != maxBound) else { return minBound }
//    let (result, overflow) = subtractWithOverflow(maxBound, minBound)
//
//    //let r = random(interval: 0...result)
//
//    func random(max: Self) -> Self {
//      let m = bitwiseCeil(x: max)
//      var result: Self = 0 //FIXED HERE
//      repeat {
//        arc4random_buf(&result, MemoryLayout<Self>.size)
//        result &= m
//      } while result > max
//      return result
//    }
//
//
//    if (overflow) {
//      //let lb = (minBound < 0) ? minBound * -1 : minBound
//
//      //TODO: fix
//      var (lb,overflow) = multiplyWithOverflow(minBound, -1)
//      if (overflow){
//        lb = (lb + 1) * -1
//        print(lb)
//      }
//      print(lb)
//
//      var (ub,overflow2) = multiplyWithOverflow(maxBound, -1)
//      if (overflow2){
//        ub = (ub - 1)
//        print(ub)
//      }
//      print(ub)
//
//      //let ub = (maxBound < 0) ? maxBound * -1 : maxBound
//      let randomMin = random(max: lb)
//      let randomMax = random(max: ub)
//      let randomValue = randomMax + randomMin
//      return randomValue
//    } else {
//      let randomValue = random(max: result)
//      return addWithOverflow(minBound, randomValue).0
//    }
//  }
//
//
//  /// **Mechanica**
//  ///
//  /// Returns a random FixedWidthInteger between `min` and `max` values.
//  internal static func random(min: Self, max: Self) -> Self {
//    return random(in: min...max)
//  }
//
//}
