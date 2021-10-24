import Foundation
import XCTest
private class Solution {
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        let s = s + " " // fake tail, for off one bug
        var word = s.startIndex
        var p:String.Index = s.startIndex
        var w:String.Index = pattern.startIndex
        var dp:[Either<String.SubSequence, Character>: String.Index] = [:]
        while true {
            if w == pattern.endIndex || p == s.endIndex {
                return w == pattern.endIndex && p == s.endIndex
            }
            guard s[p] == " " else {
                p = s.index(after: p)
                continue
            }
            
            if (dp.put(.or(pattern[w]), w) != dp.put(.either(s[word...p]), w)) {
                  
                return false
            }
            
            p = s.index(after: p)
            word = p
            w = pattern.index(after: w)
        }
    }
}
extension Dictionary where Value: Equatable {
    mutating func put(_ key: Key, _ value: Value) -> Value? {
        guard let oldValue = self[key] else {
            self[key] = value
            return nil
        }
        if oldValue == value {return nil}
        self[key] = value
        return oldValue
    }
}
enum Either<T, U> {
    case either(T), or(U)
}
extension Either: Equatable where T: Equatable, U: Equatable {
    
}

extension Either: Hashable where T: Hashable, U: Hashable {
    
}
extension Either: CustomStringConvertible where T: CustomStringConvertible, U: CustomStringConvertible {
    var description: String {
        switch self {
        case .either(let t):
            return "\(T.self) \(t.description)"
        case .or(let u):
            return "\(U.self) \(u.description)"
        }
    }
}

final class _290WordPatternEasyATests: XCTestCase {
    func test() throws {
        XCTAssertEqual(Solution().wordPattern("aaa", "aa aa aa aa"), false)
        XCTAssertEqual(Solution().wordPattern("abba", "dog cat cat dog"), true)
        XCTAssertEqual(Solution().wordPattern("abba", "dog cat cat fish"), false)
        XCTAssertEqual(Solution().wordPattern("aaaa", "dog cat cat dog"), false)
        XCTAssertEqual(Solution().wordPattern("abba", "dog dog dog dog"), false)
    }
}


