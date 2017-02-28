//
//  NSManagedObject+Utils.swift
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

import CoreData

extension NSManagedObject {

  /// **Mechanica**
  ///
  /// Updates the persistent properties of a managed object to use the latest values from the persistent store.
  /// To ensure that reference cycles are broken, when you are finished with an object, you can use this method to turn the `self` into a fault.
  ///
  /// - parameter flag: only matters if the object has unsaved changes. In this case, a `true` value won’t turn the object into a fault; instead, it’ll update the unchanged properties from the row cache, preserving any unsaved changes. That’s almost always what you want to do (and what *refreshAllObjects()* does as well). If `mergeChanges` is set to `false` , the object will be forced to turn into a fault, and unsaved changes will be lost.
  /// - note:  If `flag` is `true`, this method does not affect any transient properties; if `flag` is `false`, transient properties are disposed of. Turning object into a fault means that strong references to related managed objects (that is, those to which object has a reference) are broken, so you can also use this method to trim a portion of your object graph you want to constrain memory usage.
  public func refresh(mergeChanges flag: Bool = true) {
    managedObjectContext?.refresh(self, mergeChanges: flag)
  }

/*
   To break such a cycle, we have to refresh at least one of the involved objects. Using the context’s refresh(_ object:mergeChanges:) method, the object will remain valid, but its data will be gone from the context.
   
   If `flag` is false, then object is turned into a fault and any pending changes are lost. The object remains a fault until it is accessed again
   If `flag` is true, then object is turned into a fault and object’s property values are reloaded from the values from the store or the last cached state then any changes that were made (in the local context) are re-applied over those (now newly updated) values.
   

 */

  /// **Mechanica**
  ///
  /// Returns the value of a persistent property that has been changed since last fetching or saving operation.
  public func changedValue(forKey key: String) -> Any? {
    return changedValues()[key]
  }

  /// **Mechanica**
  ///
  /// Returns of the last fetched or saved value of the propery specified by the given key.
  public func committedValue(forKey key: String) -> Any? {
    return committedValues(forKeys: [key])[key]
  }

}
