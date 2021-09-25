import Foundation
import os
private class MathSolution {
    func countBits(_ n: Int) -> [Int] {
        var r = Array(repeating: 0, count: n + 1)
        for i in 0...n {
            r[i] = r[i >> 1] + i & 1
        }
        return r
    }
}
private class RecursionSolution {
    func countBits(_ n: Int) -> [Int] {
        var r:[Int] = []
        for i in 0...n {
            var count = 0
            func get(n: Int) -> Int {
                if n == 0 {return count}
                count += n & 1
                return get(n: n >> 1)
            }
            r.append(get(n: i))
            
        }
       return r
    }
}
private class IteractorSolution {
    func countBits(_ n: Int) -> [Int] {
        var r:[Int] = []
        for i in 0...n {
            r.append(get(n: i))
            
        }
       return r
    }
    private func get(n: Int) -> Int {
        var n = n
        var count = 0
        while true {
            if n == 0 {return count}
            count += n & 1
            n >>= 1
        }
    }
}

import XCTest

final class _338Tests: XCTestCase {
    func test() throws {
        let solution = IteractorSolution()
        XCTAssertEqual(solution.countBits(2), [0,1,1])
        XCTAssertEqual(solution.countBits(5), [0,1,1,2,1,2])
    }
    func test_recursion() throws {
        let solution = RecursionSolution()
        XCTAssertEqual(solution.countBits(2), [0,1,1])
        XCTAssertEqual(solution.countBits(5), [0,1,1,2,1,2])
    }

    func test_math() throws {
        let solution = MathSolution()
        XCTAssertEqual(solution.countBits(2), [0,1,1])
        XCTAssertEqual(solution.countBits(5), [0,1,1,2,1,2])
    }
    func test_printBinary() {
        for i in 0...100 {
            logStatistics(i)
        }
    }
}


let statisticsLogger = Logger(subsystem: "", category: "")

// Log statistics about communication with a server.
func logStatistics(_ i: Int) {
    let i = i.binaryDescription
    statisticsLogger.log("\(i, align: .right(columns: 10))")
}

extension BinaryInteger {
    var binaryDescription: String {
        String(self, radix: 2)
    }
}

struct Print:ExpressibleByStringInterpolation {
    typealias StringLiteralType = String
    init(stringLiteral value: String) {
        
    }
    
}
