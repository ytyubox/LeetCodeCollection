//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/4/28.
//

import XCTest

/**
 9. Palindrome Number
 
 Determine whether an integer is a palindrome. An integer is a palindrome when it reads the same backward as forward.
 
 Example 1:
 
 Input: 121
 Output: true
 Example 2:
 
 Input: -121
 Output: false
 Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.
 Example 3:
 
 Input: 10
 Output: false
 Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
 */

class No9: XCTestCase {
  
  func isPalindrome(_ x: Int) -> Bool {
    var z = (x > 0) ? x : -x
    var y = 0
    while z != 0 {
      y = y * 10 + z % 10
      z /= 10
    }
    return x == y
  }
  func testBefore() {
    XCTAssertEqual(isPalindrome(121), true)
    XCTAssertEqual(isPalindrome(-121), false)
    XCTAssertEqual(isPalindrome(10), false)
  }
}

