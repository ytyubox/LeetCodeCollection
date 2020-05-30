//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/5/30.
//


private class Solution {
    init(n:Int) {
        self.n = n
    }
    private let nums = [Int]()
    private lazy var  doer:[([Int])->Int] = [
        maxSubArray0,
        
    ]
    var n:Int
    var maxSubArray:([Int])->Int {
        doer[n]
    }
    func maxSubArray0(_ nums: [Int]) -> Int {
        var (result,curSum) = (Int.min,0)
        for num in nums {
            curSum = max(curSum + num, num)
            result = max(result, curSum)
        }
        return result
    }
    func maxSubArray_DevideAndConquer(_ nums: [Int]) -> Int {
        0
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
        n:0
    )
    func testing() {
        let input = [-2,1,-3,4,-1,2,1,-5,4]
        let expect = 6
        XCTAssertEqual(solution.maxSubArray(input),expect)
    }
}
