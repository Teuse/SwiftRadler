import Foundation

public struct LibraryCopyright: Hashable, Identifiable {
   public let id = UUID()
   public let name: String
   public let version: String
   public let license: License
   public let licenseText: String
   public let copyright: String
   public let shortName: String?
   public let url: String
   
   public init(name: String, shortName: String? = nil, version: String, license: License, licenseText: String, copyright: String, url: String) {
      self.name = name
      self.shortName = shortName
      self.version = version
      self.license = license
      self.licenseText = licenseText
      self.copyright = copyright
      self.url = url
   }
}
