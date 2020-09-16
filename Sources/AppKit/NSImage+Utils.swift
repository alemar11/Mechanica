#if os(macOS)

import AppKit

extension NSImage {
  /// **Mechanica**
  ///
  /// - Parameters:
  ///   - name: The name of the image.
  ///   - bundle: The bundle containing the image file or asset catalog, if nil the behavior is identical to `init(named:)`.
  /// - Returns: The image object associated with the specified filename.
  public class func imageNamed(name: String, in bundle: Bundle?) -> NSImage? {
    let name = NSImage.Name(name)

    guard let bundle = bundle else { return NSImage(named: name) }

    if let image = bundle.image(forResource: name) {
      image.setName(name)
      return image
    }

    return nil
  }

  /// **Mechanica**
  ///
  /// Returns a CGImage object for the associated image data.
  public var cgImage: CGImage? {
    let imageData = self.tiffRepresentation

    guard let source = CGImageSourceCreateWithData(imageData! as CFData, nil) else { return nil }

    return CGImageSourceCreateImageAtIndex(source, 0, nil)
  }
}

#endif
