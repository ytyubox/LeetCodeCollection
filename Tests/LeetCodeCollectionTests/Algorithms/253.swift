private class SolutionMap {
    
    func minMeetingRooms(intervals: [[Int]]) -> Int {
        var m: [Int: Int] = [:]
        for a in intervals {
            m[a[0], default: 0] += 1
            m[a[1], default: 0] -= 1
        }
        var rooms = 0, res = 0;
        for (key, value) in m {
            rooms += value
            res = max(res, rooms)
        }
        return res
    }
};


import XCTest

final class _253Tests: XCTestCase {
    func test() throws {
        
        
        
        
        //        Input: intervals = [[7,10],[2,4]]
        //        Output: 1
        //
        //        Example 3:
        //
        //        Input: intervals = [[0,30], [0,5],[5,10],[10,15],[15,20]]
        //        Output: 2
        
    }
}

