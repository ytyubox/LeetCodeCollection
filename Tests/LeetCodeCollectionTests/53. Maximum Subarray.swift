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
        maxSubArray_DevideAndConquer,
    ]
    var approchNumber:Int
    var maxSubArray: ([Int])->Int {
        let n = approchNumber// < doer.count ? approchNumber : 0
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
            curSum = Swift.max(curSum + num, num)
            result = Swift.max(result, curSum)
        }
        return result
    }
    func maxSubArray_DevideAndConquer(_ nums: [Int]) -> Int {
        // middle part
        func crossSum(
            _ startIndex: Int,
            _ endIndex: Int
        ) -> Int {
            let p = (startIndex + endIndex) / 2
            var leftSubSum = Int.min
            var currSum = 0
            for i in (startIndex...p).reversed() {
                currSum += nums[i]
                leftSubSum = Swift.max(leftSubSum, currSum)
            }
            var rightSubSum = Int.min
            var rcurrSum = 0
            for i in (p+1)...endIndex {
                rcurrSum += nums[i]
                rightSubSum = Swift.max(rightSubSum, rcurrSum)
            }
            print(nums[startIndex...endIndex],"\n",
                  startIndex,
                  p,
                  endIndex,"\n",
                  "l:", leftSubSum.s,
                  "r:", rightSubSum.s,
                  "o:", leftSubSum + rightSubSum,
                  "\n")
            return leftSubSum + rightSubSum
        }
        
        func recusiveHelper(
            _ startIndex:Int,
            _ endIndex:Int
        ) -> Int {
            if startIndex == endIndex {
                return nums[startIndex]
            }
            let middlePoint = (startIndex+endIndex)/2
            let leftSum = recusiveHelper(startIndex, middlePoint)
            let rightSum = recusiveHelper(middlePoint+1, endIndex)
            let _crossSum = crossSum(startIndex, endIndex)
            return max(leftSum, rightSum, _crossSum)
        }
        return recusiveHelper(0, nums.count - 1)
    }
    private func max(_ a:Int,_ b:Int, _ c: Int) -> Int {
        Swift.max(Swift.max(a,b), c)
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
        approchNumber: 1
    )
    func testing9Elements() {
        let input = [-2,1,-3,4,-1,2,1,-5,4] // count = 9
        let expect = 6
        XCTAssertEqual(solution.maxSubArray(input),expect)
    }
    func testing3elements() {
        let input = [-2,1,-3] // count = 3
        let expect = 1
        XCTAssertEqual(solution.maxSubArray(input),expect)
    }
}
extension Int {
    var s:String {
        String(format: "%02d", self)
    }
}
