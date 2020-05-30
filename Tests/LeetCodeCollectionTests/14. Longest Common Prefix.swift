/*
 14. Longest Common Prefix
 Write a function to find the longest common prefix string amongst an array of strings.
 
 If there is no common prefix, return an empty string "".
 
 Example 1:
 
 Input: ["flower","flow","flight"]
 Output: "fl"
 Example 2:
 
 Input: ["dog","racecar","car"]
 Output: ""
 Explanation: There is no common prefix among the input strings.
 Note:
 
 All given inputs are in lowercase letters a-z.
 */

import XCTest

class _14_LongestCommonPrefix: XCTestCase {
  func testing() {
    XCTAssertEqual(longestCommonPrefix(["flower","flow","flight"]),"fl")
    XCTAssertEqual(longestCommonPrefix(["dog","racecar","car"]),"")
    XCTAssertEqual(longestCommonPrefix([]),"")
     XCTAssertEqual(longestCommonPrefix([""]),"")
    XCTAssertEqual(longestCommonPrefix(["a"]),"a")
  }
  func longestCommonPrefix(_ strs: [String]) -> String {
    "yet finished"
  }
}
