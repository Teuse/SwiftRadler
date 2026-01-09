import Foundation

@propertyWrapper
struct CodableDefault<Value: Codable> {
   let key: String
   let defaultValue: Value
   private let encoder = JSONEncoder()
   private let decoder = JSONDecoder()

   var wrappedValue: Value {
      get {
         if let data = UserDefaults.standard.object(forKey: key) as? Data,
            let decoded = try? decoder.decode(Value.self, from: data) {
            return decoded
         }
         return defaultValue
      }
      set {
         if let encoded = try? encoder.encode(newValue) {
            UserDefaults.standard.setValue(encoded, forKey: key)
         } else {
            UserDefaults.standard.removeObject(forKey: key)
         }
      }
   }
}
