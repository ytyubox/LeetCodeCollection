import Foundation

private class Solution {
    /// Area =  d * h
    /// which
    /// d ===  i - j
    /// h === min(Ai, Aj)
    ///  whatever pair of i, j, tallest one is more possible to have greater value
    ///  so that will move the shorter one to the center
    /// 當需要縮減的時候，比較高的那邊比較有可能達到較大的面積，因此縮減另一面，這樣雖然有些組合不會遍歷到，但是那些組合不可能是最大面積
    ///
    func maxArea(_ height: [Int]) -> Int {
        var m = Int.min
        func helper(_ p1:Int, _ p2: Int) {
            if p1 == p2 {return}
            let h = min(height[p1], height[p2])
            let d = p2 - p1
            let area = h * d
            switch true {
            case height[p1] < height[p2]: helper(p1 + 1, p2)
            default: helper(p1, p2 - 1)
            }
            m = max(m, area)
        }
        helper(0, height.count - 1)
            
        return m
    }
    func maxArea_Accepted_While(_ height: [Int]) -> Int {
        var m = Int.min, p1 = 0, p2 = height.count - 1
        while true {
            if p1 == p2 {break}
            let h = min(height[p1], height[p2])
            let d = p2 - p1
            let area = h * d
            switch true {
            case height[p1] < height[p2]: p1 += 1
            default: p2 -= 1
            }
            m = max(m, area)
        }
        return m
    }
    /// Time Limit Exceeded
    func maxArea_attempt1_TLE(_ height: [Int]) -> Int {
        var m = Int.min
        for p1 in height.indices {
            var p2 = height.count - 1
            while true {
                if p1 > p2 {break}
                let h = min(height[p1], height[p2])
                let d = p2 - p1
                let area = h * d
                p2 -= 1
                m = max(m, area)
            }
        }
        return m
    }
}

import XCTest

final class _11Tests: XCTestCase {
    func test1() throws {
        let height = [1,8,6,2,5,4,8,3,7]
        XCTAssertEqual(Solution().maxArea(height), 49)
    }
    func test2() throws {
        let height = [1,1]
        XCTAssertEqual(Solution().maxArea(height), 1)
    }
    func test3() throws {
        let height = [4,3,2,1,4]
        XCTAssertEqual(Solution().maxArea(height), 16)
    }
    func test4() throws {
        let height = [1,2,1]
        XCTAssertEqual(Solution().maxArea(height), 2)
    }
    func test5() throws {
        let height = [1,2]
        XCTAssertEqual(Solution().maxArea(height), 1)
    }
}

