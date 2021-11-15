//import Foundation
//private class Solution {
//    func threeSum(_ nums: [Int]) -> [[Int]] {
//        var r:[[Int]] = []
//        let nums = nums.sorted()
//        for (i,v) in nums.enumerated() where i != 0 {
//            if nums[i - 1] == v {continue}
//            let target = 0 - v, l = i + 1, u = nums.count - 1
//            
//            
//        }
//        return r
//    }
//}
//import XCTest
//
//final class _15Tests: XCTestCase {
//    func test1() throws {
//
//        let nums = [-1,0,1,2,-1,-4]
////        XCTAssertEqual(Solution().threeSum(nums), [[-1,-1,2],[-1,0,1]])
//    }
//    func test2() throws {
//        let nums:[Int] = []
//        XCTAssertEqual(Solution().threeSum(nums), [])
//    }
//    func test3() throws {
//            let nums = [0]
//        XCTAssertEqual(Solution().threeSum(nums), [])
//        
//    }
//}
//
