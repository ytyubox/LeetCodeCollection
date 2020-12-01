//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/9/23.
//

import Foundation
/**
 Let's play the minesweeper game (Wikipedia, online game)!
 
 You are given a 2D char matrix representing the game board. 'M' represents an unrevealed mine, 'E' represents an unrevealed empty square, 'B' represents a revealed blank square that has no adjacent (above, below, left, right, and all 4 diagonals) mines, digit ('1' to '8') represents how many mines are adjacent to this revealed square, and finally 'X' represents a revealed mine.
 
 Now given the next click position (row and column indices) among all the unrevealed squares ('M' or 'E'), return the board after revealing this position according to the following rules:
 
 If a mine ('M') is revealed, then the game is over - change it to 'X'.
 If an empty square ('E') with no adjacent mines is revealed, then change it to revealed blank ('B') and all of its adjacent unrevealed squares should be revealed recursively.
 If an empty square ('E') with at least one adjacent mine is revealed, then change it to a digit ('1' to '8') representing the number of adjacent mines.
 Return the board when no more squares will be revealed.
 
 Input:
 
 [['E', 'E', 'E', 'E', 'E'],
 ['E', 'E', 'M', 'E', 'E'],
 ['E', 'E', 'E', 'E', 'E'],
 ['E', 'E', 'E', 'E', 'E']]
 
 Click : [3,0]
 
 Output:
 
 [['B', '1', 'E', '1', 'B'],
 ['B', '1', 'M', '1', 'B'],
 ['B', '1', '1', '1', 'B'],
 ['B', 'B', 'B', 'B', 'B']]
 
 Example 2:
 
 Input:
 
 [['B', '1', 'E', '1', 'B'],
 ['B', '1', 'M', '1', 'B'],
 ['B', '1', '1', '1', 'B'],
 ['B', 'B', 'B', 'B', 'B']]
 
 Click : [1,2]
 
 Output:
 
 [['B', '1', 'E', '1', 'B'],
 ['B', '1', 'X', '1', 'B'],
 ['B', '1', '1', '1', 'B'],
 ['B', 'B', 'B', 'B', 'B']]
 
 
 Note:
 
 1. The range of the input matrix's height and width is [1,50].
 2. The click position will only be an unrevealed square ('M' or 'E'), which also means the input board contains at least one clickable square.
 3. The input board won't be a stage when game is over (some mines have been revealed).
 4. For simplicity, not mentioned rules should be ignored in this problem. For example, you don't need to reveal all the unrevealed mines when the game is over, consider any cases that you will win the game or flag any squares.
 */


private class Solution {
    private let m:Character = "M"
    private let b:Character = "B"
    private let e:Character = "E"
    private let x:Character = "X"
    
    func updateBoard(_ board: [[Character]], _ click: [Int]) -> [[Character]] {
        let h = board.count
        let w = board[0].count
        var copied = board
        
        func For2DEach(_ x:Int,_ y: Int,_ then:(Int,Int)->Void) {
            let xRange = max(0,x-1)...min(h-1,x+1)
            let yRange = max(0,y-1)...min(w-1,y+1)
            for i in xRange {
                for j in yRange {
                    if i==x, j==y { continue }
                    then(i,j)
                }
            }
        }
        func checkBombCount(_ x: Int, _ y: Int) -> Int {
            var numberOfBombs = 0
            For2DEach(x, y) {
                if copied[$0][$1] == m { numberOfBombs += 1 }
            }
            return numberOfBombs
        }
        
        func checkAdjacentPoints(_ x: Int,_  y: Int) {
            
            let numberOfpoiBombs = checkBombCount(x, y)
            
            if numberOfpoiBombs == 0 {
                copied[x][y] = b
                For2DEach(x, y) {
                    if copied[$0][$1] == e { checkAdjacentPoints($0, $1) }
                }
                
            } else {
                copied[x][y] = Character("\(numberOfpoiBombs)")
            }
        }
        let (x,y) = (click[0],click[1])
        if copied[x][y] == m {
            copied[x][y] = self.x
        } else {
            checkAdjacentPoints(x, y)
        }
        
        return copied
    }
}

import XCTest
class MinesweeperTests:XCTestCase {
    private let solution = Solution()
    let board:[[Character]] =
        [["E", "E", "E", "E", "E"],
         ["E", "E", "M", "E", "E"],
         ["E", "E", "E", "E", "E"],
         ["E", "E", "E", "E", "E"]]
    func testSafe() {
        let click =  [3,0]
        let result = solution.updateBoard(board, click)
        let expect:[[Character]] = [
            ["B", "1", "E", "1", "B"],
            ["B", "1", "M", "1", "B"],
            ["B", "1", "1", "1", "B"],
            ["B", "B", "B", "B", "B"]]
        XCTAssertEqual(expect, result)
    }
    func testgameLost() {
        var board = self.board
        var click =  [3,0]
        board = solution.updateBoard(board, click)
        click = [1,2]
        let result = solution.updateBoard(board, click)
        let expect:[[Character]] = [
            ["B", "1", "E", "1", "B"],
            ["B", "1", "X", "1", "B"],
            ["B", "1", "1", "1", "B"],
            ["B", "B", "B", "B", "B"]]
        XCTAssertEqual(expect, result)
    }
}
