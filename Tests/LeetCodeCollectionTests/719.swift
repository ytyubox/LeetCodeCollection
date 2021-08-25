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
        let sortedNums = nums.sorted()
        var low = 0
        var high = sortedNums[sortedNums.count - 1] - sortedNums[0]
        
        while low < high {
            print(low ,"...", high)
            let pivot = low + (high - low) / 2
            var count = 0, left = 0

            for right in 0..<sortedNums.count {
                while true {
                    let diff = sortedNums[right] - sortedNums[left]
//                    print("M", pivot,
//                          "R[\(right)]", sortedNums[right],
//                          "L[\(left)]", sortedNums[left],
//                          "diff", diff,  diff > pivot ? "> \(pivot)" : "", terminator: diff > pivot ? "\n" : "")
                    guard diff > pivot else {break}
                   left += 1
                }
                let add = right - left
                print("~> count + \(add)")
                count += right - left
                print("count", count)
            }
            print("---")
            
            switch count {
            case k...:
                high = pivot
            case ..<k:
                low = pivot + 1
            default:
                break
            }
//            if count >= k {
//                high = pivot
//            } else {
//
//            }
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
