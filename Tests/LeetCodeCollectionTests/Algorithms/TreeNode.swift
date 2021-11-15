//public class TreeNode {
//    public var val: Int
//    public var left: TreeNode?
//    public var right: TreeNode?
//    public init() { self.val = 0; self.left = nil; self.right = nil; }
//    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
//    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
//        self.val = val
//        self.left = left
//        self.right = right
//    }
//    public convenience init?(_ arr:[Int?],_ i: Int = 0) {
//        // Base case for recursion
//        if (i < arr.count) {
//            guard let int = arr[i] else {return nil}
//            self.init(int)
//            
//            // insert left child
//            left = TreeNode(arr, 2 * i + 1)
//            
//            // insert right child
//            right = TreeNode(arr, 2 * i + 2)
//        }
//        return nil
//    }
//    func postOrder() -> [Int] {
//        var r:[Int] = []
//        func helper(_ n: TreeNode?) {
//            guard let n = n else {return}
//            helper(n.left)
//            helper(n.right)
//            r.append(n.val)
//        }
//        helper(self)
//        return r
//    }
//}

import XCTest

final class TreeNodeTests: XCTestCase {
    func test() throws {
      
    }
}

