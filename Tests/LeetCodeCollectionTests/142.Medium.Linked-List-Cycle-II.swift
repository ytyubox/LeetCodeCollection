//
// Created by 游宗諭 in 2020/12/15
//
//
// Using Swift 5.0
//
// Running on macOS 10.15


import Foundation
var _id = 0
private class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        _id += 1
        self.next = nil
    }
}
extension ListNode {
    var id:ObjectIdentifier {ObjectIdentifier(self)}
}

fileprivate class _142 {
    var map:[ObjectIdentifier: ListNode] = [:]
    func detectCycle(_ head: ListNode?) -> ListNode? {
        guard let _head = head else {return nil}
        map[_head.id] = _head
        var ptr = head
        while true {
            ptr = ptr?.next
            guard let _ptr = ptr else {return nil}
            if let node = map[_ptr.id] {
                return node
            }
            map[_ptr.id] = _ptr
        }
    }
}
fileprivate class _142_FloydToroise {
    
    func detectCycle(_ head: ListNode?) -> ListNode? {
        if head == nil {return head}
        let intersect = getIntersect(head)
        if intersect == nil {return nil}
        var ptr1 = head
        var ptr2 = intersect
        while true {
            if ptr1 === ptr2 {return ptr1}
            ptr1 = ptr1?.next
            ptr2 = ptr2?.next
        }
        
    }
    func getIntersect(_ head: ListNode?) -> ListNode?{
        var p1 = head
        var p2 = head
        while true {
            if p2 == nil, p2?.next == nil {return nil}
            p1 = p1?.next
            p2 = p2?.next?.next
            if p1 === p2 {return p2}
        }
    }
}

import XCTest

class _142Tests: XCTestCase {
    func test() {
        
        let target = makeList([3,2,0,-4], 1)
        let sut = _142()
        XCTAssertEqual(sut.detectCycle(target)?.val, 2)
    }
    func test2() {
        
        let target = makeList([3,2,0,-4], 1)
        let sut = _142_FloydToroise()
        XCTAssertEqual(sut.detectCycle(target)?.val, 2)
    }
    // MARK: - hepler
    
    private func makeList(_ list: [Int],_ post:Int) -> ListNode? {
        let list = list.map(ListNode.init)
        for (i, e) in list[0 ..< (list.count - 1)].enumerated() {
            e.next = list[i+1]
        }
        list.last?.next = list[post]
        return list.first
    }
}
