//
//  NSManagedObjectContext+Cache.swift
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

import CoreData

// MARK: - Cache

fileprivate let SingleObjectCacheKey = "\(mechanicaBundleIdentifier).CoreData.Cache"
fileprivate typealias SingleObjectCache = [String:NSManagedObject]

extension NSManagedObjectContext {

  /// **Mechanica**
  ///
  /// Caches an `object` for a `key` in this context.
  public func setCachedObject(_ object: NSManagedObject?, for key: String) {
    var cache = userInfo[SingleObjectCacheKey] as? SingleObjectCache ?? [:]
    cache[key] = object
    userInfo[SingleObjectCacheKey] = cache
  }

  /// **Mechanica**
  ///
  /// Returns a cached object in this context for a given `key`.
  public func cachedObject(for key: String) -> NSManagedObject? {
    guard let cache = userInfo[SingleObjectCacheKey] as? [String:NSManagedObject] else { return nil }
    return cache[key]
  }

  /// **Mechanica**
  ///
  /// Clears all cached object in this context.
  public func clearCachedObjects() -> Void {
    var cache = userInfo[SingleObjectCacheKey]
    if (cache as? SingleObjectCache) != nil {
      cache = nil
    }
  }

}
