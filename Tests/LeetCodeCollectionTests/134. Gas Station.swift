//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/5/30.
//

import Foundation

private class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var carTank = 0
        var startIndex = 0
        var totalTank = 0
        for index in gas.indices {
            // O(n) of gas.sum() - cost.sum()
            totalTank += gas[index] - cost[index]
            
            // Car did arrive, filling, about to go next
            carTank += gas[index] - cost[index]
            
            // only if can not arrive next station
            if carTank < 0 {
                // return value change
                startIndex = index + 1
                // reset to fresh start
                carTank = 0
            }
        }
        return totalTank >= 0 ? startIndex : -1
    }
}

import XCTest

class _134GasStation:XCTestCase {
    private let solution = Solution()
    
    func testSubmit() {
        let gas = [1,2,3,4,5]
        let cost = [3,4,5,1,2]
        let expect = 3
        let output = solution.canCompleteCircuit(gas, cost)
        XCTAssertEqual(expect, output)
    }
    func testSummitCannotCompleteCircuit() {
        let gas = [2,3,4]
        let cost = [3,4,3]
        let expect = -1
        let output = solution.canCompleteCircuit(gas, cost)
        XCTAssertEqual(expect, output)
    }
}
