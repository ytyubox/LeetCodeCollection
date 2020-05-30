//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/5/17.
//

import XCTest

class _20VaildParetheses: XCTestCase {
  
  func testing() {
    XCTAssertEqual(isValid("()"),true)
    XCTAssertEqual(isValid("()[]{}"),true)
    XCTAssertEqual(isValid("(]"),false)
    XCTAssertEqual(isValid("([)]"),false)
    XCTAssertEqual(isValid("{[]}"),true)
    
  }
  func isValid(_ s: String) -> Bool {
    
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
