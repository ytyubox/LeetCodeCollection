//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/12/1.
//

import Foundation
class SinglyListNode {
    var val: Int
    var next: SinglyListNode? = nil
    init(_ val: Int) { self.val = val}
}

class MyLinkedList {
    typealias Node = SinglyListNode
    var head: Node?
    /** Initialize your data structure here. */
    init() {
        head = nil
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        getNode(index)?.val ?? -1
    }
    private func getNode(_ index: Int) -> Node? {
        var cur = head
        if index < 0 {return nil}
        var i = 0
        while true {
            guard i < index, cur != nil else {break}
            i += 1
            cur = cur?.next
        }
        return cur
    }
    private func getTail() -> Node? {
        var cur = head
        while true {
            guard cur != nil, cur?.next != nil else {break}
            cur = cur?.next
        }
        return cur
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        let new = Node(val)
        new.next = head
        head = new
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        if head == nil {return addAtHead(val)}
        let pre = getTail()
        pre?.next = Node(val)
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        if head == nil {return addAtHead(val)}
        let prev = getNode(index - 1)
        if prev == nil {return addAtHead(val)}
        let cur = Node(val)
        let next = prev?.next
        cur.next = next
        prev?.next = cur
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        let cur = getNode(index)
        if cur == nil {return}
        let next = cur?.next
        guard let prev = getNode(index - 1) else {return head = next}
        prev.next = next
        
    }
}



import XCTest
class _717Tests: XCTestCase {
    func test() {
        let sut = makeSUT()
        sut.addAtHead(0)
        XCTAssertEqual(sut.array, [0])
        sut.addAtTail(1)
        XCTAssertEqual(sut.array, [0,1])
        sut.addAtIndex(2, 2)
        XCTAssertEqual(sut.array, [0,1,2])
    }
    func testCase() {
        let sut = makeSUT()
        sut.addAtHead(7)
        XCTAssertEqual(sut.array, [7])
        sut.addAtTail(7)
        XCTAssertEqual(sut.array, [7, 7])
        sut.addAtHead(9)
        XCTAssertEqual(sut.array, [9, 7, 7])
        sut.addAtTail(8)
        XCTAssertEqual(sut.array, [9, 7, 7, 8])
        sut.addAtHead(6)
        XCTAssertEqual(sut.array, [6, 9, 7, 7, 8])
        sut.addAtHead(0)
        XCTAssertEqual(sut.array, [0, 6, 9, 7, 7, 8])
        XCTAssertEqual(sut.get(5), [0, 6, 9, 7, 7, 8][5])
        sut.addAtHead(0)
        XCTAssertEqual(sut.array, [0, 0, 6, 9, 7, 7, 8])
        XCTAssertEqual(sut.get(2), [0, 0, 6, 9, 7, 7, 8][2])
        XCTAssertEqual(sut.get(5), [0, 0, 6, 9, 7, 7, 8][5])
        sut.addAtTail(4)
        XCTAssertEqual(sut.array, [0, 0, 6, 9, 7, 7, 8, 4])
    }
    func testCase02() {
        let sut = makeSUT()
        sut.addAtHead(1)
        sut.addAtTail(3)
        sut.addAtIndex(1,2)
        XCTAssertEqual(sut.array, [1,2,3])
        XCTAssertEqual(sut.get(1), 2)
        sut.deleteAtIndex(0)
        XCTAssertEqual(sut.array, [2,3])
        XCTAssertEqual(sut.get(0), 2)
        
    }
    func testCase03() {
        let sut = MyLinkedList()
        sut.addAtIndex(0,10)
        XCTAssertEqual(sut.array, [10])
        sut.addAtIndex(0,20)
        XCTAssertEqual(sut.array, [20,10])
        sut.addAtIndex(1,30)
        XCTAssertEqual(sut.array, [20, 30, 10])
        XCTAssertEqual(sut.get(0), 20)
    }
    
    func makeSUT() -> MyLinkedList {
        MyLinkedList()
    }
}
// MARK: - Double Linked List

class _717Version2: XCTestCase {
    func test() {
        let sut = makeSUT()
        sut.addAtHead(0)
        XCTAssertEqual(sut.array, [0])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtTail(1)
        XCTAssertEqual(sut.array, [0,1])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtIndex(2, 2)
        XCTAssertEqual(sut.array, [0,1,2])
        XCTAssertEqual(sut.array, sut.arrayTail)
    }
    func testCase() {
        let sut = makeSUT()
        sut.addAtHead(7)
        XCTAssertEqual(sut.array, [7])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtTail(7)
        XCTAssertEqual(sut.array, [7, 7])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtHead(9)
        XCTAssertEqual(sut.array, [9, 7, 7])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtTail(8)
        XCTAssertEqual(sut.array, [9, 7, 7, 8])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtHead(6)
        XCTAssertEqual(sut.array, [6, 9, 7, 7, 8])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtHead(0)
        XCTAssertEqual(sut.array, [0, 6, 9, 7, 7, 8])
        XCTAssertEqual(sut.array, sut.arrayTail)
        XCTAssertEqual(sut.get(5), [0, 6, 9, 7, 7, 8][5])
        sut.addAtHead(0)
        XCTAssertEqual(sut.array, [0, 0, 6, 9, 7, 7, 8])
        XCTAssertEqual(sut.array, sut.arrayTail)
        XCTAssertEqual(sut.get(2), [0, 0, 6, 9, 7, 7, 8][2])
        XCTAssertEqual(sut.get(5), [0, 0, 6, 9, 7, 7, 8][5])
        sut.addAtTail(4)
        XCTAssertEqual(sut.array, sut.arrayTail)
        XCTAssertEqual(sut.array, [0, 0, 6, 9, 7, 7, 8, 4])
    }
    func testCase02() {
        let sut = makeSUT()
        sut.addAtHead(1)
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtTail(3)
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtIndex(1,2)
        XCTAssertEqual(sut.array, [1,2,3])
        XCTAssertEqual(sut.array, sut.arrayTail)
        XCTAssertEqual(sut.get(1), 2)
        sut.deleteAtIndex(0)
        XCTAssertEqual(sut.array, sut.arrayTail)
        XCTAssertEqual(sut.array, [2,3])
        XCTAssertEqual(sut.get(0), 2)
        
    }
    func testCase03() {
        let sut = MyLinkedList()
        sut.addAtIndex(0,10)
        XCTAssertEqual(sut.array, [10])
        XCTAssertEqual(sut.array, sut.arrayTail)
        sut.addAtIndex(0,20)
        XCTAssertEqual(sut.array, sut.arrayTail)
        XCTAssertEqual(sut.array, [20,10])
        sut.addAtIndex(1,30)
        XCTAssertEqual(sut.array, sut.arrayTail)
        XCTAssertEqual(sut.array, [20, 30, 10])
        XCTAssertEqual(sut.get(0), 20)
    }
    func testCase04() {
        let sut = MyLinkedList()
        sut.addAtHead(84)
        sut.addAtTail(2)
        sut.addAtTail(39)
        XCTAssertEqual(-1, sut.get(3))
        XCTAssertEqual(2, sut.get(1))
        sut.addAtTail(42)
        sut.addAtIndex(1,80)
        sut.addAtHead(14)
        sut.addAtHead(1)
        sut.addAtTail(53)
        sut.addAtTail(98)
        sut.addAtTail(19)
        sut.addAtTail(12)
        XCTAssertEqual(84, sut.get(2))
        sut.addAtHead(16)
        sut.addAtHead(33)
        sut.addAtIndex(4,17)
        sut.addAtIndex(6,8)
        sut.addAtHead(37)
        sut.addAtTail(43)
        sut.deleteAtIndex(11)
        sut.addAtHead(80)
        sut.addAtHead(31)
        sut.addAtIndex(13,23)
        sut.addAtTail(17)
        XCTAssertEqual(16, sut.get(4))
        sut.addAtIndex(10,0)
        sut.addAtTail(21)
        sut.addAtHead(73)
        sut.addAtHead(22)
        sut.addAtIndex(24,37)
        sut.addAtTail(14)
        sut.addAtHead(97)
        sut.addAtHead(8)
        XCTAssertEqual(37,
        sut.get(6)
        )
        sut.deleteAtIndex(17)
        sut.addAtTail(50)
        sut.addAtTail(28)
        sut.addAtHead(76)
        sut.addAtTail(79)
        XCTAssertEqual(23,
        sut.get(18)
        )
        sut.deleteAtIndex(30)
        sut.addAtTail(5)
        sut.addAtHead(9)
        sut.addAtTail(83)
        sut.deleteAtIndex(3)
        sut.addAtTail(40)
        sut.deleteAtIndex(26)
        sut.addAtIndex(20,90)
        sut.deleteAtIndex(30)
        sut.addAtTail(40)
        sut.addAtHead(56)
        sut.addAtIndex(15,23)
        sut.addAtHead(51)
        sut.addAtHead(21)
        XCTAssertEqual(19,
        sut.get(26)
        )
        sut.addAtHead(83)
        XCTAssertEqual(17,
        sut.get(30)
        )
        sut.addAtHead(12)
        sut.deleteAtIndex(8)
        XCTAssertEqual(56,
            sut.get(4)
        )
        sut.addAtHead(20)
        sut.addAtTail(45)
        XCTAssertEqual(31, sut.get(10))
        sut.addAtHead(56)
        XCTAssertEqual(17, sut.get(18))
        sut.addAtTail(33)
        XCTAssertEqual(12, sut.get(2))
        sut.addAtTail(70)
        sut.addAtHead(57)
        sut.addAtIndex(31,24)
        sut.addAtIndex(16,92)
        sut.addAtHead(40)
        sut.addAtHead(23)
        sut.deleteAtIndex(26)
        XCTAssertEqual(40,
        sut.get(1)
        )
        sut.addAtHead(92)
        sut.addAtIndex(3,78)
        sut.addAtTail(42)
        XCTAssertEqual(37,
        sut.get(18)
        )
        sut.addAtIndex(39,9)
        XCTAssertEqual(76,
        sut.get(13)
        )
        sut.addAtIndex(33,17)
        dump(sut.array)
        XCTAssertEqual(42,
                       sut.get(51)
                       )
        sut.addAtIndex(18,95)
        sut.addAtIndex(18,33)
        sut.addAtHead(80)
        sut.addAtHead(21)
        sut.addAtTail(7)
        sut.addAtIndex(17,46)
        XCTAssertEqual(80,
        sut.get(33)
        )
        sut.addAtHead(60)
        sut.addAtTail(26)
        sut.addAtTail(4)
        sut.addAtHead(9)
        XCTAssertEqual(43,
        sut.get(45)
        )
        sut.addAtTail(38)
        sut.addAtHead(95)
        sut.addAtTail(78)
        XCTAssertEqual(40,
        sut.get(54)
        )
        sut.addAtIndex(42,86)
        
    }
    
    func makeSUT() -> MyLinkedList {
        MyLinkedList()
    }
    class DoubleListNode {
        var val: Int
        var prev: DoubleListNode? = nil
        var next:  DoubleListNode? = nil
        init(_ val: Int) { self.val = val}
    }
    class MyLinkedList {
        typealias Node = DoubleListNode
        var head: Node?
        var tail: Node?
        /** Initialize your data structure here. */
        init() {
            head = nil
            tail = nil
        }
        
        /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
        func get(_ index: Int) -> Int {
            getNode(index)?.val ?? -1
        }
        private func getNode(_ index: Int) -> Node? {
            var cur = head
            if index < 0 {return nil}
            var i = 0
            while true {
                guard i < index, cur != nil else {break}
                i += 1
                cur = cur?.next
            }
            return cur
        }
        private func getTail() -> Node? {
            tail
        }
        
        /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
        func addAtHead(_ val: Int) {
            let new = Node(val)
            new.next = head
            head?.prev = new
            head = new
            tail = tail ?? head
        }
        
        /** Append a node of value val to the last element of the linked list. */
        func addAtTail(_ val: Int) {
            if head == nil {return addAtHead(val)}
            let pre = getTail()
            pre?.next = Node(val)
            tail = pre?.next
            tail?.prev = pre
        }
        
        /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
        func addAtIndex(_ index: Int, _ val: Int) {
            if head == nil {return addAtHead(val)}
            guard let next = getNode(index) else {
                return addAtTail(val)
            }
            let cur = Node(val)
            let prev = next.prev
            prev?.next = cur
            cur.prev = prev
            cur.next = next
            next.prev = cur
            if index == 0 {head = cur}
        }
        
        /** Delete the index-th node in the linked list, if the index is valid. */
        func deleteAtIndex(_ index: Int) {
            guard let cur = getNode(index)
            else  {return}
            let prev = cur.prev
            let next = cur.next
            prev?.next = next
            next?.prev = prev
            if head === cur {head = next}
        }
    }
}

extension MyLinkedList {
    var array:[Int] {
        var r = [Int]()
        var _h = head
        while true {
            guard let h = _h else {break}
            r.append(h.val)
            _h = h.next
        }
        return r
    }
}

extension _717Version2.MyLinkedList {
    var array:[Int] {
        var r = [Int]()
        var _h = head
        while true {
            guard let h = _h else {break}
            r.append(h.val)
            _h = h.next
        }
        return r
    }
    var arrayTail:[Int] {
        var r = [Int]()
        var _h = tail
        while true {
            guard let h = _h else {break}
            r.append(h.val)
            _h = h.prev
        }
        return r.reversed()
    }

}
