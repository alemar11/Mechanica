//
// Mechanica
//
// Copyright © 2016-2017 Tinrobots.
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

#if os(iOS) || os(tvOS)

import UIKit

extension UITableView {

  // MARK: UITableViewCell

  /**
   **Mechanica**

   Registers a nib object containing an `UITableViewCell` subclass conforming to `Reusable` & `NibIdentifiable`.

   - parameter cellType: The `UITableViewCell` subclass to register,
   - seealso: `register(_:forCellReuseIdentifier:)`
   */
  public final func register<T: UITableViewCell>(cellType: T.Type) where T: NibReusable {
    register(T.nib(), forCellReuseIdentifier: T.reuseIdentifier)
  }

  /**
   **Mechanica**

   Registers a class conforming to `Reusable` for use in creating new table cells.
   - parameter cellType: The `UITableViewCell` subclass to register.
   - seealso: `register(_:forCellReuseIdentifier:)`
   */
  public final func register<T: UITableViewCell>(cellType: T.Type) where T: Reusable {
      self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
  }

  /**
   **Mechanica**

   Returns a reusable `UITableViewCell` object for the class inferred by the specified return-type.
   - parameter indexPath: The index path specifying the location of the cell.
   - parameter cellType: The cell class to dequeue.
   - returns: A `Reusable` `UITableViewCell` object.
   - note: The `cellType` parameter can generally be omitted and infered by the return type, except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableCell(withIdentifier:for:)`
   */
  public final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
      guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
        fatalError("Could not dequeue a cell with identifier: \(cellType.reuseIdentifier) matching type: \(cellType.self).\n"
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard file and that the cell has been registered."
        )
      }
      return cell
  }

  /**
   **Mechanica**

   Returns a reusable `UITableViewCell` object located by its identifier.
   - parameter cellType: The cell class to dequeue.
   - returns: A `Reusable` `UITableViewCell` object or nil;
   - note: The `cellType` parameter can generally be omitted and infered by the return type, except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableCell(withIdentifier:)`
   */
  public final func dequeueReusableCell<T: UITableViewCell>(cellType: T.Type = T.self) -> T? where T: Reusable {
    let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? T
    return cell
  }

  // MARK: UITableViewHeaderFooterView

  /**
   **Mechanica**

   Registers a nib object containing a cell `UITableViewHeaderFooterView` subclass conforming to `Reusable` & `NibIdentifiable`.
   - parameter headerFooterViewType: The `UITableViewHeaderFooterView` subclass to register.
   - seealso: `register(_:forHeaderFooterViewReuseIdentifier:)`
   */
  public final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
    where T: NibReusable {
      self.register(headerFooterViewType.nib(), forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
  }

  /**
   **Mechanica**

   Registers a class conforming to `Reusable` for use in creating new table header or footer views.
   - parameter headerFooterViewType: The `UITableViewHeaderFooterView` subclass to register.
   - seealso: `register(_:forHeaderFooterViewReuseIdentifier:)`
   */
  public final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
    where T: Reusable {
      self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
  }

  /**
   **Mechanica**

   Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type.
   - parameter viewType: The view class to dequeue
   - returns: A `Reusable` `UITableViewHeaderFooterView` instance.
   - note: The `viewType` parameter can generally be omitted and infered by the return type, except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableHeaderFooterView(withIdentifier:)`
   */
  public final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T?
    where T: Reusable {
      guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
        fatalError("Could not dequeue an header/footer view with identifier: \(viewType.reuseIdentifier) matching type: \(viewType.self).\n"
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard file and that the header/footer view has been registered."
        )
      }
      return view
  }
}

#endif
