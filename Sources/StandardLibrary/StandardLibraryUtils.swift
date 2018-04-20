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

#if canImport(Glibc)
  import Glibc
  import SwiftShims
#elseif canImport(Darwin)
  import Darwin.C
#endif

func mechanica_arc4random_uniform(_ upperBound: UInt32) -> UInt32 {
  #if os(Linux)
  #if swift(>=4.1)
  return _stdlib_cxx11_mt19937_uniform(upperBound)
  #else
  return _swift_stdlib_cxx11_mt19937_uniform(upperBound)
  #endif
  #else
  return arc4random_uniform(upperBound)
  #endif
}

func mechanica_arc4random() -> UInt32 {
  #if os(Linux)
  #if swift(>=4.1)
  return _stdlib_cxx11_mt19937()
  #else
  return _swift_stdlib_cxx11_mt19937()
  #endif
  #else
  return arc4random()
  #endif
}
