//
// Created by 游宗諭 in 2020/12/15
//
//
// Using Swift 5.0
//
// Running on macOS 10.15


import LeetCodeCollection

class _19 {
    var s = Strategy.twopointer
    
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        switch s {
            case .brute_force:
                return bruteForce_removeNthFromEnd(head, n)
            case .twopointer:
                return twopointer_removeNthFromEnd(head, n)
            default:
                fatalError()
        }
    }
    func bruteForce_removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var count = 0
        let dummy = ListNode(-1)
        dummy.next = head
        var p1 = head
        while true {
            if p1 == nil {break}
            p1 = p1?.next
            count += 1
        }
        p1 = dummy
        count -= n
        while true {
            if count == 0 {
                break
            }
            count -= 1
            p1 = p1?.next
        }
        p1?.next = p1?.next?.next
        return dummy.next
    }
    
    func twopointer_removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        nil
    }
}

import XCTest

class _19Tests: XCTestCase {
    let sut = _19()
    func test() {
//        let list = ListNode.make(array: [1,2,3,4,5])
//        let new = sut.removeNthFromEnd(list, 2)
//        XCTAssertEqual(new?.mapToArray(), [1,2,3,5])
    }
}
