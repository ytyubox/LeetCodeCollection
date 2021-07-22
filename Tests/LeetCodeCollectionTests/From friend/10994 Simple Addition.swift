//
/*
 *		Created by 游宗諭 in 2021/4/20
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 11.2
 */

import Foundation
import XCTest

// MARK: - Solution

private class Solution {
    func simpleAddition(_ l: Int, _ u: Int) -> Int {
        var cache: [Int: Int] = .init(minimumCapacity: u - l)
        func helper(_ value: Int) -> Int {
            if let cached = cache[value] { return cached }
            if value == 0 { return 0 }
            let m = value % 10
            if m > 0 { return m }
            return helper(value / 10)
        }
        var r = 0
        for i in l ... u {
            let c = helper(i)
            cache[i] = c
            r += c
        }
        return r
    }
}

// MARK: - ATests

final class ATests: XCTestCase {
    func test() {
        let s = Solution().simpleAddition
        s(1, 10).shouldBe(46)
        s(01, 10).shouldBe(s(0, 9) + s(0, 1))
        s(10, 20).shouldBe(48)
        s(10, 20).shouldBe(s(0, 9) + s(1, 2))
        s(30, 40).shouldBe(52)
        s(30, 40).shouldBe(s(0, 9) + s(3, 4))
        s(90, 100).shouldBe(055)
        s(90, 100).shouldBe(s(0, 9) + s(9, 9) + s(0, 1))
    }

//    func testLarge() {
//        let start = CFAbsoluteTimeGetCurrent()
//        Solution().simpleAddition(0, Int(Int32.max)).shouldBe(49999996)
//        let end = CFAbsoluteTimeGetCurrent()
//        XCTAssertTrue((end - start) < 3)
//    }
}
