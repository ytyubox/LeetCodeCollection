//
/* 
 *		Created by 游宗諭 in 2021/2/7
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 10.15
 */


import Foundation

public class DoubleListNode<T> {
    public var val: T
    public var next: DoubleListNode<T>?
    public var prev: DoubleListNode<T>?
    public init(_ val: T) {
        self.val = val
    }
}

class MyLinkedList_Double {
    typealias Node = DoubleListNode<Int>
    var head:Node = Node(-1)
    var tail:Node = Node(-1)
    var count = 0
    init() {
        head.next = tail
        tail.prev = head
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    func get(_ index: Int) -> Int {
        getNode(index)?.val ?? -1
    }
    private func getNode(_ index: Int) -> Node? {
        guard count > index && index >= 0 else { return nil }
        var node = head.next
        var i = index
        while i > 0 {
            node = node?.next
            i -= 1
        }
        return node
        
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    func addAtHead(_ val: Int) {
        let nNode = Node(val)
        nNode.next = head.next
        nNode.prev = head
        head.next?.prev = nNode
        head.next = nNode
        count += 1
    }
    
    /** Append a node of value val to the last element of the linked list. */
    func addAtTail(_ val: Int) {
        let nNode = Node(val)
        nNode.next = tail
        nNode.prev = tail.prev
        tail.prev?.next = nNode
        tail.prev = nNode
        count += 1
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    func addAtIndex(_ index: Int, _ val: Int) {
        guard index <= count && index >= 0 else {
            return
        }
        var node:Node! = head
        var i = index
        while i > 0 {
            node = node?.next
            i -= 1
        }
        let nNode = Node(val)
        nNode.next = node.next
        nNode.prev = node
        node.next?.prev = nNode
        node.next = nNode
        count += 1
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    func deleteAtIndex(_ index: Int) {
        guard let node = getNode(index) else {return}
        node.prev?.next = node.next
        node.next?.prev = node.prev
        count -= 1
    }
    func dropAtIndex(_ index: Int) -> Node? {
        guard let node = getNode(index) else {return nil}
        node.prev?.next = node.next
        node.next?.prev = node.prev
        count -= 1
        return node
    }
}
