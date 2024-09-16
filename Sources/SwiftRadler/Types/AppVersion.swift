import Foundation

public struct AppVersion: Codable, Equatable {
   public let major: Int
   public let minor: Int
   public let patch: Int
   
   public var asString: String {
      "\(major).\(minor).\(patch)"
   }
   
   public init(major: Int, minor: Int, patch: Int) {
      self.major = major
      self.minor = minor
      self.patch = patch
   }
   
   public init?(versionString: String?) {
      guard let versionString = versionString else { return nil }
      let components = versionString.split(separator: ".").compactMap { Int($0) }
      guard components.count == 3 else {
          return nil
      }
      self.major = components[0]
      self.minor = components[1]
      self.patch = components[2]
   }
   
   public static func < (lhs: AppVersion, rhs: AppVersion) -> Bool {
      if lhs.major != rhs.major {
         return lhs.major < rhs.major
      } else if lhs.minor != rhs.minor {
         return lhs.minor < rhs.minor
      } else if lhs.patch != rhs.patch {
         return lhs.patch < rhs.patch
      }
      return false
   }
   
   public static func > (lhs: AppVersion, rhs: AppVersion) -> Bool {
      if lhs == rhs {
         return false
      }
      return !(lhs < rhs)
   }
}
