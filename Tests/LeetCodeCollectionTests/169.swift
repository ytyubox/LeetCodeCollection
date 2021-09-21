//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/6/16.
//

import Foundation
var c = 0

func majorityElement(_ nums: [Int]) -> Int {

    func count(_ num:Int,
               _ l:Int,
               _ r:Int) -> Int {
        var count = 0
        for i  in l...r {
            c += 1
            if (nums[i] == num) { count += 1}
        }
        return count
    }

    func recur(_ l:Int,
               _ r:Int) -> Int {
        if l == r {return nums[l]}

        let mid = (r-l) / 2 + l
        let left  = recur(l, mid)
        let right = recur(mid+1, r)
        if left == right { return left} // first stack (0...0)
        let leftCount  = count( left, l, r)
        let rightCount = count(right, l, r)
        return leftCount > rightCount ? left : right
    }

    return recur(0, nums.count - 1)
}
import XCTest

class _169Tests:XCTestCase {
    func test() {
        
    }
}
