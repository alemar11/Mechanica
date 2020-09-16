import XCTest
@testable import Mechanica

final class FontUtilsTests: XCTestCase {
  
  func testBold() {
    let font: Font
    
    #if os(macOS)
    font = Font.systemFont(ofSize: 16)
    #else
    font = Font.preferredFont(forTextStyle: .body)
    #endif
    
    let boldFont = font.bold()
    XCTAssertNotNil(boldFont)
    XCTAssertTrue(boldFont.isBold)
    XCTAssertFalse(boldFont.isItalic)
    
    let removedBoldFont = font.removingBold()
    XCTAssertFalse(removedBoldFont.isBold)
    XCTAssertFalse(removedBoldFont.isItalic)
  }
  
  func testItalic() {
    let font: Font
    
    #if os(macOS)
    font = Font.systemFont(ofSize: 16)
    #else
    font = Font.preferredFont(forTextStyle: .body)
    #endif
    
    let italicFont = font.italic()
    XCTAssertTrue(italicFont.isItalic)
    XCTAssertFalse(italicFont.isBold)
    
    let removedItalicFont = font.removingItalic()
    XCTAssertFalse(removedItalicFont.isBold)
    XCTAssertFalse(removedItalicFont.isItalic)
  }
  
  func testBoldAndItalic() {
    let font: Font
    
    #if os(macOS)
    font = Font.systemFont(ofSize: 16)
    #else
    font = Font.preferredFont(forTextStyle: .body)
    #endif
    
    let boldAndItalicFont = font.bold().italic()
    XCTAssertTrue(boldAndItalicFont.isItalic)
    XCTAssertTrue(boldAndItalicFont.isBold)
    
    let removedBoldAndItalicFont = font.removingBold().removingItalic()
    XCTAssertFalse(removedBoldAndItalicFont.isBold)
    XCTAssertFalse(removedBoldAndItalicFont.isItalic)
  }
  
  
  func testPreferredFontBehaviour() {
    #if os(iOS)
    do {
      // Given
      let font = Font.preferredFont(forTextStyle: .headline) // this is bold by default on iOS
      
      // When, Then
      let italicAndBoldFont = font.italic()
      XCTAssertTrue(italicAndBoldFont.isBold)
      XCTAssertTrue(italicAndBoldFont.isItalic)
      
      // When, Then
      let onlyBoldFont = italicAndBoldFont.bold(removingExistingTraits: true)
      XCTAssertTrue(onlyBoldFont.isBold)
      XCTAssertFalse(onlyBoldFont.isItalic)
      
      // When, Then
      // The "Using Fonts With Text Kit" WWDC session sheds a bit of light on what might be happening here.
      // Around 18:00 in the video, slide 18 in the PDF a note is made that fontDescriptorWithSymbolicTraits: performs a font matching procedure internally.
      // It is only supposed to give you back a descriptor that will actually match a font.
      // https://stackoverflow.com/questions/19822862/unbolding-a-uifontdescriptor
      let onlyItalicFont = italicAndBoldFont.italic(removingExistingTraits: true)
      // there is no variant of the headline font that is italic but not bold on iOS.
      
      XCTAssertTrue(italicAndBoldFont.isBold)
      XCTAssertTrue(onlyItalicFont.isItalic)
      
      XCTAssertTrue(onlyItalicFont.removingBold().isBold) // headline style will always retain its bold trait.
    }
    #endif
    
    #if os(tvOS)
    do {
      // Given
      let font = Font.preferredFont(forTextStyle: .headline)
      
      // When, Then
      let italicAndBoldFont = font.italic()
      XCTAssertFalse(italicAndBoldFont.isBold)
      XCTAssertTrue(italicAndBoldFont.isItalic)
      
      // When, Then
      let onlyBoldFont = italicAndBoldFont.bold(removingExistingTraits: true)
      XCTAssertTrue(onlyBoldFont.isBold)
      XCTAssertFalse(onlyBoldFont.isItalic)
      
      // When, Then
      let onlyItalicFont = italicAndBoldFont.italic(removingExistingTraits: true)
      XCTAssertFalse(onlyItalicFont.isBold)
      XCTAssertTrue(onlyItalicFont.isItalic)
      
      XCTAssertFalse(onlyItalicFont.removingBold().isBold)
    }
    #endif
  }
  
  func testIsBoldOrIsItalic() {
    
    do {
      // Given
      let font = Font.systemFont(ofSize: 16)
      XCTAssertFalse(font.isBold)
      XCTAssertFalse(font.isItalic)
      
      // When, Then
      let italicAndBoldFont = font.italic().bold()
      
      // When, Then
      let onlyBoldFont = italicAndBoldFont.bold(removingExistingTraits: true)
      XCTAssertTrue(onlyBoldFont.isBold)
      XCTAssertFalse(onlyBoldFont.isItalic)
      
      // When, Then
      let onlyItalicFont = italicAndBoldFont.italic(removingExistingTraits: true)
      XCTAssertFalse(onlyItalicFont.isBold) //
      XCTAssertTrue(onlyItalicFont.isItalic)
    }
  }
  
}
