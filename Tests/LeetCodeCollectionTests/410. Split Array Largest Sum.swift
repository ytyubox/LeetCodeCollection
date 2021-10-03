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
    func _splitArray(_ nums: [Int], _ m: Int) -> Int {
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
        var sum: [Int] = Array(repeating: -1, count: n + 1)
        dp[0][0] = -1
        dp[1][0] = -1
        
        for i in 0..<n {
            sum[i + 1] = nums[i] + sum[i]
        }
        
        for i in 1...m {
            for j in 1...n {
                var k = i - 1
            whileLoop:while true {
                guard k < j else {break whileLoop}
                print(dp.d2)
                print("")
                dp[i&1][j] = min(dp[i & 1][j],
                                   max(dp[(i - 1) & 1][k],
                                       sum[j] - sum[k]))
                k += 1
            }
            }
        }
        return dp[m % 2][n]
    }
}

import XCTest

// MARK: - _410Tests

final class _410Tests: XCTestCase {
    func test1() throws {
        let nums = [7, 2, 5, 9, 8]
        
        XCTAssertEqual(Solution().splitArray(nums, 2), 17)
    }
    
    func test2() throws {
        let nums = [1, 2, 3, 4, 5]
        
        XCTAssertEqual(Solution().splitArray(nums, 2), 9)
    }
    
    func test3() throws {
        let nums = [1, 4, 4]
        XCTAssertEqual(Solution().splitArray(nums, 3), 4)
    }
}

extension Array where Element == [Int] {
    var d2:String {
        self.map(\.description).joined(separator: "\n")
    }
}
