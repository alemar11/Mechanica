#if canImport(AVAsset)

import AVFoundation

extension AVAsset {
  /// **Mechanica**
  ///
  /// Generates a thumbnail image.
  ///
  ///
  /// Example:
  ///
  ///     let url = URL(string: "https://link/to/video.mp4")!
  ///     let asset = AVAsset(url: url)
  ///     let thumbnail = asset.thumbnail(fromTime: 5)
  ///
  /// - Parameter time: Seconds into the video where the image should be generated.
  /// - Returns: A thumbnail image.
  /// - Throws: Throws an error if no thumbnail could be created.
  /// - Note: This function may take some time to complete: it's recommended to dispatch the call on another queue if the thumbnail is not generated from a local resource.
  public func thumbnail(fromTime time: Float64 = 0) throws -> Image {
    let imageGenerator = AVAssetImageGenerator(asset: self)
    imageGenerator.appliesPreferredTrackTransform = true
    imageGenerator.requestedTimeToleranceAfter = .zero
    imageGenerator.requestedTimeToleranceBefore = .zero

    let time = CMTime(seconds: time, preferredTimescale: 1)
    var actualTime = CMTime(value: 0, timescale: 0)
    let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: &actualTime)

    #if canImport(UIKit)
      return Image(cgImage: cgImage)
    #elseif canImport(AppKit)
      return Image(cgImage: cgImage, size: .zero)
    #endif
  }
}

#endif
