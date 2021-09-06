//
/* 
 *		Created by 游宗諭 in 2021/7/27
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 12.0
 */


import Foundation
private class Solution {
    func smallestDistancePair(_ nums: [Int], _ k: Int) -> Int {
        let nums = nums.sorted()
        var low:Int = 0, high:Int = nums[nums.count - 1] - nums[0]
        
        func possibleRank(for diffToCheck: Int) -> Int {
            var count = 0, diffWindowPointer = 0

            for stepperPointer in 0..<nums.count {
                while true {
                    let diff = nums[stepperPointer] - nums[diffWindowPointer]
                    guard diff > diffToCheck else {break}
                   diffWindowPointer += 1
                }
                let window = stepperPointer - diffWindowPointer
                count += window
            }
            return count
        }
        
        while low < high {
            let pivot = low + (high - low) / 2

            let indicator = possibleRank(for: pivot)
            
            switch indicator {
            case k...:
                high = pivot
            case ..<k:
                low = pivot + 1
            default:
                break
            }
        }
        
        return low
    }
}

import XCTest

final class _719Tests: XCTestCase {
    func test() throws {
//        XCTAssertEqual(Solution().smallestDistancePair([1,3,1], 1), 0)
//        XCTAssertEqual(Solution().smallestDistancePair([1,1,1], 2), 0)
//        XCTAssertEqual(Solution().smallestDistancePair([1,6,1], 3), 5)
                XCTAssertEqual(Solution().smallestDistancePair([1,2,5,8,9], 2), 1)
    }
}
/**
12 1
89 1
25 3
58 3
59 4
15 4
28 6
18 7
29 7
19 8

 */
