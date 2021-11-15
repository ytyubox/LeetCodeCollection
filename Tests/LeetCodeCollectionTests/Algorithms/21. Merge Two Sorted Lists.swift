//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/5/17.
//

import XCTest

class _21MergeTwoSortedLists:XCTestCase {
  func testing() {
    //  1->2->4, 1->3->4
    let l1 = ListNode(1, .init(2, .init(4)))
    let l2 = ListNode(1, .init(3, .init(4)))
    // 1->1->2->3->4->4
    
    XCTAssertEqual(mergeTwoLists(l1, l2)?.mapToArray(), [1,1,2,3,4,4])
  }
  
  
  public class ListNode {
    func mapToArray() -> [Int] {
      var array = [Int]()
      var pointing:ListNode? = self
      while true {
        if pointing == nil {break}
        array.append(pointing!.val)
        pointing = pointing!.next
      }
      return array
    }
    
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
  }
  
  
  func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    guard let l1 = l1 else {return l2}
    guard let l2 = l2 else {return l1}
    
    var result:ListNode? = nil
    switch true {
      case l1.val <= l2.val:
        result = l1
        result!.next = mergeTwoLists(l1.next,l2)
      default:
        result = l2
        result!.next = mergeTwoLists(l1,l2.next)
    }
    return result
  }
}

