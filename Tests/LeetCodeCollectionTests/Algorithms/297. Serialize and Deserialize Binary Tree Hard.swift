import Foundation
import XCTest

final class _297_SerializeAndDeserializeBinaryTree_Hard_Tests: XCTestCase {
    func test() throws {
        XCTAssertEqual(
            Codec().serialize(
                TreeNode(
                    1,
                    TreeNode(2),
                    TreeNode(
                        3,
                        TreeNode(4),
                        TreeNode(5)))),
            "[1,2,3,null,null,4,5]")
        XCTAssertEqual(
            Codec().serialize(nil),
            "[]")
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
class Codec {
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
