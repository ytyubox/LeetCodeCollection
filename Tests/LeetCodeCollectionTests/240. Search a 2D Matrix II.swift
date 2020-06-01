private class Solution {
    init(approchNumber:Int) {
        self.approchNumber = approchNumber
    }
    var approchNumber:Int
    private lazy var  doer:[([[Int]],Int)->Bool] = [
        searchMatrix_Greedy,
        searchMatrix_DivideAndConquer,
        searchMatrix_SearchSpaceReduction
    ]
    var searchMatrix: ([[Int]],Int)->Bool {
        let n = approchNumber
        return doer[n]
    }
    
    func searchMatrix_Greedy(_ matrix: [[Int]], _ target: Int) -> Bool {
        for layer in matrix {
            for j in layer {
                if j == target {return true}
            }
        }
        return false
    }
    
    func searchMatrix_DivideAndConquer (
        _ matrix: [[Int]],
        _ target: Int
    ) -> Bool {
        if matrix.count == 0 {return false}
        if matrix.first?.contains(target) ?? false {return true}
        let nextArray = Array(matrix[1...])
        return searchMatrix_DivideAndConquer(nextArray, target)
    }
    func searchMatrix_SearchSpaceReduction (
        _ matrix: [[Int]],
        _ target: Int
    ) -> Bool {
        var row = matrix.count - 1
        var col = 0
        
        while true {
            if row < 0 || col == matrix[0].count {break}
            let now = matrix[row][col]
            if now == target {
                return true
            }
            if now > target {
                row -= 1
                continue
            }
            if now < target {
                col += 1
            }
        }
        return false
    }
}


import XCTest
/**
 Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:
 
 Integers in each row are sorted in ascending from left to right.
 Integers in each column are sorted in ascending from top to bottom.
 Example:
 
 Consider the following matrix:
 
 [
 [1,   4,  7, 11, 15],
 [2,   5,  8, 12, 19],
 [3,   6,  9, 16, 22],
 [10, 13, 14, 17, 24],
 [18, 21, 23, 26, 30]
 ]
 Given target = 5, return true.
 
 Given target = 20, return false.
 */
class _240Searcha2DMatrixII:XCTestCase {
    func testExampleCase() {
        let solution = Solution(approchNumber: 2)
        let matrix =  [
            [1,   4,  7, 11, 15],
            [2,   5,  8, 12, 19],
            [3,   6,  9, 16, 22],
            [10, 13, 14, 17, 24],
            [18, 21, 23, 26, 30]
        ]
        
        let output = solution.searchMatrix(matrix, 5)
        XCTAssertTrue(output)
    }
    func testExampleCase1() {
        let solution = Solution(approchNumber: 1)
        let matrix =  [
            [1,   4,  7, 11, 15],
            [2,   5,  8, 12, 19],
            [3,   6,  9, 16, 22],
            [10, 13, 14, 17, 24],
            [18, 21, 23, 26, 30]
        ]
        
        let output = solution.searchMatrix(matrix, 5)
        XCTAssertTrue(output)
    }
    func testExampleCase2() {
        let solution = Solution(approchNumber: 2)
        let matrix =  [
            [1,   4,  7, 11, 15],
            [2,   5,  8, 12, 19],
            [3,   6,  9, 16, 22],
            [10, 13, 14, 17, 24],
            [18, 21, 23, 26, 30]
        ]
        
        let output = solution.searchMatrix(matrix, 5)
        XCTAssertTrue(output)
    }
}
