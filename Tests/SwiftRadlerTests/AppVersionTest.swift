import Testing
@testable import SwiftRadler

// MARK: - Helpers
private func assertVersion(_ version: AppVersion?, major: Int, minor: Int, patch: Int?, _ message: String = "") {
   #expect(version != nil, "\(message)")
   #expect(version?.major == major, "\(message)")
   #expect(version?.minor == minor, "\(message)")
   if let patch {
      #expect(version?.patch == patch, "\(message)")
   } else {
      #expect(version?.patch == nil, "\(message)")
   }
}

// MARK: - Initialization & Parsing
@Suite("AppVersion Initialization & Parsing")
struct AppVersionInitializationTests {
   @Test("Init with numeric components (3 parts)")
   func initWithNumbersThree() {
      let v = AppVersion(major: 1, minor: 2, patch: 3)
      assertVersion(v, major: 1, minor: 2, patch: 3)
   }
   
   @Test("Init with numeric components (2 parts)")
   func initWithNumbersTwo() {
      let v = AppVersion(major: 1, minor: 2)
      assertVersion(v, major: 1, minor: 2, patch: nil)
   }
   
   @Test("Init from valid strings")
   func initFromValidStrings() {
      let threePartCases: [(String, Int, Int, Int)] = [
         ("1.2.3", 1, 2, 3),
         ("0.0.0", 0, 0, 0),
         ("10.20.30", 10, 20, 30),
         ("135.1453.1345", 135, 1453, 1345),
      ]
      for (s, maj, min, pat) in threePartCases {
         assertVersion(AppVersion(versionString: s), major: maj, minor: min, patch: pat, "for input: \(s)")
      }
      let twoPartCases: [(String, Int, Int)] = [
         ("1.2", 1, 2),
         ("0.0", 0, 0),
         ("10.20", 10, 20),
      ]
      for (s, maj, min) in twoPartCases {
         assertVersion(AppVersion(versionString: s), major: maj, minor: min, patch: nil, "for input: \(s)")
      }
   }
   
   @Test("Init from invalid strings returns nil")
   func initFromInvalidStrings() {
      let invalid = [
         "", "a.3.4", "2,3,4", "3.3.fa", "3.a3.3", "blub", "1", "1.2.3.4", ".1.2", "1..2"
      ]
      for s in invalid {
         let parsed = AppVersion(versionString: s)
         #expect(parsed == nil, "expected nil for \(s)")
      }
   }
}
// MARK: - Equality & Comparable
@Suite("AppVersion Equality & Comparable")
struct AppVersionComparableTests {
   @Test("Equality for same components")
   func equality() {
      #expect(AppVersion(major: 1, minor: 2, patch: 3) == AppVersion(major: 1, minor: 2, patch: 3))
      #expect(AppVersion(major: 1, minor: 2) == AppVersion(major: 1, minor: 2))
   }
   
   @Test("Inequality for differing components")
   func inequality() {
      #expect(AppVersion(major: 2, minor: 2, patch: 3) != AppVersion(major: 1, minor: 2, patch: 3))
      #expect(AppVersion(major: 1, minor: 3, patch: 3) != AppVersion(major: 1, minor: 2, patch: 3))
      #expect(AppVersion(major: 1, minor: 2, patch: 4) != AppVersion(major: 1, minor: 2, patch: 3))
   }
   
   @Test("Strict ordering across versions")
   func orderingMatrix() {
      let a = AppVersion(major: 1, minor: 0, patch: 0)
      let b = AppVersion(major: 1, minor: 1, patch: 0)
      let c = AppVersion(major: 1, minor: 1, patch: 1)
      let d = AppVersion(major: 2, minor: 0, patch: 0)
      #expect(a < b)
      #expect(b < c)
      #expect(c < d)
      #expect(d > c)
      #expect(c > b)
      #expect(b > a)
      #expect(a == AppVersion(major: 1, minor: 0, patch: 0))
   }
   
   @Test("Mixed 2-part vs 3-part comparisons")
   func mixedComparisons() {
      let two = AppVersion(major: 3, minor: 3)
      #expect(two < AppVersion(major: 4, minor: 2, patch: 3))
      #expect(two < AppVersion(major: 3, minor: 4, patch: 3))
      #expect(!(two < AppVersion(major: 3, minor: 3, patch: 3)))
      #expect(two > AppVersion(major: 2, minor: 3, patch: 3))
      #expect(two > AppVersion(major: 3, minor: 2, patch: 3))
      
      let three = AppVersion(major: 3, minor: 3, patch: 3)
      #expect(three < AppVersion(major: 4, minor: 2))
      #expect(three < AppVersion(major: 3, minor: 4))
      #expect(!(three < AppVersion(major: 3, minor: 3)))
      #expect(three > AppVersion(major: 2, minor: 3))
      #expect(three > AppVersion(major: 3, minor: 2))
   }
}

// MARK: - Round-trip
@Suite("AppVersion String Round-trip")
struct AppVersionRoundTripTests {
   @Test
   func roundTrip() {
      let original = AppVersion(major: 1, minor: 2, patch: 3)
      let string = "\(original.major).\(original.minor).\(original.patch ?? 0)"
      let parsed = AppVersion(versionString: string)
      #expect(parsed == original)
   }
}

