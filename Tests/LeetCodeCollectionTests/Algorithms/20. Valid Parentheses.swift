//
//  File.swift
//
//
//  Created by 游宗諭 on 2020/5/17.
//

import XCTest
private class Solution {
    private let inner = Inner()
    private lazy var map:[Character: FUNC] = [
        "(":inner.append,
        "{":inner.append,
        "[":inner.append,
        ")":inner.decide1,
        "}":inner.decide2,
        "]":inner.decide3,
    ]
    func isValid(_ s: String) -> Bool {
        for c in s {
            map[c]?(c)
        }
        return inner.stack.isEmpty
    }
}
extension Solution {
    private typealias FUNC = (Character) -> Void
    private typealias FUNC2 = (Character, Character) -> Void
    
    private class Inner {
        var stack:[Character] = []
        func append(_ c: Character) {
            stack.append(c)
        }
        func decide(_ c: Character, _ c2: Character) {
            if stack.last == c2 {
                stack.removeLast()
            }else {
                stack.append(c)
            }
        }
        func decide1(_ c: Character) {
            decide(c, "(")
        }
        func decide2(_ c: Character) {
            decide(c, "{")
        }
        func decide3(_ c: Character) {
            decide(c, "[")
        }
    }

    func isValid2(_ s: String) -> Bool {
        
        let s = s.map{$0}
        var stack = [Character]()
        
        for cIndex in s.indices {
            let c = s[cIndex]
            switch c {
            case  "(","[", "{":
                stack.append(c)
                continue
            default:
                if cIndex == 0 {return false}
                switch c {
                case ")": if stack.last == "(" {
                    stack.removeLast()
                } else {return false}
                case "]": if stack.last == "[" {
                    stack.removeLast()
                } else {return false}
                case "}": if stack.last == "{" {
                    stack.removeLast()
                } else {return false}
                default: fatalError()
                }
            }
        }
        return stack.isEmpty
        
    }
}



class _20Tests: XCTestCase {
    
    func test() {
        
        
        XCTAssertEqual(makeSolution().isValid("()"),true)
        XCTAssertEqual(makeSolution().isValid("()[]{}"),true)
        XCTAssertEqual(makeSolution().isValid("(]"),false)
        XCTAssertEqual(makeSolution().isValid("([)]"),false)
        XCTAssertEqual(makeSolution().isValid("{[]}"),true)
        
    }
    private func makeSolution(file: StaticString = #filePath, line: UInt = #line) -> Solution {
        let sut = Solution()
        addTeardownBlock {
            [weak sut] in
            XCTAssertNil(sut, file: file, line: line)
        }
        return sut
    }
    
}
