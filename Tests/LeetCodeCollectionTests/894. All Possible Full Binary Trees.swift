//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/10/6.
//

import Foundation

private
class Solution {
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }
    var dp =  [Int: [TreeNode?]]()
    
    func helper(_ N: Int)-> [TreeNode?]{
        if let arrData = dp[N]{ return arrData }
        var result = [TreeNode?]()
        if N == 1{
            let node = TreeNode(0)
            return [node]
        }
        guard N % 2 == 1 else {return []}
        let N = N - 1
        for x in 0 ... N{
            let y = N - x
            for leftTree in self.allPossibleFBT(x) {
                for rightTree in self.allPossibleFBT(y) {
                    let root = TreeNode(0)
                    root.left = leftTree
                    root.right = rightTree
                    result.append(root)
                }
            }
            
        }
        
        dp[N] = result
        
        return dp[N]!
    }

    func allPossibleFBT(_ N: Int) -> [TreeNode?] {
        return helper(N)
    }
}
import XCTest
class _894Test: XCTestCase {
    func test() {
        let soluction = Solution()
        let result = soluction.allPossibleFBT(7)
    }
}

