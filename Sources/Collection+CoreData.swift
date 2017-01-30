//
//  Collection+CoreData.swift
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

extension Collection where Iterator.Element: NSManagedObject {

  /// **Mechanica**
  ///
  /// Fetches all faulted object in one batch executing a single fetch request for all objects that we’re interested in.
  /// - Note: Materializing all objects in one batch is faster than triggering the fault for each object on its own.
  public func fetchFaultedObjects() {

    guard !self.isEmpty else { return }
    guard let context = self.first?.managedObjectContext else { fatalError("Managed object must have context.") }

    let faults = self.filter { $0.isFault }
    guard let mo = faults.first else { return }

    let request = NSFetchRequest<NSFetchRequestResult>()
    request.entity = mo.entity
    request.returnsObjectsAsFaults = false
    request.predicate = NSPredicate(format: "self in %@", faults)

    try! context.fetch(request)
  }

}
