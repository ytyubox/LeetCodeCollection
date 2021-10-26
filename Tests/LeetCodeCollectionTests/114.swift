//
/* 
 *		Created by 游宗諭 in 2021/8/10
 *		
 *		Using Swift 5.0
 *		
 *		Running on macOS 12.0
 */


import Foundation

private class Solution {
    func flatten(_ root: TreeNode?) {
        var stack = [TreeNode]()
        guard let root = root else { return }
        
        stack.append(root)
        var tailNode: TreeNode? = nil
        
        while let curNode = stack.popLast() {
            if let right = curNode.right {
                stack.append(right)
            }
            
            if let left = curNode.left {
                stack.append(left)
                curNode.left = nil
            }
            
            tailNode?.right = curNode
            tailNode = curNode
        }
    }
}
