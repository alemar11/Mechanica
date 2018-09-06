//
// Mechanica
//
// Copyright © 2016-2018 Tinrobots.
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

#if canImport(AVFoundation) && canImport(Foundation)
import AVFoundation
import Foundation

public extension URL {

  #if !os(watchOS) && !os(macOS) // see the TODO

  /// Generates a thumbnail image from given url.
  ///
  ///
  /// Example:
  ///
  ///     let url = URL(string: "https://link/to/video.mp4")!
  ///     let thumbnail = url.thumbnail(fromTime: 5)
  ///
  /// - Parameter time: Seconds into the video where the image should be generated.
  /// - Returns: The UIImage result of the AVAssetImageGenerator.
  /// - Throws: Throws an error if no thumbnail could be created.
  /// - Note: This function may take some time to complete: it's recommended to dispatch the call on another queue if the thumbnail is not generated from a local resource.
  public func thumbnail(fromTime time: Float64 = 0) throws -> Image {
    let asset = AVAsset(url: self)
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    #warning("Disabled for macOS to pass swift tests")
    // TODO: for some reason 'swift test' doesn't work if we add the argument label 'preferredTimescale' on macOS
    let time = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
    var actualTime = CMTimeMake(value: 0, timescale: 0)
    let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: &actualTime)

    #if canImport(UIKit)
      return Image(cgImage: cgImage)
    #elseif canImport(AppKit)
      return Image(cgImage: cgImage, size: .zero)
    #endif
  }
  #endif
}

#endif