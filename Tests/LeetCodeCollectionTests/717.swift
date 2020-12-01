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
    var head: SinglyListNode?
    /** Initialize your data structure here. */
    init() {
        head = nil
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        getNode(index)?.val ?? -1
    }
    private func getNode(_ index: Int) -> SinglyListNode? {
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
    private func getTail() -> SinglyListNode? {
        var cur = head
        while true {
            guard cur != nil, cur?.next != nil else {break}
            cur = cur?.next
        }
        return cur
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        let new = SinglyListNode(val)
        new.next = head
        head = new
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        if head == nil {return addAtHead(val)}
        let pre = getTail()
        pre?.next = SinglyListNode(val)
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        if head == nil {return addAtHead(val)}
        let prev = getNode(index - 1)
        if prev == nil {return addAtHead(val)}
        let cur = SinglyListNode(val)
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

//
//func delete(at index: Int) throws {
//    if index < 2 {
//        self.next = nil
//        return
//    }
//
//    guard let next = next else {
//        throw Internal.general
//    }
//
//    try next.delete(at: index-1)
//}
//
//

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
