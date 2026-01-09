import Foundation

@propertyWrapper
public struct UserDefault<Value> {
   let key: String
   let defaultValue: Value
   var container: UserDefaults = .standard
   
   public init(key: String, defaultValue: Value, container: UserDefaults) {
      self.key = key
      self.defaultValue = defaultValue
      self.container = container
   }
   
   public var wrappedValue: Value {
      get {
         return container.object(forKey: key) as? Value ?? defaultValue
      }
      set {
         container.set(newValue, forKey: key)
      }
   }
}
