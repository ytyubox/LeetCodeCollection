import Foundation
import XCTest
import LeetCodeCollection
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}
extension TreeNode: Equatable {
    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.val == rhs.val &&
        lhs.left == rhs.left &&
        lhs.right == rhs.right
    }
}
extension TreeNode: CustomStringConvertible {
    public var description: String {
        
        return Codec().serialize(self)
    }
}

extension TreeNode: Sequence {
    public func makeIterator() -> PreOrderBinaryTreeIterator {
        PreOrderBinaryTreeIterator(node: self)
    }
    
    public typealias Iterator = PreOrderBinaryTreeIterator
    public struct PreOrderBinaryTreeIterator:IteratorProtocol {
        init(node: TreeNode?) {
            self.stack = [node].compactMap{$0}
            self.node = node
        }
        
        private(set) var stack:[TreeNode]
        private(set) var node: TreeNode?
        mutating public func next() -> TreeNode? {
            let node = stack.popLast()
            node?.right.map{stack.append($0)}
            node?.left.map{stack.append($0)}
            return node
        }
        
        public typealias Element = TreeNode
    }
}
public struct InOrderTreeNodeSequence: Sequence {
    let node: TreeNode?
    public typealias Iterator = InOrderBinaryTreeIterator
    public func makeIterator() -> InOrderBinaryTreeIterator {
        InOrderBinaryTreeIterator(node: node)
    }
    public struct InOrderBinaryTreeIterator:IteratorProtocol {
        init(node: TreeNode?) {
            self.stack = []
            self.cur = node
        }
        
        private(set) var stack:[TreeNode]
        private(set) var cur: TreeNode?
        mutating public func next() -> TreeNode? {
            if let cur = cur {
                stack.append(cur)
                self.cur = cur.left
                return next()
            }
            let node = stack.popLast()
            cur = node?.right
            return node
        }
        
        
        public typealias Element = TreeNode
    }
}
public struct PostOrderTreeNodeSequence: Sequence {
    let node: TreeNode?
    public typealias Iterator = PostOrderBinaryTreeIterator
    public func makeIterator() -> PostOrderBinaryTreeIterator {
        PostOrderBinaryTreeIterator(node: node)
    }
    public struct PostOrderBinaryTreeIterator:IteratorProtocol {
        init(node: TreeNode?) {
            self.stack = []
            self.cur = node
        }
        
        private(set) var stack:[TreeNode]
        private(set) var cur: TreeNode?
        
        mutating public func next() -> TreeNode? {
            
            // Check for empty stack
            while let cur = cur {
                stack.append(cur)
                stack.append(cur)
                self.cur = cur.left
            }
            cur = stack.popLast()
            
            if(!stack.isEmpty && stack.last === cur) {
                cur = cur?.right
                return next()
            }
            let tmp = cur
            cur = nil
            return tmp
        }
        public typealias Element = TreeNode
    }
}
struct LevelOrderTreeNodeSequence:Sequence {
    let node: TreeNode?
    typealias Iterator = LevelOrderIterator
    func makeIterator() -> LevelOrderIterator {
        LevelOrderIterator(node)
    }
    struct LevelOrderIterator: IteratorProtocol {
        internal init(_ root: TreeNode?) {
            self.root = root
            self.queue = Queue()
            root.map {
                queue.enqueue($0)
            }
        }
        typealias Element = TreeNode
        
        let root: TreeNode?
        private(set) var queue = Queue<Element>()
        mutating func next() -> TreeNode? {
            let node = queue.dequeue()
            node?.left.map{queue.enqueue($0)}
            node?.right.map{queue.enqueue($0)}
            return node
        }
    }
}

extension TreeNode {
    func makePreOrderSequence() -> Self {
        self
    }
    func makeInOrderSequence() -> InOrderTreeNodeSequence{
        InOrderTreeNodeSequence(node: self)
    }
    func makePostOrderSequence() -> PostOrderTreeNodeSequence{
        PostOrderTreeNodeSequence(node: self)
    }
    func makeLevelOrderSequence() -> LevelOrderTreeNodeSequence {
        LevelOrderTreeNodeSequence(node: self)
    }
}

import XCTest
final class BinaryTreeIteratorTests: XCTestCase {
    func testForLoopATreeNodeIsPreOrder() throws {
        let root = makeTree()
        var capture:[Int] = []
        for node in root {
            capture.append(node.val)
        }
        XCTAssertEqual(capture, [0,1,2,3,4,5,6])
    }
    func testPreOrderSequence() throws {
        let root = makeTree()
        var capture:[Int] = []
        for node in root.makePreOrderSequence() {
            capture.append(node.val)
        }
        XCTAssertEqual(capture, [0,1,2,3,4,5,6])
    }
    func testInOrderSequence() throws {
        let root = makeTree()
        var capture:[Int] = []
        for node in root.makeInOrderSequence() {
            capture.append(node.val)
        }
        XCTAssertEqual(capture, [2,1,3,0,5,4,6])
    }
    
    func testPostOrderSequence() throws {
        let root = makeTree()
        var capture:[Int] = []
        for node in root.makePostOrderSequence() {
            capture.append(node.val)
        }
        XCTAssertEqual(capture, [2, 3, 1, 5, 6, 4, 0])
    }
    
    func testLevelOrderSequence() throws {
        let root = makeTree()
        var capture:[Int] = []
        for node in root.makeLevelOrderSequence() {
            capture.append(node.val)
        }
        XCTAssertEqual(capture, [0,1,4,2,3,5,6])
    }
    // MARK: - Helper
    private func makeTree() -> TreeNode {
        TreeNode(
            0,
            TreeNode(
                1,
                TreeNode(2),
                TreeNode(3)),
            TreeNode(
                4,
                TreeNode(5),
                TreeNode(6)
            )
        )
    }
}

