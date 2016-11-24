//
//  ManagedObjectContextSettable.swift
//
//  Copyright © 2016 Alessandro Marzoli. All rights reserved.
//

import Foundation

import CoreData

protocol ManagedObjectContextSettable: class {
  var managedObjectContext: NSManagedObjectContext! { get set }
}
