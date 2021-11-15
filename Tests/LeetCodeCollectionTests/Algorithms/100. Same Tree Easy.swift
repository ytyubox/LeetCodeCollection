import Foundation
import XCTest
private class Solution {
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        guard let p = p, let q = q else {return p === q}
        if p.val != q.val {return false}
        return isSameTree(p.left, q.left) && isSameTree(p.right, q.right)
    }
    func make<T>(_ x: T) -> AnySequence<T> {
        AnySequence {
            CollectionOfOne.Iterator(_elements: x)
        }
    }
}
