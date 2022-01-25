import Foundation
import XCTest

final class _297_SerializeAndDeserializeBinaryTree_Hard_Tests: XCTestCase {
    func test() throws {
        XCTAssertEqual(
            Codec2Level().serialize(
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4,
                                 TreeNode(6),
                                 TreeNode(7)),
                        TreeNode(5)))),
            "[1,2,3,null,null,4,5,null,null,null,null,6,7,null,null]")
        XCTAssertEqual(
            Codec2Level().serialize(nil),
            "[]")
    }
    func testCodecInorder() throws {
        
        XCTAssertEqual(
            Codec().serialize(nil),
            "#")
        XCTAssertEqual(Codec().deserialize("#"), nil)
        XCTAssertEqual(
            Codec().serialize(
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4,
                                 TreeNode(6),
                                 TreeNode(7)),
                        TreeNode(5)))),
            "1,2,##3,4,6,##7,##5,##")
        XCTAssertEqual(
            Codec().deserialize("1,2,##3,4,6,##7,##5,##"),
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4,
                                 TreeNode(6),
                                 TreeNode(7)),
                        TreeNode(5))))
    }
    func testCodecBFS() throws {
        typealias SUT = CodecBFS
        XCTAssertEqual(
            SUT().serialize(nil),
            "")
        XCTAssertEqual(SUT().deserialize(""), nil)
        XCTAssertEqual(
            SUT().serialize(
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4,
                                 TreeNode(6),
                                 TreeNode(7)),
                        TreeNode(5)))),
            "1,2,3,#,#,4,5,6,7,#,#,#,#,#,#")
        XCTAssertEqual(
            SUT().deserialize("1,2,3,#,#,4,5,6,7"),
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4,
                                 TreeNode(6),
                                 TreeNode(7)),
                        TreeNode(5))))
    }
    func testCodecLeetCode() throws {
        typealias SUT = CodecLeetcode
        XCTAssertEqual(SUT().serialize(nil), "[]")
        XCTAssertEqual(SUT().deserialize("[]"), nil)
        XCTAssertEqual(
            SUT().serialize(
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4,
                                 TreeNode(6),
                                 TreeNode(7)),
                        TreeNode(5)))),
            "[1,2,3,#,#,4,5,6,7]")
        XCTAssertEqual(
            SUT().deserialize("[1,2,3,#,#,4,5,6,7]"),
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4,
                                 TreeNode(6),
                                 TreeNode(7)),
                        TreeNode(5))))
    }
}

/// DBS
class Codec {
    func serialize(_ root: TreeNode?) -> String {
       
        var r:String = ""
        
        func helper(_ node: TreeNode?) {
            guard let node = node else {
                r.append("#")
                return
            }
            r.append(node.val.description+",")
            helper(node.left)
            helper(node.right)
        }
        helper(root)
        return r
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        var it = data.makeIterator()
        
        func helper() -> TreeNode? {
            var next = it.next()
            if next == nil {return nil}
            if next == "#" {return nil}
            var value = ""
            while next != ",", let _next = next {
                value += _next.description
                next = it.next()
            }
            guard let val = Int(value) else {return nil}
            let node = TreeNode(val)
            node.left = helper()
            node.right = helper()
            return node
        }
        
        return helper()
    }
}
class CodecLeetcode {
    func serialize(_ root: TreeNode?) -> String {
       
        guard let root = root else {
            return "[]"
        }

        var queue = Queue<TreeNode?>([root])
        var r:[String] = []
        while true {
            if queue.isEmpty {break}
            if let node = queue.dequeue()! {
                queue.enqueue(node.left)
                queue.enqueue(node.right)
                r.append(node.val.description)
            } else {
                r.append("#")
            }
            
        }
        
        return "[" + r.trim(where: {$0 != "#"}).joined(separator: ",") + "]"
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        
        let data = data.trimmingCharacters(in: .init(charactersIn: "[]"))
        
        if data.isEmpty {return nil}
        let nodes = data.split(separator: ",")
        let root = TreeNode(Int(nodes[0])!)
        var queue = Queue([root])
        var index = 1
        while true {
            guard let node = queue.dequeue(), nodes.indices.contains(index) else {break}
            if nodes[index] != "#" {
                let left = TreeNode(Int(nodes[index])!)
                queue.enqueue(left)
                node.left = left
            }
            index += 1
            if nodes[index] != "#" {
                let right = TreeNode(Int(nodes[index])!)
                queue.enqueue(right)
                node.right = right
            }
            index += 1
        }
        return root
    }
}
class CodecBFS {
    func serialize(_ root: TreeNode?) -> String {
        guard let root = root else {
            return ""
        }

        var queue = Queue<TreeNode?>([root])
        var r:[String] = []
        while true {
            if queue.isEmpty {break}
            if let node = queue.dequeue()! {
                queue.enqueue(node.left)
                queue.enqueue(node.right)
                r.append(node.val.description)
            } else {
                r.append("#")
            }
            
        }
        return r.joined(separator: ",")
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        if data.isEmpty {return nil}
        let nodes = data.split(separator: ",")
        let root = TreeNode(Int(nodes[0])!)
        var queue = Queue([root])
        var index = 1
        while true {
            guard let node = queue.dequeue(), nodes.indices.contains(index) else {break}
            if nodes[index] != "#" {
                let left = TreeNode(Int(nodes[index])!)
                queue.enqueue(left)
                node.left = left
            }
            index += 1
            if nodes[index] != "#" {
                let right = TreeNode(Int(nodes[index])!)
                queue.enqueue(right)
                node.right = right
            }
            index += 1
        }
        return root
    }
}
/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.left = nil
 *         self.right = nil
 *     }
 * }
 */

private let COMMA = ","
private let NULL = "null"
class Codec2Level {
    func serialize(_ root: TreeNode?) -> String {
        var levels:[Level] = [
            Level(root),
            Level(nil)
        ]
        
        var currentLevel = 0
        var r: [String] = []
        while true {
            let level = levels[currentLevel&1]
            guard level.hasAny else {break}
            currentLevel += 1
            levels[currentLevel&1].removeAll()
            for node in level.nodes {
                r.append(node?.val.description ?? NULL)
                levels[currentLevel&1].append(node?.left)
                levels[currentLevel&1].append(node?.right)
            }
        }
        return "[\(r.joined(separator: COMMA))]"
        
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        print(data)
        return nil
    }
}

struct Level {
    internal init(_ node: TreeNode?) {
        self.nodes = [node]
        self.hasAny = node != nil
    }
    
    var hasAny: Bool = false
    private(set) var nodes: [TreeNode?] = []
    mutating func append(_ node: TreeNode?) {
        if node != nil {
            hasAny = true
        }
        nodes.append(node)
    }
    mutating func removeAll() {
        hasAny = false
        nodes.removeAll(keepingCapacity: true)
    }
    
}

import XCTest

final class ArrayTrimTests: XCTestCase {
    func test() throws {
        XCTAssertEqual([5,4,3,4,5].trim(where: { $0 < 4}),
                       [3])
        XCTAssertEqual([5,4,4,5].trim(where: { $0 < 4}),
                       [])
        XCTAssertEqual([5].trim(where: { $0 < 4}), [])
        XCTAssertEqual([].trim(where: { $0 < 4}), [])
        
    }
}

extension Array {
    func trim(where comparer: (Element) -> Bool) -> SubSequence {
        var up = 0
        var low = 0
        for i in indices {
            if comparer(self[i]) {
                low = i
                break
            }
        }
        for i in indices.reversed() {
            if comparer(self[i]) {
                up = i + 1
                break
            }
        }
        return self[low..<up]
    }
}
