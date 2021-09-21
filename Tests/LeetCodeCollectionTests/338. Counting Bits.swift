import Foundation
private class Solution {
    func countBits(_ n: Int) -> [Int] {
        var r:[Int] = []
        for i in 0...n {
            r.append(get(n: i))
            
        }
       return r
    }
    private func get(n: Int) -> Int {
        var n = n
        var count = 0
        while true {
            if n == 0 {return count}
            count += n & 1
            n >>= 1
        }
    }
}

import XCTest

final class _338Tests: XCTestCase {
    func test() throws {
        XCTAssertEqual(Solution().countBits(2), [0,1,1])
        XCTAssertEqual(Solution().countBits(5), [0,1,1,2,1,2])
    }
}

