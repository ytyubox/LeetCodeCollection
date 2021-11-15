//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/11/29.
//

import Foundation
fileprivate class Node {
    init(_ val: Int)  {self.val = val}
    var val:Int
    var next: Node? = nil
}
fileprivate class MyLinkedList {
    fileprivate var head: Node? = nil
    /** Initialize your data structure here. */
    init() {
        
    }
    func toArray() -> [Int] {
        var h = head
        var r = [Int]()
        while true {
            guard let _h = h else {break}
            r.append(_h.val)
            h = _h.next
        }
        return r
        
    }
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        var i = index
        var h = head
        while true {
            if i == 0 {return h?.val ?? 0}
            i -= 1
            h = h?.next
        }
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        let node = Node(val)
        node.next = head
        head = node
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        if head == nil {return head = Node(val)}
        var h = head
        while true {
            if h?.next == nil {break}
            h = h?.next
        }
        
        h!.next = Node(val)
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        var h = head
        var i = index
        while true {
            i -= 1
            if i == 0 {break}
            h = h?.next
            if h == nil {return}
        }
        let new = Node(val)
        new.next = h?.next
        h?.next = new
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        if index == 0 {return deleteHead()}
        var i = index - 1
        var h = head
        while true {
            if i == 0 {break}
            i -= 1
            h = h?.next
        }
        h?.next = h?.next?.next
    }
    func deleteHead() {
        head = head?.next
    }
}

/**
 * Your MyLinkedList object will be instantiated and called as such:
 * let obj = MyLinkedList()
 * let ret_1: Int = obj.get(index)
 * obj.addAtHead(val)
 * obj.addAtTail(val)
 * obj.addAtIndex(index, val)
 * obj.deleteAtIndex(index)
 */
import XCTest
class _707Tests: XCTestCase {
    func testNew() {
        let sut = makeSUT()
        XCTAssertEqual(sut.toArray(), [])
        sut.addAtHead(1)
        XCTAssertEqual(sut.toArray(), [1])
        sut.addAtTail(3)
        XCTAssertEqual(sut.toArray(), [1,3])
        sut.addAtIndex(1, 2)
        XCTAssertEqual(sut.toArray(), [1,2,3])
        XCTAssertEqual(sut.get(1), 2)
        sut.deleteAtIndex(1)
        XCTAssertEqual(sut.toArray(), [1, 3])
        XCTAssertEqual(sut.get(1), 3)
    }
    func testTail() {
        let sut = makeSUT()
        sut.addAtTail(1)
        XCTAssertEqual(sut.toArray(), [1])
    }
    func testDeleteHead() {
        let sut = makeSUT()
        sut.addAtHead(2)
        sut.addAtHead(1)
        XCTAssertEqual(sut.toArray(), [1,2])
        sut.deleteAtIndex(0)
        XCTAssertEqual(sut.toArray(), [2])
    }
    func testAddAtNowhere() {
        let sut = makeSUT()
        sut.addAtIndex(1, 10)
        XCTAssertEqual(sut.toArray(), [])
    }
    fileprivate func makeSUT() -> MyLinkedList {
        MyLinkedList()
    }
}
/*
[
 "MyLinkedList",[],
 "addAtHead", [1],
 "addAtTail", [3],
 "addAtIndex", [1,2],
 "get", [1],
 "deleteAtIndex", [1],
 "get"] [1]]
*/
