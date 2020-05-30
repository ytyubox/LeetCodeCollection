import XCTest
@testable import LeetCodeCollection

final class LeetCodeCollectionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
      print(LeetCodeCollection.self)
        XCTAssertEqual(LeetCodeCollection().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
