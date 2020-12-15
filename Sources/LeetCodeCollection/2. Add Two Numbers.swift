//
//  Add Two Numbers.swift
//  
//
//  Created by 游宗諭 on 2020/4/21.
//

import Foundation

public class ListNode {
  /// Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
  /// Output: 7 -> 0 -> 8
  /// Explanation: 342 + 465 = 807.
  
  public var val: Int
  public var next: ListNode?
  public init(_ val: Int) {
    self.val = val
    self.next = nil
  }
    public init(_ val: Int, next: ()->ListNode?) {
      self.val = val
      self.next = next()
    }
  
}
extension ListNode {
  public static func make(array: [Int]) -> ListNode {
    if array.isEmpty {fatalError()}
    var list = array
    let returnNode = ListNode(list.removeFirst())
    var node:ListNode? = returnNode
    for v in list {
      node?.next = ListNode(v)
      node = node?.next
    }
    return returnNode
  }
}
public extension ListNode {
    var id: ObjectIdentifier {.init(self)}
}

class AddTwoNumbersSolution: Run {
  
  
  func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    var l1 = l1
    var l2 = l2
    let output = ListNode(0)
    var outputTail:ListNode? = output
    var extra = 0
    while true {
      let value = (l1?.val ?? 0) + (l2?.val ?? 0) + (extra)
      outputTail?.val = value % 10
      extra = value / 10
      l1 = l1?.next
      l2 = l2?.next
      if  extra == 0, l1 == nil, l2 == nil {break}
      outputTail?.next = ListNode(0)
      outputTail = outputTail?.next
    }
    return output
  }
  
  
  public func run() {
    let l1 = ListNode.make(array: [2,4,3])
    let l2 = ListNode.make(array: [5,6,4])
    let result = addTwoNumbers(l1, l2)
    dump( result)
    do {
      let l1 = ListNode.make(array: [0])
      let l2 = ListNode.make(array: [0])
      let result = addTwoNumbers(l1, l2)
      dump( result)
    }
    do {
      let s1 = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1]
      let s2 = [5,6,4]
      let l1 = ListNode.make(array: s1)
      let l2 = ListNode.make(array: s2)
      let result = addTwoNumbers(l1, l2)
      dump( result)
    }
    do {
        let s1 = [5]
        let s2 = [5]
        let l1 = ListNode.make(array: s1)
        let l2 = ListNode.make(array: s2)
        let result = addTwoNumbers(l1, l2)
        dump( result)
      }
    do {
         let s1 = [1]
         let s2 = [9,9]
         let l1 = ListNode.make(array: s1)
         let l2 = ListNode.make(array: s2)
         let result = addTwoNumbers(l1, l2)
         dump( result)
       }
  }
}
