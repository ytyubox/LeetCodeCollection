import Foundation
import XCTest

class YuHeap {
    
    private(set) var arr:[Element] = []
    typealias Element = Int
    typealias Index = Array<Element>.Index
    /// It returns the root element of Min Heap. Time Complexity of this operation is O(1).
    func getMin() -> Element? {return arr.first}

   
    
    /// Removes the minimum element from MinHeap. Time Complexity of this Operation is O(Logn) as this operation needs to maintain the heap property (by calling heapify()) after removing root.
    func extractMin() -> Element? {
        if arr.isEmpty {return nil}
        swap(0, arr.count - 1)
        let result = arr.removeLast()
        heapify()
        return result
    }

    /// Decreases value of key. The time complexity of this operation is O(Logn). If the decreases key value of a node is greater than the parent of the node, then we don’t need to do anything. Otherwise, we need to traverse up to fix the violated heap property.
    func decreaseKey(from index: Index, to newvalue: Element) {
        arr[index] = newvalue
        heapify()
    }

    /// Inserting a new key takes O(Logn) time. We add a new key at the end of the tree. IF new key is greater than its parent, then we don’t need to do anything. Otherwise, we need to traverse up to fix the violated heap property.
    func insert(_ k: Int) {
        arr.append(k)
        heapify()
    }
    /// Deleting a key also takes O(Logn) time. We replace the key to be deleted with minum infinite by calling decreaseKey(). After decreaseKey(), the minus infinite value must reach root, so we call extractMin() to remove the key.
    func delete(_ key: Element) {
        
    }
    
    private func swap(_ a: Index, _ b: Index) {
        (arr[a], arr[b]) = (arr[b], arr[a])
    }
    fileprivate func heapify() {
        var i = arr.count - 1
        while i != 0, arr[parent(i)] > arr[i] {
            swap(i, parent(i))
            i = parent(i)
        }
    }
}

private func parent(_ index: Int) -> Int {
    (index-1)/2
}
private func `left`(_ index: Int) -> Int {
    2*index+1
}
private func right(_ index: Int) -> Int {
    2*index+2
}

final class ATests: XCTestCase {
    func testCompleteBinaryTreeMath() throws {
        XCTAssertEqual(parent(0), 0)
        XCTAssertEqual(parent(1), 0)
        XCTAssertEqual(parent(2), 0)
        XCTAssertEqual(parent(3), 1)
        XCTAssertEqual(parent(4), 1)
        XCTAssertEqual(left(0), 1)
        XCTAssertEqual(right(0), 2)
        XCTAssertEqual(left(1), 3)
        XCTAssertEqual(right(1), 4)
    }
    func testHeap() throws {
        let sut = YuHeap()
        sut.insert(2)
        XCTAssertEqual(sut.arr, [2])
        sut.insert(3)
        XCTAssertEqual(sut.arr, [2,3])
        sut.insert(1)
        XCTAssertEqual(sut.arr, [1, 3, 2])
        XCTAssertEqual(sut.getMin(), 1)
        XCTAssertEqual(sut.extractMin(), 1)
        XCTAssertEqual(sut.arr, [2, 3])
    }
    
    func testExtractMinOnEmptyHeap() throws {
        let sut = YuHeap()
        XCTAssertEqual(sut.extractMin(), nil)
        
    }
    func testheap() {
        var array:[Int] = []
        
    }
}


func shiftUp(array: inout [Int], index: Int? = nil) {
    var childIndex = index ?? array.count - 1
    var parentIndex = (childIndex - 1) >> 1
    
    while childIndex > 0, array[childIndex] < array[parentIndex] {
        
        childIndex = parentIndex
        parentIndex = (childIndex - 1) >> 1
    }
}
