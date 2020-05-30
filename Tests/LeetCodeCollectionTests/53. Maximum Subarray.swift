//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/5/30.
//


private class Solution {
    init(approchNumber:Int) {
        self.approchNumber = approchNumber
    }
    private let nums = [Int]()
    private lazy var  doer:[([Int])->Int] = [
        maxSubArray_greedy,
        
    ]
    var approchNumber:Int
    var maxSubArray: ([Int])->Int {
        let n = approchNumber < doer.count ? approchNumber : 0
        return doer[n]
    }
    /**
     [-2, 1,-3, 4,-1, 2, 1,-5, 4]
     [-2, 1,-2, 4, 3, 5, 6, 1, 5]
     [-2, 1, 1, 4, 4, 6, 6, 6, 6]
     */
    
    func maxSubArray_greedy(_ nums: [Int]) -> Int {
        var result = nums.first!
        var curSum = result
        for num in nums[1...] {
            curSum = max(curSum + num, num)
            result = max(result, curSum)
        }
        return result
    }
    func maxSubArray_DevideAndConquer(_ nums: [Int]) -> Int {
        let middlePoint = nums.count/2
        let left = nums[0...middlePoint]
        let right = nums[(middlePoint-1)..<nums.count]
        
        func crossSum(_ nums:[Int],
                      _ left: Int,
                      _ right: Int,
                      _ p:Int
        ) -> Int {
            0
        }
        return 0
    }
    
}

import XCTest

/** Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.
 
 Example:
 
 Input: [-2,1,-3,4,-1,2,1,-5,4],
 Output: 6
 Explanation: [4,-1,2,1] has the largest sum = 6.
 Follow up:
 
 If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
 */
class _53MaximunSubarrayTests:XCTestCase {
    private let solution = Solution(
        approchNumber: 0
    )
    func testing() {
        let input = [-2,1,-3,4,-1,2,1,-5,4]
        let expect = 6
        XCTAssertEqual(solution.maxSubArray(input),expect)
    }
}
