//
//  KeyboardObserverTests.swift
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

import XCTest
@testable import Mechanica

class KeyboardObserverTests: XCTestCase {
  
  let keyboardObserver = KeyboardObserver()
  
  var willChangeFrameOptions: KeyboardObserver.Options?
  var didChangeFrameOptions: KeyboardObserver.Options?
  var willHideOptions: KeyboardObserver.Options?
  var didHideOptions: KeyboardObserver.Options?
  var willShowOptions: KeyboardObserver.Options?
  var didShowOptions: KeyboardObserver.Options?
  
  override func setUp() {
    keyboardObserver.on(event: KeyboardObserver.Event.willChangeFrame) { [weak self] in self?.willChangeFrameOptions = $0 }
    keyboardObserver.on(event: KeyboardObserver.Event.didChangeFrame) { [weak self] in self?.didChangeFrameOptions = $0 }
    keyboardObserver.on(event: KeyboardObserver.Event.willHide) { [weak self] in self?.willHideOptions = $0 }
    keyboardObserver.on(event: KeyboardObserver.Event.didHide) { [weak self] in self?.didHideOptions = $0 }
    keyboardObserver.on(event: KeyboardObserver.Event.willShow) { [weak self] in self?.willShowOptions = $0 }
    keyboardObserver.on(event: KeyboardObserver.Event.didShow) { [weak self] in self?.didShowOptions = $0 }
  }
  
  override func tearDown() {
    keyboardObserver.clear()
    keyboardObserver.unregister()
    
    willChangeFrameOptions  = nil
    didChangeFrameOptions   = nil
    willHideOptions         = nil
    didHideOptions          = nil
    willShowOptions         = nil
    didShowOptions          = nil
  }
  
  func test_register() {
    keyboardObserver.register()
    executeRegistedTests()
  }
  
  func test_clear() {
    keyboardObserver.register()
    keyboardObserver.clear() // Callbacks will be dismissed.
    
    //willShow
    do {
      let startFrame        = CGRect(x: 0, y: 0, width: 100, height: 100)
      let endFrame          = CGRect(x: 0, y: 0, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeOut
      let animationDuration = 1.1
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillShow, object: nil, userInfo: userInfo)
      XCTAssertNil(willShowOptions)
    }
    
    //didShow
    do {
      let startFrame        = CGRect(x: 10, y: 10, width: 100, height: 100)
      let endFrame          = CGRect(x: 10, y: 10, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeOut
      let animationDuration = 1.2
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidShow, object: nil, userInfo: userInfo)
      XCTAssertNil(didShowOptions)
    }
    
    //willHide
    do {
      let startFrame        = CGRect(x: 5, y: 0, width: 100, height: 100)
      let endFrame          = CGRect(x: 0, y: 5, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeIn
      let animationDuration = 0.0
      let currentApp        = false
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillHide, object: nil, userInfo: userInfo)
      XCTAssertNil(willHideOptions)
    }
    
    //didHide
    do {
      let startFrame        = CGRect(x: 100, y: 100, width: 100, height: 100)
      let endFrame          = CGRect(x: 200, y: 200, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.linear
      let animationDuration = 1.11
      let currentApp        = false
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidHide, object: nil, userInfo: userInfo)
      XCTAssertNil(didHideOptions)
    }
    
    //willChangeFrame
    do {
      let startFrame        = CGRect(x: 0, y: 10, width: 10, height: 10)
      let endFrame          = CGRect(x: 10, y: 0, width: 20, height: 20)
      let animationCurve    = UIViewAnimationCurve.easeOut
      let animationDuration = 1.1
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, userInfo: userInfo)
      XCTAssertNil(willChangeFrameOptions)
    }
    
    //didChangeFrame
    do {
      let startFrame        = CGRect(x: 10, y: 0, width: 100, height: 10)
      let endFrame          = CGRect(x: 0, y: 0, width: 20, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeInOut
      let animationDuration = 2.1
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil, userInfo: userInfo)
      XCTAssertNil(didChangeFrameOptions)
    }
    
  }
  
  func test_unregister() {
    keyboardObserver.register()
    keyboardObserver.unregister() // Callbacks won’t be dismissed.
    
    //willShow
    do {
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillShow, object: nil, userInfo: nil)
      XCTAssertNil(willShowOptions)
    }
    
    //didShow
    do {
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidShow, object: nil, userInfo: nil)
      XCTAssertNil(didShowOptions)
    }
    
    //willHide
    do {
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillHide, object: nil, userInfo: nil)
      XCTAssertNil(willHideOptions)
    }
    
    //didHide
    do {
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidHide, object: nil, userInfo: nil)
      XCTAssertNil(didHideOptions)
    }
    
    //willChangeFrame
    do {
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, userInfo: nil)
      XCTAssertNil(willChangeFrameOptions)
    }
    
    //didChangeFrame
    do {
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil, userInfo: nil)
      XCTAssertNil(didChangeFrameOptions)
    }
    
    keyboardObserver.register()
    executeRegistedTests()
    
  }
  
  
  func executeRegistedTests() {
    
    //willShow
    do {
      let startFrame        = CGRect(x: 0, y: 0, width: 100, height: 100)
      let endFrame          = CGRect(x: 0, y: 0, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeOut
      let animationDuration = 1.1
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillShow, object: nil, userInfo: userInfo)
      XCTAssertNotNil(willShowOptions)
      XCTAssert(willShowOptions?.belongsToCurrentApp == true)
      XCTAssert(willShowOptions?.startFrame == startFrame)
      XCTAssert(willShowOptions?.endFrame == endFrame)
      XCTAssert(willShowOptions?.animationCurve == UIViewAnimationCurve.easeOut)
      XCTAssert(willShowOptions?.animationDuration == animationDuration)
    }
    
    //didShow
    do {
      let startFrame        = CGRect(x: 10, y: 10, width: 100, height: 100)
      let endFrame          = CGRect(x: 10, y: 10, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeOut
      let animationDuration = 1.2
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidShow, object: nil, userInfo: userInfo)
      XCTAssertNotNil(didShowOptions)
      XCTAssert(didShowOptions?.belongsToCurrentApp == currentApp)
      XCTAssert(didShowOptions?.startFrame == startFrame)
      XCTAssert(didShowOptions?.endFrame == endFrame)
      XCTAssert(didShowOptions?.animationCurve == UIViewAnimationCurve.easeOut)
      XCTAssert(didShowOptions?.animationDuration == animationDuration)
    }
    
    //willHide
    do {
      let startFrame        = CGRect(x: 5, y: 0, width: 100, height: 100)
      let endFrame          = CGRect(x: 0, y: 5, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeIn
      let animationDuration = 0.0
      let currentApp        = false
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillHide, object: nil, userInfo: userInfo)
      XCTAssertNotNil(willHideOptions)
      XCTAssert(willHideOptions?.belongsToCurrentApp == currentApp)
      XCTAssert(willHideOptions?.startFrame == startFrame)
      XCTAssert(willHideOptions?.endFrame == endFrame)
      XCTAssert(willHideOptions?.animationCurve == animationCurve)
      XCTAssert(willHideOptions?.animationDuration == animationDuration)
    }
    
    //didHide
    do {
      let startFrame        = CGRect(x: 100, y: 100, width: 100, height: 100)
      let endFrame          = CGRect(x: 200, y: 200, width: 200, height: 200)
      let animationCurve    = UIViewAnimationCurve.linear
      let animationDuration = 1.11
      let currentApp        = false
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidHide, object: nil, userInfo: userInfo)
      XCTAssertNotNil(didHideOptions)
      XCTAssert(didHideOptions?.belongsToCurrentApp == currentApp)
      XCTAssert(didHideOptions?.startFrame == startFrame)
      XCTAssert(didHideOptions?.endFrame == endFrame)
      XCTAssert(didHideOptions?.animationCurve == animationCurve)
      XCTAssert(didHideOptions?.animationDuration == animationDuration)
    }
    
    //willChangeFrame
    do {
      let startFrame        = CGRect(x: 0, y: 10, width: 10, height: 10)
      let endFrame          = CGRect(x: 10, y: 0, width: 20, height: 20)
      let animationCurve    = UIViewAnimationCurve.easeOut
      let animationDuration = 1.1
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, userInfo: userInfo)
      XCTAssertNotNil(willChangeFrameOptions)
      XCTAssert(willChangeFrameOptions?.belongsToCurrentApp == currentApp)
      XCTAssert(willChangeFrameOptions?.startFrame == startFrame)
      XCTAssert(willChangeFrameOptions?.endFrame == endFrame)
      XCTAssert(willChangeFrameOptions?.animationCurve == animationCurve)
      XCTAssert(willChangeFrameOptions?.animationDuration == animationDuration)
    }
    
    //didChangeFrame
    do {
      let startFrame        = CGRect(x: 10, y: 0, width: 100, height: 10)
      let endFrame          = CGRect(x: 0, y: 0, width: 20, height: 200)
      let animationCurve    = UIViewAnimationCurve.easeInOut
      let animationDuration = 2.1
      let currentApp        = true
      
      let userInfo = makeUserInfoWith(startFrame: startFrame, endFrame: endFrame, animationCurve: animationCurve, animationDuration: animationDuration, currentApp: currentApp)
      NotificationCenter.default.post(name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil, userInfo: userInfo)
      XCTAssertNotNil(didChangeFrameOptions)
      XCTAssert(didChangeFrameOptions?.belongsToCurrentApp == currentApp)
      XCTAssert(didChangeFrameOptions?.startFrame == startFrame)
      XCTAssert(didChangeFrameOptions?.endFrame == endFrame)
      XCTAssert(didChangeFrameOptions?.animationCurve == animationCurve)
      XCTAssert(didChangeFrameOptions?.animationDuration == animationDuration)
    }
    
  }
  
  
}

fileprivate extension KeyboardObserverTests {
  
  func makeUserInfoWith(startFrame: CGRect, endFrame: CGRect, animationCurve: UIViewAnimationCurve, animationDuration: Double, currentApp: Bool) -> [AnyHashable : Any] {
    var userInfo = [AnyHashable : Any]()
    userInfo[UIKeyboardIsLocalUserInfoKey] = currentApp
    userInfo[UIKeyboardFrameBeginUserInfoKey] = startFrame
    userInfo[UIKeyboardFrameEndUserInfoKey] = endFrame
    userInfo[UIKeyboardAnimationCurveUserInfoKey] = NSNumber(value: animationCurve.rawValue)
    userInfo[UIKeyboardAnimationDurationUserInfoKey] = animationDuration
    return userInfo
  }
  
}
