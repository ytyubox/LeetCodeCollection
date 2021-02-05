//
// Created by 游宗諭 in 2020/12/15
//
//
// Using Swift 5.0
//
// Running on macOS 10.15


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
public extension ListNode {
    static func make(array: [Int]) -> ListNode {
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
    func mapToArray() -> [Int] {
        var array = [Int]()
        var pointing:ListNode? = self
        while true {
            if pointing == nil {break}
            array.append(pointing!.val)
            pointing = pointing!.next
        }
        return array
    }
    
}
public extension ListNode {
    var id: ObjectIdentifier {.init(self)}
}

