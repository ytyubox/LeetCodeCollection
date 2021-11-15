//
// Created by 游宗諭 in 2020/12/15
//
//
// Using Swift 5.0
//
// Running on macOS 10.15

import LeetCodeCollection


/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */


class _160 {
    enum S {case timeout_o_mn, hashmap, twoptr}
    var s: S = .twoptr
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
         switch s {
            case .timeout_o_mn:
                return easy_getIntersectionNode(headA, headB)
            case .hashmap:
                return hashtable_getIntersectionNode(headA, headB)
            case .twoptr:
                return twoptr_getIntersectionNode(headA, headB)
        }
            
        
    }
    
    func easy_getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var p1 = headA
        while true {
            if p1 == nil {return nil}
            var p2 = headB
            while true {
                if p2 == nil {break}
                if p2 === p1 {return p2}
                p2 = p2?.next
            }
            p1 = p1?.next
        }
    }
    func hashtable_getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var cache: [ObjectIdentifier: ListNode] = [:]
        var p1 = headA
        while true {
            guard let _p1 = p1 else {break}
            cache[_p1.id] = _p1
            p1 = p1?.next
        }
        var p2 = headB
        while true {
            guard let _p2 = p2 else {return nil}
            if cache[_p2.id] != nil {return p2}
            p2 = p2?.next
        }
    }
    func twoptr_getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        var (pa, pb) = ( headA, headB)
        while true {
            if pa === pb {return pa}
            pa = (pa != nil) ? pa?.next : headB;
            pb = (pb != nil) ? pb?.next : headA;
        }
    }
}


import XCTest

class _160Tests: XCTestCase {
    let sut = _160()
    func test() throws {
        let restList = ListNode.make(array: [8,4,5])
        let list1 = ListNode(4) {
            ListNode(1) {
                restList
            }
        }
        let list2 = ListNode(5) {
            ListNode(6) {
                ListNode(1) {
                    restList
                }
            }
        }
        
        let result = try XCTUnwrap(sut.getIntersectionNode(list1, list2))
        XCTAssertTrue( result === restList)
    }
}
