//
/*
 *		Created by 游宗諭 in 2021/7/22
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 12.0
 */

import Foundation

// MARK: - ContainSolution

private class ContainSolution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        let l = nums.count
        func helper(t: [Int]) -> [[Int]] {
            if t.count == l {
                return [t]
            }
            var r: [[Int]] = []
            for i in nums {
                if t.contains(i) { continue }
                var t = t
                t.append(i)
                let x = helper(t: t)
                r.append(contentsOf: x)
            }
            return r
        }

        for n in nums {
            result.append(contentsOf: helper(t: [n]))
        }
        return result
    }
}

// MARK: - VisitSolution

private class VisitSolution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        let l = nums.count
        func helper(t: [Int], _ history: [Bool]) {
            if t.count == l {
                result.append(t)
                return
            }
            for (i, num) in nums.enumerated() {
                if history[i] { continue }
                var history = history
                history[i] = true
                var t = t
                t.append(num)
                helper(t: t, history)
            }
        }
        let history = Array(repeating: false, count: l)
        helper(t: [], history)
        return result
    }
}

// MARK: - RemoveSolution

class RemoveSolution {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        var set: [Int] = []

        func permutation(_ nums: [Int]) {
            if nums.isEmpty {
                result.append(set)
                return
            }
            for i in nums.indices {
                var nums = nums
                let num = nums.remove(at: i)
                set.append(num)
                permutation(nums)
                set.removeLast()
            }
        }

        permutation(nums)
        return result
    }
}

import XCTest

// MARK: - _46Tests

final class _46Tests: XCTestCase {
    func test() {
        let Input: [Int] = [1, 2, 3]
        let Output = [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
        let result = ContainSolution().permute(Input)
        XCTAssertEqual(result, Output)
    }

    func test2() {
        let Input: [Int] = [1, 2]
        let result = ContainSolution().permute(Input)
        XCTAssertEqual(result, [[1, 2], [2, 1]])
    }

    func testMaxContains() {
        let input = (1...t).map { $0 }
        let start = CFAbsoluteTimeGetCurrent()
        let result = ContainSolution().permute(input)
        let end = CFAbsoluteTimeGetCurrent()
        time(end - start)
        XCTAssertEqual(result.count, 6)
    }

    let t = 3

    func testMaxVisit() {
        let input = (1...t).map { $0 }
        let start = CFAbsoluteTimeGetCurrent()
        let result = VisitSolution().permute(input)
        let end = CFAbsoluteTimeGetCurrent()
        time(end - start)
        XCTAssertEqual(result.count, 6)
    }

    func testMaxRemove() {
        let input = (1...t).map { $0 }
        let start = CFAbsoluteTimeGetCurrent()
        let result = RemoveSolution().permute(input)
        let end = CFAbsoluteTimeGetCurrent()
        time(end - start)
        XCTAssertEqual(result.count, 6)
    }
}

func time(_ time: Double, file: StaticString = #filePath, line: UInt = #line) {
//    XCTFail(time.description, file: file, line: line)
}
