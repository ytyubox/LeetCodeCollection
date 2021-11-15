import Foundation
import XCTest
class DPForWithO1Solution {
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        var dp:[Int] = [cost[0],cost[1]]
        for i in 2..<cost.count {
            dp[i&1] = cost[i] + min(dp[0], dp[1])
        }
        return min(dp[0], dp[1])
    }
}
final class _746MinCostClimbingStairsEasyTests: XCTestCase {
    func test() throws {
        XCTAssertEqual(DPForWithO1Solution().minCostClimbingStairs([10,15,20]), 15)
        XCTAssertEqual(DPForWithO1Solution().minCostClimbingStairs([1,100,1,1,1,100,1,1,100,1]), 6)
    }
}


final class FibTests: XCTestCase {
    class DPO1 {
        func fib(_ n: Int) -> Int {
            var dp = [0,1]
            if n < 2 {return dp[n]}
            for i in 2...n {
                dp[i&1] = dp[0] + dp[1]
            }
            return dp[n&1]
        }
    }
    func test() throws {
        let fibs = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377 ,610]
        for i in fibs.indices {
            XCTAssertEqual(DPO1().fib(i), fibs[i])
        }
    }
}

