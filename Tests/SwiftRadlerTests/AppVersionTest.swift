import XCTest
@testable import SwiftRadler

class AppVersionTests: XCTestCase {

   func testInitWithNumbers() throws {
      let version = AppVersion(major: 1, minor: 2, patch: 3)
      XCTAssertNotNil(version)
      XCTAssertEqual(version.major, 1)
      XCTAssertEqual(version.minor, 2)
      XCTAssertEqual(version.patch, 3)
   }
   
    func testInitWithString() throws {
       let version = AppVersion(versionString: "1.2.3")
       XCTAssertNotNil(version)
       XCTAssertEqual(version?.major, 1)
       XCTAssertEqual(version?.minor, 2)
       XCTAssertEqual(version?.patch, 3)
       
       XCTAssertNotNil(AppVersion(versionString: "1.1.1"))
       XCTAssertNotNil(AppVersion(versionString: "34.1.1"))
       XCTAssertNotNil(AppVersion(versionString: "1.45.1"))
       XCTAssertNotNil(AppVersion(versionString: "1.1.56"))
       XCTAssertNotNil(AppVersion(versionString: "135.1453.1345"))
       
       XCTAssertNil(AppVersion(versionString: ""))
       XCTAssertNil(AppVersion(versionString: "a.3.4"))
       XCTAssertNil(AppVersion(versionString: "2,3,4"))
       XCTAssertNil(AppVersion(versionString: "3.3.fa"))
       XCTAssertNil(AppVersion(versionString: "3.a3.3"))
       XCTAssertNil(AppVersion(versionString: "blub"))
    }
   
   func testComparison_3Digits() throws {
      let version1 = AppVersion(major: 1, minor: 2, patch: 3)
      let version2 = AppVersion(major: 1, minor: 2, patch: 3)
      XCTAssertEqual(version1, version2)
      
      let version3 = AppVersion(major: 4, minor: 2, patch: 3)
      XCTAssertNotEqual(version1, version3)
      
      let version4 = AppVersion(major: 1, minor: 4, patch: 3)
      XCTAssertNotEqual(version1, version4)
      
      let version5 = AppVersion(major: 1, minor: 2, patch: 5)
      XCTAssertNotEqual(version1, version5)
   }
   
   func testComparison_2Digits() throws {
      let version1 = AppVersion(major: 1, minor: 2)
      let version2 = AppVersion(major: 1, minor: 2)
      XCTAssertEqual(version1, version2)
      
      let version3 = AppVersion(major: 4, minor: 2)
      XCTAssertNotEqual(version1, version3)
      
      let version4 = AppVersion(major: 1, minor: 4)
      XCTAssertNotEqual(version1, version4)
      
      let version5 = AppVersion(major: 4, minor: 4)
      XCTAssertNotEqual(version1, version5)
   }
   
   func testGreaterSmallerComparisson_3Digits() throws {
      let baseVersion = AppVersion(major: 3, minor: 3, patch: 3)
      
      XCTAssert(!(baseVersion < baseVersion))
      XCTAssert(!(baseVersion > baseVersion))
      
      let version1 = AppVersion(major: 4, minor: 2, patch: 3)
      XCTAssert(baseVersion < version1)
      
      let version2 = AppVersion(major: 3, minor: 4, patch: 3)
      XCTAssert(baseVersion < version2)
      
      let version3 = AppVersion(major: 3, minor: 3, patch: 4)
      XCTAssert(baseVersion < version3)
      
      let version4 = AppVersion(major: 2, minor: 3, patch: 3)
      XCTAssert(baseVersion > version4)
      
      let version5 = AppVersion(major: 3, minor: 2, patch: 3)
      XCTAssert(baseVersion > version5)
      
      let version6 = AppVersion(major: 3, minor: 3, patch: 2)
      XCTAssert(baseVersion > version6)
   }
   
   func testGreaterSmallerComparisson_2Digits() throws {
      let baseVersion = AppVersion(major: 3, minor: 3)
      
      XCTAssert(!(baseVersion < baseVersion))
      XCTAssert(!(baseVersion > baseVersion))
      
      let version1 = AppVersion(major: 4, minor: 2)
      XCTAssert(baseVersion < version1)
      
      let version2 = AppVersion(major: 3, minor: 4)
      XCTAssert(baseVersion < version2)
      
      let version3 = AppVersion(major: 3, minor: 3)
      XCTAssert(!(baseVersion < version3))
      
      let version4 = AppVersion(major: 2, minor: 3)
      XCTAssert(baseVersion > version4)
      
      let version5 = AppVersion(major: 3, minor: 2)
      XCTAssert(baseVersion > version5)
   }
}
