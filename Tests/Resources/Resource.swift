import Foundation
@testable import Mechanica

enum Resource {

  case glasses
  case glassesWithoutAlpha
  case robot
  case apple
  case circle(name: String)
  case radius(name: String)
  case scaled(name: String)
  case scaledToFit(name: String)
  case scaledToFill(name: String)

  var url: URL {
    switch self {
    case .glasses:
      return Resource.folderURL.appendingPathComponent("glasses.png")
    case .glassesWithoutAlpha:
      return Resource.folderURL.appendingPathComponent("glasses_without_alpha.jpeg")
    case .robot:
      return Resource.folderURL.appendingPathComponent("robot.png")
    case .apple:
      return Resource.folderURL.appendingPathComponent("Images/Original/apple.jpg")
    case .circle(let name):
      return Resource.folderURL.appendingPathComponent("Images/Modified/Circle/\(name)")
    case .radius(let name):
      return Resource.folderURL.appendingPathComponent("Images/Modified/Radius/\(name)")
    case .scaled(let name):
      return Resource.folderURL.appendingPathComponent("Images/Modified/Scale/\(name)")
    case .scaledToFit(let name):
      return Resource.folderURL.appendingPathComponent("Images/Modified/AspectScaleToFit/\(name)")
    case .scaledToFill(let name):
      return Resource.folderURL.appendingPathComponent("Images/Modified/AspectScaleToFill/\(name)")
    }
  }

  var data : Data {
    return try! Data(contentsOf: url)
  }

  static var folderURL: URL {
    var resources = URL(fileURLWithPath: #file, isDirectory: false).deletingLastPathComponents(2)
    resources.appendPathComponent("Resources")
    return resources
  }

}
