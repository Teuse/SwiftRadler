import Foundation

public struct AppVersion: Codable, Equatable {
   public enum Format {
      case twoDigits, threeDigits
   }
   public let major: Int
   public let minor: Int
   public let patch: Int?
   
   public var format: Format {
      patch == nil ? .twoDigits : .threeDigits
   }
   
   public var asString: String {
      if let patch {
         return "\(major).\(minor).\(patch)"
      } else {
         return "\(major).\(minor)"
      }
   }
   
   public init(major: Int, minor: Int, patch: Int?=nil) {
      self.major = major
      self.minor = minor
      self.patch = patch
   }
   
   public init?(versionString: String?) {
      guard let versionString = versionString else { return nil }
      guard !versionString.contains("..") else { return nil }
      guard versionString.first != "." && versionString.last != "." else { return nil }
      let parts = versionString.split(separator: ".")
      guard parts.count == 2 || parts.count == 3 else { return nil }
      let numbers = parts.compactMap { Int($0) }
      guard numbers.count == parts.count else { return nil }
      self.major = numbers[0]
      self.minor = numbers[1]
      self.patch = numbers.count == 3 ? numbers[2] : nil
   }
   
   public static func < (lhs: AppVersion, rhs: AppVersion) -> Bool {
      if lhs.major != rhs.major {
         return lhs.major < rhs.major
      } else if lhs.minor != rhs.minor {
         return lhs.minor < rhs.minor
      } else if let lhsPatch = lhs.patch, let rhsPatch = rhs.patch, lhsPatch != rhsPatch {
         return lhsPatch < rhsPatch
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

