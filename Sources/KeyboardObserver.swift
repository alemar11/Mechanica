//
//  KeyboardObserver.swift
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

#if os(iOS)

import Foundation
import UIKit


/// **Mechanica**
///
/// `KeyboardObserver` is an UIKit keyboard's behavior observer (for iOS apps) without Notification Center.
/// Declare what should happen on what event and `register()`.
///
///   Example:
///
///     let keyboard = KeyboardObserver()
///     keyboard
///      .on(event: .didShow) { (options) in
///        print("didShow")
///      }
///      .on(event: .didHide) { (options) in
///        print("didHide")
///      }
///      .register()
///
/// You *must* call `register()` for callbacks to be triggered.
///
/// Calling `unregister()` will stop callbacks from triggering (UIKit's notifications won't be observed anymore), but callbacks themselves won't be dismissed;
/// you can resume event callbacks by calling `register()` again.
///
/// To remove all event callbacks, call `clear()`.
public final class KeyboardObserver {

  /// **Mechanica**
  ///
  /// A `KeyboardObserver` callback.
  public typealias Callback = (Options) -> Void

  // MARK: - Keyboard Options

  /// **Mechanica**
  ///
  /// Struct containing all data that a keyboard has at the event of happening.
  public struct Options {

    /// Identifies whether the keyboard belongs to the current app.
    public let belongsToCurrentApp: Bool

    /// Identifies the start frame of the keyboard in screen coordinates.
    public let startFrame: CGRect

    /// Identifies the end frame of the keyboard in screen coordinates.
    public let endFrame: CGRect

    /// Defines how the keyboard will be animated onto or off the screen.
    public let animationCurve: UIViewAnimationCurve

    /// Identifies the duration of the keyboard animation in seconds.
    public let animationDuration: Double

    // MARK: - Factory

    /// Creates a new `Keyboard.Options` struct for an `info` dicionary.
    fileprivate static func makeOptions(fromInfo info: [AnyHashable : Any]) -> Options {

      var belongsToCurrentApp: Bool = true
      if let value = (info[UIKeyboardIsLocalUserInfoKey] as? NSNumber)?.boolValue {
        belongsToCurrentApp = value
      }

      var startFrame = CGRect()
      if let value = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        startFrame = value
      }

      var endFrame = CGRect()
      if let value = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
        endFrame = value
      }

      var animationCurve = UIViewAnimationCurve.linear
      if let index = (info[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber)?.intValue,
        let value = UIViewAnimationCurve(rawValue:index) {
        animationCurve = value
      }

      var animationDuration: Double = 0.0
      if let value = (info[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
        animationDuration = value
      }

      return Options(belongsToCurrentApp: belongsToCurrentApp, startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration)
    }

  }

  // MARK: - Keyboard Events

  /// **Mechanica**
  ///
  /// Keyboard events that can happen. Translates directly to `UIKeyboard` notifications from UIKit.
  public enum Event {
    /// Event raised by UIKit's `.UIKeyboardWillShow`.
    case willShow
    /// Event raised by UIKit's `.UIKeyboardDidShow`.
    case didShow
    /// Event raised by UIKit's `.UIKeyboardWillHide`.
    case willHide
    /// Event raised by UIKit's `.UIKeyboardDidHide`.
    case didHide
    /// Event raised by UIKit's `.UIKeyboardWillChangeFrame`.
    case willChangeFrame
    /// Event raised by UIKit's `.UIKeyboardDidChangeFrame`.
    case didChangeFrame

    /// Event `NSNotification.Name`.
    fileprivate var notificationName: NSNotification.Name {
      switch self {
      case .willShow:
        return .UIKeyboardWillShow
      case .didShow:
        return .UIKeyboardDidShow
      case .willHide:
        return .UIKeyboardWillHide
      case .didHide:
        return .UIKeyboardDidHide
      case .willChangeFrame:
        return .UIKeyboardWillChangeFrame
      case .didChangeFrame:
        return .UIKeyboardDidChangeFrame
      }
    }

    fileprivate var selector: Selector {
      switch self {
      case .willShow:
        return Selector.willShow
      case .didShow:
        return Selector.didShow
      case .willHide:
        return Selector.willHide
      case .didHide:
        return Selector.didHide
      case .willChangeFrame:
        return Selector.willChangeFrame
      case .didChangeFrame:
        return Selector.didChangeFrame
      }
    }

  }

  private var callbacks: [Event : Callback] = [:]

  // MARK: Public functions

  /// **Mechanica**
  ///
  /// Defines `KeyboardObserver` behaviours.
  /// - Warning: Without calling `register()` none of the closures will be executed.
  /// - Warning: If more closures are declared on the same event, only the latter will be executed.
  ///
  /// - Parameters:
  ///   - event: `KeyboardObserver` event on which callback should be executed.
  ///   - callback: Closure of code which will be executed on `KeyboardObserver`.
  /// - Returns: `Self` for chaining purpose.
  @discardableResult
  public final func on(event: Event, do callback: Callback?) -> Self {
    //if you use a typealias for a function type in a function declaration, that parameter is always considered escaping
    callbacks[event] = callback
    return self
  }

  /// **Mechanica**
  ///
  /// Initializes a new instance of `KeyboardObserver`.
  public init() {}

  /// **Mechanica**
  ///
  /// Registers for `KeyboardObserver` events and starts calling corresponding event handlers.
  public final func register() {
    let defaultCenter = NotificationCenter.default
    for event in callbacks.keys {
      defaultCenter.addObserver(self, selector: event.selector, name: event.notificationName, object: nil)
    }
  }

  /// **Mechanica**
  ///
  /// Remove all event callbacks.
  public final func clear() {
    callbacks.removeAll()
  }

  /// **Mechanica**
  ///
  /// Unregister from `KeyboardObserver` events.
  /// - Warning: callbacks themselves won't be dismissed.
  public final func unregister() {
    let defaultCenter = NotificationCenter.default
    defaultCenter.removeObserver(self)
  }

  // MARK: Private functions

  /// Handler for `UIKeyboardWillShow` Notification.
  ///
  /// - parameter notification: keyboard notification
  fileprivate dynamic func keyboardWillShow(_ notification: Notification) {
    guard let callback = callbacks[.willShow] else { return }
    let options = Options.makeOptions(fromInfo: notification.userInfo!)
    callback(options)
  }

  /// Handler for `UIKeyboardDidShow` Notification.
  ///
  /// - parameter notification: keyboard notification
  fileprivate dynamic func keyboardDidShow(_ notification: Notification) {
    guard let callback = callbacks[.didShow] else { return }
    let options = Options.makeOptions(fromInfo: notification.userInfo!)
    callback(options)  }

  /// Handler for `UIKeyboardWillHide` Notification.
  ///
  /// - parameter notification: keyboard notification
  fileprivate dynamic func keyboardWillHide(_ notification: Notification) {
    guard let callback = callbacks[.willHide] else { return }
    let options = Options.makeOptions(fromInfo: notification.userInfo!)
    callback(options)
  }

  /// Handler for `UIKeyboardDidHide` Notification.
  ///
  /// - parameter notification: keyboard notification
  fileprivate dynamic func keyboardDidHide(_ notification: Notification) {
    guard let callback = callbacks[.didHide] else { return }
    let options = Options.makeOptions(fromInfo: notification.userInfo!)
    callback(options)
  }

  /// Handler for `UIKeyboardWillChangeFrame` Notification.
  ///
  /// - parameter notification: keyboard notification
  fileprivate dynamic func keyboardWillChangeFrame(_ notification: Notification) {
    guard let callback = callbacks[.willChangeFrame] else { return }
    let options = Options.makeOptions(fromInfo: notification.userInfo!)
    callback(options)
  }

  /// Handler for `UIKeyboardDidChangeFrame` Notification.
  ///
  /// - parameter notification: keyboard notification
  fileprivate dynamic func keyboardDidChangeFrame(_ notification: Notification) {
    guard let callback = callbacks[.didChangeFrame] else { return }
    let options = Options.makeOptions(fromInfo: notification.userInfo!)
    callback(options)
  }

}

// MARK: - Selectors

fileprivate extension Selector {
  static let willShow         = #selector(KeyboardObserver.keyboardWillShow(_:))
  static let didShow          = #selector(KeyboardObserver.keyboardDidShow(_:))
  static let willHide         = #selector(KeyboardObserver.keyboardWillHide(_:))
  static let didHide          = #selector(KeyboardObserver.keyboardDidHide(_:))
  static let willChangeFrame  = #selector(KeyboardObserver.keyboardWillChangeFrame(_:))
  static let didChangeFrame   = #selector(KeyboardObserver.keyboardDidChangeFrame(_:))
}

#endif
