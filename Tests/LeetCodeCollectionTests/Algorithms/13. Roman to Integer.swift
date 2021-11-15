//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/4/28.
//

import XCTest

/*
 13. Roman to Integer
 Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.
 
 Symbol       Value
 I             1
 V             5
 X             10
 L             50
 C             100
 D             500
 M             1000
 For example, two is written as II in Roman numeral, just two one's added together. Twelve is written as, XII, which is simply X + II. The number twenty seven is written as XXVII, which is XX + V + II.
 
 Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:
 
 I can be placed before V (5) and X (10) to make 4 and 9.
 X can be placed before L (50) and C (100) to make 40 and 90.
 C can be placed before D (500) and M (1000) to make 400 and 900.
 Given a roman numeral, convert it to an integer. Input is guaranteed to be within the range from 1 to 3999.
 
 Example 1:
 
 Input: "III"
 Output: 3
 Example 2:
 
 Input: "IV"
 Output: 4
 Example 3:
 
 Input: "IX"
 Output: 9
 Example 4:
 
 Input: "LVIII"
 Output: 58
 Explanation: L = 50, V= 5, III = 3.
 Example 5:
 
 Input: "MCMXCIV"
 Output: 1994
 Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
 */

final class _13RomantoInteger: XCTestCase {
  /// I can be placed before V (5) and X (10) to make 4 and 9.
  /// X can be placed before L (50) and C (100) to make 40 and 90.
  /// C can be placed before D (500) and M (1000) to make 400 and 900.
  let allRomanChar:[Character:(Int,Array<Int>)] =
    [
      "I":(0001,[5,10]),
      "V":(0005,[]),
      "X":(0010,[50,100]),
      "L":(0050,[]),
      "C":(0100,[500,1000]),
      "D":(0500,[]),
      "M":(1000,[])
  ]
  
  
  
  func romanToInt(_ s: String) -> Int {
    let nbrs = s.map{allRomanChar[$0]!}
    var result = 0
    
    for index in nbrs.indices {
      var current = nbrs[index]
      let nextIndex = index + 1
      let next = (nextIndex == nbrs.count) ? 0 : nbrs[nextIndex].0
      let sign = (current.1.contains(next)) ? -1 : 1
      current.0 *= sign
      result += current.0
    }
    
    return result
  }
  
  func testingRun() {
    XCTAssertEqual(romanToInt("III"),3)
    XCTAssertEqual(romanToInt("IV"),4)
    XCTAssertEqual(romanToInt("IX"),9)
    XCTAssertEqual(romanToInt("LVIII"),58)
    XCTAssertEqual(romanToInt("MCMXCIV"),1994)
  }
}

