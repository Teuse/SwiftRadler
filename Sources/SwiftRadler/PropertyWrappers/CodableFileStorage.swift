import Foundation

@propertyWrapper
public struct CodableFileStorage<Value: Codable> {
   private let url: URL
   private let defaultValue: Value
   private let encoder = JSONEncoder()
   private let decoder = JSONDecoder()
   
   public init(fileName: String, defaultValue: Value) {
      self.url = Self.documentsDirectory().appendingPathComponent(fileName)
      self.defaultValue = defaultValue
   }
   
   public init(url: URL, defaultValue: Value) {
      self.url = url
      self.defaultValue = defaultValue
   }
   
   public var wrappedValue: Value {
      get {
         do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(Value.self, from: data)
         } catch {
            return defaultValue
         }
      }
      set {
         do {
            let data = try encoder.encode(newValue)
            try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
            try data.write(to: url, options: [.atomic])
            // Attempt to set file protection; ignore failures on platforms where it's unsupported.
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = false
            try? (url as NSURL).setResourceValue(false, forKey: .isExcludedFromBackupKey)
         } catch {
            // If we fail to encode or write, remove the file to avoid stale data.
            try? FileManager.default.removeItem(at: url)
         }
      }
   }
   
   private static func documentsDirectory() -> URL {
#if os(macOS)
      if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
         return url
      }
      return FileManager.default.homeDirectoryForCurrentUser
#else
      return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
#endif
   }
}
