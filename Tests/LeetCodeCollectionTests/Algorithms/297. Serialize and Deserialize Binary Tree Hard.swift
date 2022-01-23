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

class CodecBFS {
    func serialize(_ root: TreeNode?) -> String {
       
        ""
    }
    
    func deserialize(_ data: String) -> TreeNode? {
        nil
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
