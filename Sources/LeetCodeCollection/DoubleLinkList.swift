//
/* 
 *		Created by 游宗諭 in 2021/2/7
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 10.15
 */


import Foundation

public class DoubleListNode<T: CustomDebugStringConvertible>: CustomDebugStringConvertible{
    public var val: T!
    public var next: DoubleListNode<T>?
    public var prev: DoubleListNode<T>?
    public init(_ val: T!) {
        self.val = val
    }
    public var debugDescription: String {

        "\(val?.debugDescription ?? "nil")|\(next?.debugDescription ?? "nil")"
    }
}
public extension DoubleListNode {
    func removeSelf() -> DoubleListNode {
        self.prev?.next = next
        self.next?.prev = prev
        self.prev = nil
        self.next = nil
        return self
    }
}

public class MyLinkedList_Double<T: CustomDebugStringConvertible> {
    public typealias Node = DoubleListNode<T>
    public private(set) var head:Node = Node(nil)
    public private(set) var tail:Node = Node(nil)
    public var count = 0
    public init() {
        head.next = tail
        tail.prev = head
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    public func get(_ index: Int, default: T) -> T {
        getNode(index)?.val ?? `default`
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
    public func addAtHead(_ val: T) {
        addAtHead(Node(val))
    }
    
    public func addAtHead(_ nNode: Node) {
        nNode.next = head.next
        nNode.prev = head
        head.next?.prev = nNode
        head.next = nNode
        count += 1
    }
    /** Append a node of value val to the last element of the linked list. */
    public func addAtTail(_ val: T) {
        addAtTail(Node(val))
    }
    public func addAtTail(_ nNode: Node) {
        nNode.next = tail
        nNode.prev = tail.prev
        tail.prev?.next = nNode
        tail.prev = nNode
        count += 1
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    public func addAtIndex(_ index: Int, _ val: T) {
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
    public func deleteAtIndex(_ index: Int) {
        guard let node = getNode(index) else {return}
        node.prev?.next = node.next
        node.next?.prev = node.prev
        count -= 1
    }
    public func dropAtIndex(_ index: Int) -> Node? {
        guard let node = getNode(index) else {return nil}
        node.prev?.next = node.next
        node.next?.prev = node.prev
        count -= 1
        return node
    }
    /// Remove a node which is in the list, or will have undefined behavior
    public func removeNode(_ node: Node) {
        count -= 1
        _ = node.removeSelf()
    }
}
