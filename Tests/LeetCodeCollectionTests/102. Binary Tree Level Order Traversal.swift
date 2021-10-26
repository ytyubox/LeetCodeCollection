import Foundation
import XCTest

private class Solution {
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result:[[Int]] = []
        func calculateLevels(_ node: TreeNode?, _ depth: Int) {
            guard let node = node else {
                return
            }
            
            if depth == result.count {
                result.append([])
            }
            result[depth].append(node.val)
            
            calculateLevels(node.left, depth+1)
            calculateLevels(node.right, depth+1)
            
        }
        calculateLevels(root, 0)
        return result
    }
}
final class _102BinaryTreeLevelOrderTraversalTests: XCTestCase {
    func test() throws {
//        [3,9,20,nil,nil,15,7]
        XCTAssertEqual(Solution().levelOrder(
            TreeNode(3,
                     TreeNode(9),
                     TreeNode(20,
                              TreeNode(15),
                              TreeNode(7)))
        ),
                       [[3],[9,20],[15,7]])
        XCTAssertEqual(Solution().levelOrder(TreeNode(1)), [[1]])
        XCTAssertEqual(Solution().levelOrder(nil), [])
    }
}

