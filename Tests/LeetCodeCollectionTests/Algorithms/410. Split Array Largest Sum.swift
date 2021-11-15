//
/*
 *		Created by 游宗諭 in 2021/9/6
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 12.0
 */

import Foundation

// MARK: - Solution

private class Solution {
    func splitArray(_ nums: [Int], _ m: Int) -> Int {
        var result = Int.max
        func dfs(_ i: Int, _ j: Int, _ cur: Int, _ maxValue: Int) {
            if i == nums.count, j == m {
                result = min(maxValue, result)
                return
            }
            if i == nums.count { return }
            if (1...).contains(i) {
                dfs(i + 1, j, cur + nums[i], max(maxValue, cur + nums[i]))
            }
            if j < m {
                dfs(i + 1, j + 1, nums[i], max(maxValue, nums[i]))
            }
        }
        
        dfs(0, 0, 0, 0)
        
        return result
    }
}
private class SolutionDP1 {
    // DP
    public func splitArray(_ nums: [Int],_ m: Int) -> Int {
        let n = nums.count
        
        /**
         ```
         dp [n+1:2]
         [
         min, max, max, ....
         min, max, max, ....
         ]
         sum [n+1:2]
         [
         0, Σ0, Σ1, Σ2, ... , Σn]
         ```
         */
        var dp: [[Int]] =  Array(repeating: Array(repeating: .max, count: n+1), count: 2)
        let sum: [Int] = {
            var sum = Array(repeating: 0, count: n + 1)
            for i in 0..<n {
                sum[i + 1] = nums[i] + sum[i]
            }
            print(sum)
            return sum
        }()
        dp[0][0] = -1
        dp[1][0] = -1
        
        
        /// 1...group
        for i in 1...m {
            /// 1...length
            for j in 1...n {
                var k = i - 1
            whileLoop:while true {
                guard k < j else {break whileLoop}
                let d = sum[j] - sum[k]
                let t = dp[(i-1)&1][k]
                dp[i&1][j] = min(dp[i&1][j],
                                 max(t, d))
                k += 1
            }
            }
        }
        return dp[m&1][n]
    }
}
/// https://leetcode.com/problems/split-array-largest-sum/discuss/533758/C%2B%2B-O(mnn)-DP-with-explanation
private class SolutionDP2 {
    func splitArray(_ nums:[Int],_ m: Int) -> Int {
        let n = nums.count
        
        var prefix_sum = Array(repeating: 0, count: n)
        var dp:[[Int]] = Array(repeating: Array(repeating: .max, count: m+1),
                               count: n+1)
        prefix_sum[0] = nums[0]
        // Step 1:
        for i in 1..<n {
            prefix_sum[i] = prefix_sum[i - 1] + nums[i]
        }
        
        // Step 2, 3:
        for i in 0..<n {
            dp[i][1] = prefix_sum[i]
        }
        
        dp[0][0] = 0
        // Step 4
        for i in 0..<n {
            // check all the possible splitting mechanism
            for j in 2...m {
                // from 0 to i,
                for k in 0..<i {
                    print(dp.d2)
                    dp[i][j] = min(dp[i][j], max(dp[k][j - 1],
                                                 prefix_sum[i] - prefix_sum[k]))
                }
            }
        }
        
        return dp[n - 1][m]
    }
}
// https://leetcode.com/problems/split-array-largest-sum/discuss/1084798/Java-Top-down-recursion-%2B-memoization.-~O(N2-*-M)-time
private class SolutionDP3 {
    func splitArray(_ nums:[Int],_ m: Int) -> Int {
        var memo:[[Int]] = Array(repeating: Array(repeating: -1, count: m+1),
                                 count: nums.count)
        func walk(_ start: Int, _ rem: Int) -> Int {
            // base case
            if (rem == 0 && start == nums.count) {
                return 0
            }
            if (rem == 0 || start == nums.count) {
                // if we reach the end and have not used up all patitions
                // or have used up all partitions and have not reached the end,
                // we do not want to count the current way of partitioning.
                // Return MAX_VALUE so that we don't contribute to the return value.
                return Int.max
            }
            
            let n = nums.count
            var ret = Int.max
            var curSum = 0
            
            if (memo[start][rem] != -1) {
                return memo[start][rem]
            }
            
            // try all positions to end the current partition.
            for i in start..<n {
                curSum += nums[i]
                
                // answer for partitioning the subarray to the right of the current partition,
                // with one less partition number allowance, because we already used one
                // for the current partition. i.e. (rem - 1).
                let futureSum = walk(i + 1, rem - 1)
                
                // we want to minimum of the largest sum of the partitions.
                ret = min(ret, max(curSum, futureSum))
            }
            
            memo[start][rem] = ret
            return ret
        }
        return walk(0, m)
    }
    
}

import XCTest

// MARK: - _410Tests

final class _410Tests: XCTestCase {
    func test1() throws {
        XCTAssertEqual(Solution().splitArray([7, 2, 5, 10, 8], 2),
                       18)
        XCTAssertEqual(Solution().splitArray([1, 2, 3, 4, 5], 2),
                       9)
        XCTAssertEqual(Solution().splitArray([1, 4, 4], 3),
                       4)
    }
    func testDP1() throws {
        XCTAssertEqual(SolutionDP1().splitArray([7, 2, 5, 10, 8], 5), 10)
//        XCTAssertEqual(SolutionDP1().splitArray([7, 2, 5, 10, 8], 2),
//                       18)
//        XCTAssertEqual(SolutionDP1().splitArray([1, 2, 3, 4, 5], 2),
//                       9)
//        XCTAssertEqual(SolutionDP1().splitArray([1, 4, 4], 3),
//                       4)
    }
    func testDP2() throws {
        XCTAssertEqual(SolutionDP2().splitArray([7, 2, 5, 10, 8], 5), 10)
//        XCTAssertEqual(SolutionDP2().splitArray([7, 2, 5, 10, 8], 2),
//                       18)
//        XCTAssertEqual(SolutionDP2().splitArray([1, 2, 3, 4, 5], 2),
//                       9)
//        XCTAssertEqual(SolutionDP2().splitArray([1, 4, 4], 3),
//                       4)
    }
    func testDP3() throws {
        XCTAssertEqual(SolutionDP3().splitArray([7, 2, 5, 10, 8], 2),
                       18)
        XCTAssertEqual(SolutionDP3().splitArray([1, 2, 3, 4, 5], 2),
                       9)
        XCTAssertEqual(SolutionDP3().splitArray([1, 4, 4], 3),
                       4)
    }
    func testOther() throws {
        XCTAssertEqual([7, 2, 5, 10, 8].reduce(0, +), 32)
    }
}

extension Array where Element == [Int] {
    var d2:String {
        self.map(\.description).joined(separator: "\n") + "\n"
    }
}
