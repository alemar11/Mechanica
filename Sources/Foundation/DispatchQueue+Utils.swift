//
// Mechanica
//
// Copyright © 2016-2019 Tinrobots.
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

#if canImport(Dispatch)

import Dispatch

// MARK: - Properties

public extension DispatchQueue {

  /// **Mechanica**
  ///
  /// Returns a Boolean value indicating whether the current dispatch queue is the main queue.
  public static var isMainQueue: Bool {
    enum Static {
      static var key: DispatchSpecificKey<Void> = {
        let key = DispatchSpecificKey<Void>()
        DispatchQueue.main.setSpecific(key: key, value: ())
        return key
      }()
    }
    return DispatchQueue.getSpecific(key: Static.key) != nil
  }

}

// MARK: - Methods

public extension DispatchQueue {

  /// **Mechanica**
  ///
  /// Returns a Boolean value indicating whether the current dispatch queue is the specified queue.
  ///
  /// - Parameter queue: The queue to compare against.
  /// - Returns: `true` if the current queue is the specified queue, otherwise `false`.
  public static func isCurrent(_ queue: DispatchQueue) -> Bool {
    let key = DispatchSpecificKey<Void>()

    queue.setSpecific(key: key, value: ())
    defer { queue.setSpecific(key: key, value: nil) }

    return DispatchQueue.getSpecific(key: key) != nil
  }

}

#endif
