/*
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 !!!Code originally from /http://www.openasthra.com/c-tidbits/printing-binary-trees-in-ascii/
 !!! Just saved it, cause the website is down.
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 Printing Binary Trees in Ascii
 
 Here we are not going to discuss what binary trees are (please refer this, if you are looking for binary search trees), or their operations but printing them in ascii.
 
 The below routine prints tree in ascii for a given Tree representation which contains list of nodes, and node structure is this
 
 struct Tree
 {
 Tree * left, * right;
 int element;
 };
 
 This pic illustrates what the below routine does on canvas..
 ascii tree
 
 Here is the printing routine..
 
 b5855d39a6b8a2735ddcaa04a404c125001
 
 Auxiliary routines..
 */
let gap = 3;
let MAX_HEIGHT = 1000;
class TreeToASCII {
    var lprofile = Array.init(repeating: -1, count: MAX_HEIGHT)
    var rprofile = Array.init(repeating: -1, count: MAX_HEIGHT)
    var printNext = 0
    func ToASCII(_ root: TreeNode?) {
        let root = build_ascii_tree(root)!
        compute_edge_lengths(root)
        for i in 0 ..< min(root.height, MAX_HEIGHT) {
            lprofile[i] = .max
        }
        compute_lprofile(root, 0, 0);

        var minimumX = 0;

        for  i in 0 ..< min(root.height, MAX_HEIGHT){
          minimumX = min(minimumX, lprofile[i]);
        }

        for i in 0 ..< root.height {
          printNext = 0;
          print_level(root, -minimumX, i);
          print("\n")
        }
    }
    //This function prints the given level of the given tree, assuming
    //that the node has the given x cordinate.
    func print_level(_ node:asciinode?,_ x: Int,_ level: Int)
    {
        let isleft: Bool
        var print_next = 0
        guard let node = node else {return}
        isleft = node.parent_dir == -1
        if (level == 0)
        {
            let length = (x-print_next-((node.lablen-(isleft ? 1 : 0))/2))
            for _ in 0..<length {
                print(" ")
            }
            print_next += length
            print(node.label);
            print_next += node.lablen;
        }
        else if (node.edge_length >= level)
        {
            if node.left != nil
            {
                let length = (x-print_next-(level))
                for _ in 0..<length {
                    print(" ");
                }
                print_next += length
                print("/");
                print_next+=1
            }
            if (node.right) != nil
            {
                let length = (x-print_next+(level))
                for _ in 0..<level
                {
                    print(" ");
                }
                print_next += length;
                print("\\")
                print_next += 1;
            }
        }
        else
        {
            print_level(node.left,
                        x-node.edge_length-1,
                        level-node.edge_length-1);
            print_level(node.right,
                        x+node.edge_length+1,
                        level-node.edge_length-1);
        }
    }
    
    
    //This function fills in the edge_length and
    //height fields of the specified tree
    func compute_edge_lengths(_ node: asciinode?)
    {
        var h, hmin, delta: Int
        guard let node = node else  {return}
        compute_edge_lengths(node.left);
        compute_edge_lengths(node.right);
        
        /* first fill in the edge_length of node */
        if (node.right == nil && node.left == nil)
        {
            node.edge_length = 0;
        }
        else
        {
            if let left = node.left
            {
                
                for i in 0..<min(left.height, MAX_HEIGHT)
                {
                    rprofile[i] = .min;
                }
                compute_rprofile(left, 0, 0);
                hmin = left.height;
            }
            else
            {
                hmin = 0;
            }
            if let right = node.right
            {
                for i in 0..<min(right.height, MAX_HEIGHT)
                {
                    lprofile[i] = .max
                }
                compute_lprofile(right, 0, 0);
                hmin = min(right.height, hmin);
            }
            else
            {
                hmin = 0;
            }
            delta = 4;
            for i in 0..<hmin
            {
                delta = max(delta, gap + 1 + rprofile[i] - lprofile[i]);
            }
            
            //If the node has two children of height 1, then we allow the
            //two leaves to be within 1, instead of 2
            if (((node.left != nil && node.left!.height == 1) ||
                 (node.right != nil && node.right!.height == 1))&&delta>4)
            {
                delta -= 1
            }
            
            node.edge_length = ((delta+1)/2) - 1;
        }
        
        //now fill in the height of node
        h = 1;
        if (node.left != nil)
        {
            h = max(node.left!.height + node.edge_length + 1, h);
        }
        if (node.right != nil)
        {
            h = max(node.right!.height + node.edge_length + 1, h);
        }
        node.height = h;
    }
    
    func build_ascii_tree_recursive(_ t:TreeNode?) -> asciinode?
    {
        
        guard let t = t else {return nil}
        
        let node: asciinode = .init(left: nil, right: nil, edge_length: 0, height: 0, lablen: 0, parent_dir: 0, label: "")
        node.left = build_ascii_tree_recursive(t.left);
        node.right = build_ascii_tree_recursive(t.right);
        
        if (node.left != nil)
        {
            node.left!.parent_dir = -1;
        }
        
        if (node.right != nil)
        {
            node.right!.parent_dir = 1;
        }
        
        node.label = t.val.description
        node.lablen = node.label.count
        
        return node;
    }
    
    
    //Copy the tree into the ascii node structre
    func build_ascii_tree(_ t: TreeNode?) -> asciinode?
    {
        if (t == nil) {return nil}
        let node = build_ascii_tree_recursive(t);
        node?.parent_dir = 0;
        return node
    }
    
    //The following function fills in the lprofile array for the given tree.
    //It assumes that the center of the label of the root of this tree
    //is located at a position (x,y).  It assumes that the edge_length
    //fields have been computed for this tree.
    func compute_lprofile(_ node: asciinode?,_ x: Int,_ y: Int)
    {
        guard let node = node else {return}
        let isleft = (node.parent_dir == -1);
        lprofile[y] = min(lprofile[y], x-((node.lablen-( isleft ? 1 : 0))/2));
        if (node.left != nil)
        {
            var i = 1
            while i <= node.edge_length && y+i < MAX_HEIGHT
            {
                lprofile[y+i] = min(lprofile[y+i], x-i);
                i += 1
            }
        }
        compute_lprofile(node.left, x-node.edge_length-1, y+node.edge_length+1);
        compute_lprofile(node.right, x+node.edge_length+1, y+node.edge_length+1);
    }
    
    func compute_rprofile(_ node: asciinode?, _ x:Int, _ y: Int)
    {
        guard let node = node else {return};
        let notleft = (node.parent_dir != -1);
        rprofile[y] = max(rprofile[y], x+((node.lablen-(notleft ? 1 : 0))/2));
        if (node.right != nil)
        {
            var i = 1
            while i <= node.edge_length && y+i < MAX_HEIGHT
            {
                rprofile[y+i] = max(rprofile[y+i], x+i);
                i += 1
            }
        }
        compute_rprofile(node.left, x-node.edge_length-1, y+node.edge_length+1);
        compute_rprofile(node.right, x+node.edge_length+1, y+node.edge_length+1);
    }
    func print(_ char: String) {
        Swift.print(char, terminator: "")
    }
}
// Here is the asciii tree structure…
class asciinode
{
    internal init(left: asciinode?, right: asciinode?, edge_length: Int, height: Int, lablen: Int, parent_dir: Int, label: String) {
        self.left = left
        self.right = right
        self.edge_length = edge_length
        self.height = height
        self.lablen = lablen
        self.parent_dir = parent_dir
        self.label = label
    }
    
    var left, right: asciinode?
    
    //length of the edge from this node to its children
    var edge_length, height,lablen, parent_dir: Int
    
    //max supported unit32 in dec, 10 digits max
    var label:String
}

import XCTest

final class TreeToASCIITests: XCTestCase {
    func test() throws {
        let root = TreeNode(
            1,
            TreeNode(2),
            TreeNode(
                3,
                TreeNode(4,
                         TreeNode(6),
                         TreeNode(7)),
                TreeNode(5)))
        let sut = TreeToASCII()
        sut.ToASCII(root)
    }
}
