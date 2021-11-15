//
/*
 *		Created by 游宗諭 in 2021/4/14
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 11.2
 */

import Foundation

// MARK: - Solution

private class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let m = { l, u -> Int in
            var (l, u) = (l, u)
            while true {
                if l >= u { return -1 }
                let m = mid(l, u), mnb = nums[m]
                if mnb == target { return m }
                if mnb < target { l = m + 1 }
                if mnb > target { u = m }
            }

        }(0, nums.count)
        if m == -1 { return [-1, -1] }
        
        let l = { l, u -> Int in
            var (l, u) = (l, u)
            while true {
                if nums[l] == target { return l }
                let m = mid(l, u), mnb = nums[m]
                if mnb == target, nums[m - 1] == target { return m }
                if mnb == target { u = m - 1 }
                else { l = m + 1 }
            }

        }(0, m - 1)

        let u = { l, u -> Int in
            var (l, u) = (l, u)
            while true {
                if nums[u] == target { return u }
                let m = mid(l, u), mnb = nums[m]
                if mnb == target, nums[m + 1] != target { return m }
                if mnb == target { l = m + 1 }
                else { u = m - 1 }
            }

        }(m + 1, nums.count - 1)

        return [l, u]
    }
}

func mid(_ s: Int, _ b: Int) -> Int {
    (b - s) / 2 + s
}

import XCTest

// MARK: - _34Tests

final class _34Tests: XCTestCase {
    func test1() {
        Solution().searchRange([5, 7, 7, 8, 8, 10], 8).shouldBe([3, 4])
    }

    func test2() {
        Solution().searchRange([5, 7, 7, 8, 8, 10], 6).shouldBe([-1, -1])
    }

    func test3() {
        Solution().searchRange([], 0).shouldBe([-1, -1])
    }

    func test4() {
        Solution().searchRange([1], 0).shouldBe([-1, -1])
    }

    func test5() {
        Solution().searchRange([1], 1).shouldBe([0, 0])
    }
}

// MARK: - 🤫

/*
 👇
 [5,7,7,8,8,8,8,8,8,8,10]
 binary searh any target index (t)
 binary find 0...t, t...n
 for case 0...t
 if mid-1 != target and num_mid not then mid

 for case t+1...n
 3 * log(n)
 */
