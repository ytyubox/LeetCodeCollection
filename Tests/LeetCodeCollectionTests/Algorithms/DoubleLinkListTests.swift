//
/* 
 *		Created by 游宗諭 in 2021/2/8
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 10.15
 */


import LeetCodeCollection
import XCTest
class DoubleLinkedListTests: XCTestCase {
    typealias Node = DoubleListNode<Int>
    func test() throws {
       let node1 = Node(1)
       let node2 = Node(2)
       let node3 = Node(3)
        node1.next = node2
        node2.next = node3
        node3.prev = node2
        node2.prev = node1
    
        
        let dropedNode = node2.removeSelf()
        XCTAssertNil(dropedNode.prev)
        XCTAssertNil(dropedNode.next)
        XCTAssertTrue(node1.next === node3)
        XCTAssertTrue(node3.prev === node1)
    }

}

extension Int: CustomDebugStringConvertible {
    public var debugDescription: String {description}
}
