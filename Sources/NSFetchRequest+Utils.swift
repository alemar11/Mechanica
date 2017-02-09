//
//  NSFetchRequest+Utils.swift
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

extension NSFetchRequest {

  /// **Mechanica**
  ///
  /// Creates a NSFetchRequest.
  ///
  /// - parameter entity:    Core Data entity
  /// - parameter predicate: Fetch request predicate
  /// - parameter batchSize: Breaks the result set into batches
  ///
  /// - returns: a `new` NSFetchRequest.
  convenience init(entity: NSEntityDescription, predicate: NSPredicate? = nil, batchSize: Int = 0) {
    self.init()
    self.entity = entity
    self.predicate = predicate
    self.fetchBatchSize = batchSize
  }
  
//  func addingAndPredicate(predicate: NSPredicate) {
//    guard let currentPredicate = self.predicate else {
//      self.predicate = predicate
//      return
//    }
//    self.predicate = currentPredicate && predicate
//  }
//  
//  func addingOrPredicate(predicate: NSPredicate) {
//    guard let currentPredicate = self.predicate else {
//      self.predicate = predicate
//      return
//    }
//    self.predicate = currentPredicate || predicate
//  }
  
//  func appendingSortDescriptors(descriptors: NSSortDescriptor...) -> NSFetchRequest {
//    return appendingSortDescriptors(descriptors: descriptors)
//  }
  
//  func appendingSortDescriptors(descriptors: [NSSortDescriptor]) -> NSFetchRequest {
//    let request = self.copy() as! NSFetchRequest
//    if request.sortDescriptors != nil {
//      request.sortDescriptors?.append(contentsOf: descriptors)
//    } else {
//      request.sortDescriptors = descriptors
//    }
//    return request
//  }
  
}

