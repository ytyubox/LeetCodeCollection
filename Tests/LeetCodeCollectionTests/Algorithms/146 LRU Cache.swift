//
/* 
 *		Created by 游宗諭 in 2021/2/8
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 10.15
 */


import Foundation
import LeetCodeCollection
struct Pair:CustomDebugStringConvertible {
    internal init(_ key: Int,_ value: Int) {
        self.key = key
        self.value = value
    }
    
    var key: Int
    var value: Int
    
    var debugDescription: String {
        "k\(key)|\(value)"
    }
}
class LRUCache {
    typealias Node = MyLinkedList_Double<Pair>.Node
    
    private var elements = [Int: Node]()
    let list = MyLinkedList_Double<Pair>()

    private var capacity:Int
    

    init(_ capacity: Int) {
       self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        guard let node = elements[key] else {return -1}
        updateUsage(of: node)
        return node.val.value
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = elements[key] {
            node.val.value = value
            updateUsage(of: node)
            return
        }
        if elements.count < capacity {
            let node = Node(Pair(key, value))
            elements[key] = node
            list.addAtTail(node)
        }
        else {
            
            let node = list.dropAtIndex(list.count - 1)
            elements.removeValue(forKey: node!.val.key)
            list.addAtHead(Pair(key, value))
            elements[key] = list.head.next
        }

    }
    private func updateUsage(of node: Node) {
        list.removeNode(node)
        list.addAtHead(node)
    }
}
import XCTest
class _146LRU_Cache: XCTestCase {
    func test() throws {
        let sut = LRUCache(2)
        sut.put(1, 1)
        sut.put(2, 2)
        XCTAssertEqual(sut.get(1), 1)
        sut.put(3, 3)
        XCTAssertEqual(sut.get(2), -1)
        sut.put(4, 4)
        XCTAssertEqual(sut.get(1), -1)
        XCTAssertEqual(sut.get(3), 3)
        XCTAssertEqual(sut.get(4), 4)
    }
    func testTwo() throws {
        let sut = LRUCache(2)
        sut.put(1, 1)
        XCTAssertEqual(sut.get(1), 1)
        sut.put(2, 2)
        XCTAssertEqual(sut.get(2), 2)
}
}
