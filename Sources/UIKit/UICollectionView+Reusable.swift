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

extension UICollectionView {

  // MARK: UICollectionViewCell

  /**
   **Mechanica**

   Registers a nib object containing an `UICollectionViewCell` subclass conforming to `Reusable` & `NibIdentifiable`.

   - parameter cellType: the `UICollectionViewCell` subclass to register.
   - seealso: `register(_:forCellWithReuseIdentifier:)`
   */
  public final func register<T: UICollectionViewCell>(cellType: T.Type) where T: NibReusable {
      self.register(cellType.nib(), forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }

  /**
   **Mechanica**

   Registers a class conforming to `Reusable` for use in creating new collection view cells.

   - parameter cellType: The `UICollectionViewCell` subclass to register.
   - seealso: `register(_:forCellWithReuseIdentifier:)`
   */
  public final func register<T: UICollectionViewCell>(cellType: T.Type) where T: Reusable {
      self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
  }

  /**
   **Mechanica**

   Returns a reusable `UICollectionViewCell` object for the class inferred by the specified return-type.

   - parameter indexPath: The index path specifying the location of the cell.
   - parameter cellType: The cell class to dequeue.
   - returns: A `Reusable` `UICollectionViewCell` instance
   - note: The `cellType` parameter can generally be omitted and infered by the return type,
   except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableCell(withReuseIdentifier:for:)`
   */
  public final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T where T: Reusable {
      guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
        fatalError("Could not dequeue a cell with identifier: \(cellType.reuseIdentifier) matching type: \(cellType.self).\n"
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard file and that the cell has been registered."
        )
      }
      return cell
  }

  // MARK: UICollectionReusableView

  /**
   **Mechanica**

   Registers a nib object containing an `UICollectionReusableView` subclass conforming to `Reusable` & `NibIdentifiable` as a supplementary view.

   - parameter supplementaryViewType: The `UIView` subclass to register as *supplementary view*.
   - parameter elementKind: The kind of supplementary view to create.
   - seealso: `register(_:,forSupplementaryViewOfKind:withReuseIdentifier:)`
   */
  public final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, forSupplementaryViewOfKind kind: String) where T: NibReusable {
      self.register(supplementaryViewType.nib(), forSupplementaryViewOfKind: kind, withReuseIdentifier: supplementaryViewType.reuseIdentifier
      )
  }

  /**
   **Mechanica**

   Registers a class conforming to `Reusable` for use in creating supplementary views for the collection view..

   - parameter supplementaryViewType: the `UIView` (`Reusable`-conforming) subclass to register as *supplementary view*.
   - parameter elementKind: The kind of supplementary view to create.
   - seealso: `register(_:,forSupplementaryViewOfKind:withReuseIdentifier:)`
   */
  public final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, forSupplementaryViewOfKind kind: String) where T: Reusable {
      self.register(supplementaryViewType.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: supplementaryViewType.reuseIdentifier)
  }

  /**
   **Mechanica**

   Returns a reusable supplementary view for the class inferred by the return-type.

   - parameter elementKind: The kind of supplementary view to retrieve.
   - parameter indexPath:   The index path specifying the location of the cell.
   - parameter viewType: The view class to dequeue
   - returns: A `Reusable` `UICollectionReusableView` instance
   - note: The `viewType` parameter can generally be omitted and infered by the return type, except when your type is in a variable and cannot be determined at compile time.
   - seealso: `dequeueReusableSupplementaryView(ofKind:,withReuseIdentifier:for:)`
   */
  public final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T where T: Reusable {
    guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue a supplementary view with identifier: \(viewType.reuseIdentifier) matching type: \(viewType.self).\n"
        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard file and that the supplementary view has been registered."
      )
    }
    return view
  }
}

#endif
