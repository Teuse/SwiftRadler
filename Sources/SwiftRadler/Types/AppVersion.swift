import Foundation

struct AppVersion: Codable, Equatable {
   let major: Int
   let minor: Int
   let patch: Int
   
   var asString: String {
      "\(major).\(minor).\(patch)"
   }
   
   init(major: Int, minor: Int, patch: Int) {
      self.major = major
      self.minor = minor
      self.patch = patch
   }
   
   init?(versionString: String?) {
      guard let versionString = versionString else { return nil }
      let components = versionString.split(separator: ".").compactMap { Int($0) }
      guard components.count == 3 else {
          return nil
      }
      self.major = components[0]
      self.minor = components[1]
      self.patch = components[2]
   }
   
   static func < (lhs: AppVersion, rhs: AppVersion) -> Bool {
      if lhs.major != rhs.major {
         return lhs.major < rhs.major
      } else if lhs.minor != rhs.minor {
         return lhs.minor < rhs.minor
      } else if lhs.patch != rhs.patch {
         return lhs.patch < rhs.patch
      }
      return false
   }
   
   static func > (lhs: AppVersion, rhs: AppVersion) -> Bool {
      if lhs == rhs {
         return false
      }
      return !(lhs < rhs)
   }
}
