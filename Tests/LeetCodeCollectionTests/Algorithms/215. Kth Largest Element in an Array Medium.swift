import Foundation
import CoreFoundation
private class Solution_Selection {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        func quickSelect(_ start:Int, _ end:Int, _ k:Int) -> Int{
            if (start == end) { return nums[start] }
            let p = partition(start, end)
            if p == k { return nums[p] }
            if k < p{ return quickSelect(start, p-1, k) }
            return quickSelect(p+1, end, k)
        }
        
        func partition(_ start:Int, _ end:Int)->Int{
            let randomIndex = Int.random(in: start...end)
            swap(start, randomIndex)
            var left = start
            for i in start+1...end{
                if nums[i] < nums[start] {
                    left += 1
                    swap(left, i)
                }
            }
            swap(start, left)
            return left
        }
        
        func swap(_ i:Int, _ j:Int){
            (nums[i], nums[j]) = (nums[j], nums[i])
        }
        
        return quickSelect(0, nums.count-1, nums.count-k)
    }
}

private class Solution_Heap {
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        var heap:[Int] = []
        
        func heapify(index: Int) {
            if index == 0 {return}
            let p = (index-1)>>1
            if heap[index] > heap[p] {return}
            (heap[index], heap[p]) = (heap[p], heap[index])
            heapify(index: p)
        }
        func dequeue() {
            (heap[0], heap[heap.count - 1]) = (heap[heap.count - 1], heap[0])
            heap.removeLast()
            
            func heapdown(index: Int) {
                var maxIndex = index
                if heap.indices.contains(2*index+1), heap[2*index+1] < heap[maxIndex] {
                    maxIndex = 2*index+1
                }
                if heap.indices.contains(2*index+2), heap[2*index+2] < heap[maxIndex] {
                    maxIndex = 2*index+2
                }
                if maxIndex == index {return}
                (heap[maxIndex], heap[index]) = (heap[index], heap[maxIndex])
                heapdown(index: maxIndex)
            }
            heapdown(index: 0)
        }
        
        for n in nums {
            heap.append(n)
            heapify(index: heap.count - 1)
            let cp = heap
            if heap.count > k {
                dequeue()
            }
            print(cp, heap)
        }
        return heap.first ?? 0
    }
}

import XCTest

final class _215Tests: XCTestCase {
    func test() throws {
        XCTAssertEqual(Solution_Selection().findKthLargest([3,2,1,5,6,4], 2), 5)
        XCTAssertEqual(Solution_Selection().findKthLargest([3,2,3,1,2,4,5,5,6], 4), 4)
    }
    func testHeap() throws {
        XCTAssertEqual(Solution_Heap().findKthLargest([3,2,1,5,6,4], 2), 5)
        XCTAssertEqual(Solution_Heap().findKthLargest([3,2,3,1,2,4,5,5,6], 4), 4)
    }
    
}


struct MinHeap {

    private let heap:CFBinaryHeap  = {
        var callbacks = CFBinaryHeapCallBacks()
        callbacks.compare = {  lPtr, rPtr, _ in
            let lhs = lPtr!.load(as: Int.self)
            let rhs = rPtr!.load(as: Int.self)
            let n = lhs - rhs
            return  .init(rawValue:(-n>>Int.bitWidth)-(n>>Int.bitWidth))!
        }
        return CFBinaryHeapCreate(nil, 0, &callbacks, nil)
    }()
    func add(_ num: Int) {
        let pointer = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        pointer.initialize(to: num)
        CFBinaryHeapAddValue(heap, pointer)
    }
    func removeMin() {
        CFBinaryHeapRemoveMinimumValue(heap)
    }
    func peak() -> Int? {
        CFBinaryHeapGetMinimum(heap)?.load(as: Int.self)
    }
}
struct MaxHeap {

    private let heap:CFBinaryHeap  = {
        var callbacks = CFBinaryHeapCallBacks()
        callbacks.compare = {  lPtr, rPtr, _ in
            let lhs = lPtr!.load(as: Int.self)
            let rhs = rPtr!.load(as: Int.self)
            let n = lhs - rhs
            return .init(rawValue:(n>>Int.bitWidth)-(-n>>Int.bitWidth))!
        }
        return CFBinaryHeapCreate(nil, 0, &callbacks, nil)
    }()
    func add(_ num: Int) {
        let pointer = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        pointer.initialize(to: num)
        CFBinaryHeapAddValue(heap, pointer)
    }
    func removeMin() {
        CFBinaryHeapRemoveMinimumValue(heap)
    }
    func peak() -> Int? {
        CFBinaryHeapGetMinimum(heap)?.load(as: Int.self)
    }
    
}


import XCTest

final class MinHeapTests: XCTestCase {
    func test() throws {
        XCTAssertEqual( CFComparisonResult(rawValue: 0), .compareEqualTo)
        XCTAssertEqual( CFComparisonResult(rawValue: -1), .compareLessThan)
        XCTAssertEqual( CFComparisonResult(rawValue: 1), .compareGreaterThan)
        XCTAssertEqual(get(0 - 1), .compareLessThan)
        XCTAssertEqual(get(0 - 1), 0)
        XCTAssertEqual(get(1 - 1 ), .compareEqualTo)
        XCTAssertEqual(get(2 - 1), .compareGreaterThan)
        XCTAssertEqual(get(1 - 5 ), .compareLessThan)
        XCTAssertEqual(get(5 - 1), .compareGreaterThan)
        XCTAssertEqual(get(0 - 1), 0)
        XCTAssertEqual(get(1 - 1), 1)
        XCTAssertEqual(get(2 - 1), 2)
        XCTAssertEqual(getrev(0 - 1), 2)
        XCTAssertEqual(getrev(1 - 1), 1)
        XCTAssertEqual(getrev(2 - 1), 0)
    }
    func testMinHeap() throws {
        let heap = MinHeap()
        XCTAssertEqual(heap.peak(), nil)
        heap.add(1)
        XCTAssertEqual(heap.peak(), 1)
        heap.add(2)
        XCTAssertEqual(heap.peak(), 2)
        heap.add(3)
        XCTAssertEqual(heap.peak(), 3)
        heap.removeMin()
        XCTAssertEqual(heap.peak(), 2)
        heap.removeMin()
        XCTAssertEqual(heap.peak(), 1)
        heap.add(-1)
        XCTAssertEqual(heap.peak(), 1)
    }
    func testMaxHeap() throws {
        let heap = MaxHeap()
        XCTAssertEqual(heap.peak(), nil)
        heap.add(1)
        XCTAssertEqual(heap.peak(), 1)
        heap.add(2)
        XCTAssertEqual(heap.peak(), 1)
        heap.add(3)
        XCTAssertEqual(heap.peak(), 1)
        heap.removeMin()
        XCTAssertEqual(heap.peak(), 2)
        heap.removeMin()
        XCTAssertEqual(heap.peak(), 3)
        heap.add(-1)
        XCTAssertEqual(heap.peak(), -1)
    }
}

func get(_ n: Int) -> CFComparisonResult {
    [
        CFComparisonResult.compareLessThan,
        .compareEqualTo,
        .compareGreaterThan
    ][1+(n>>31)-(-n>>31)]
}

func get(_ n: Int) -> Int {
    1+(n>>Int.bitWidth)-(-n>>Int.bitWidth)
}

func getrev(_ n: Int) -> Int {
    1-(n>>Int.bitWidth)+(-n>>Int.bitWidth)
}
