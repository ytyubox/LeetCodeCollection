import Foundation
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        []
    }
}
import XCTest

final class _15Tests: XCTestCase {
    func test1() throws {

        let nums = [-1,0,1,2,-1,-4]
        XCTAssertEqual(Solution().threeSum(nums), [[-1,-1,2],[-1,0,1]])
    }
    func test2() throws {
        let nums:[Int] = []
        XCTAssertEqual(Solution().threeSum(nums), [])
    }
    func test3() throws {
            let nums = [0]
        XCTAssertEqual(Solution().threeSum(nums), [])
        
    }
}

