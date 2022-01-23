/// A PriorityQueue implementation based on a Heap data structure.

struct PriorityQueue<DataType> {
    internal init(_ comparing: @escaping (DataType, DataType) -> Bool) {
        self.queue = []
        self.comparing = comparing
    }
    
    
    /// The backing storage for our queue.
    
    private var queue: Array<DataType>
    private let comparing:(DataType, DataType) -> Bool
    
    public var size: Int {
        return self.queue.count
    }
    public mutating func add(_ item: DataType) {
        self.queue.append(item)
        self.heapifyUp(from: self.queue.count - 1)
    }
    
    public mutating func remove() throws -> DataType? {
        guard self.queue.count > 0 else {
            return nil
        }
        return self.popAndHeapifyDown()
    }
    
    public mutating func dequeue() -> DataType? {
        guard self.queue.count > 0 else {
            return nil
        }
        return self.popAndHeapifyDown()
    }
    
    public mutating func peek() -> DataType? {
        return self.queue.first
    }
    
    public mutating func clear() {
        self.queue.removeAll()
    }
    
    // MARK: - Helper
    
    func leftChild(_ int: Int) -> Int {
        return (2 * int) + 1
    }
    
    func rightChild(_ int: Int) -> Int {
        return (2 * int) + 2
    }
    
    func parent(_ int: Int) -> Int {
        return (int - 1) / 2
    }
    
    private mutating func popAndHeapifyDown() -> DataType {
        
        if self.queue.count == 1 {
            return self.queue.removeFirst()
        }
        
        swap(0, with: queue.count - 1)
        let item = queue.removeLast()
        self.heapifyDown()
        return item
        
    }
    
    
    /// Restores the min heap order of the queue by moving an item towards the beginning of the queue.
    /// - parameter index: The index of the item to move.
    
    private mutating func heapifyUp(from index: Int) {
        var child = index
        var parent = parent(child)
        
        while parent >= 0 && comparing(self.queue[child], self.queue[parent]) {
            swap(parent, with: child)
            child = parent
            parent = self.parent(child)
        }
        
        
    }
    
    /// Restores the min heap order of the queue by moving the root item towards the end of the queue.
    
    private mutating func heapifyDown() {
        var parent = 0
        
        while true {
            let leftChild = leftChild(parent)
            if leftChild >= self.queue.count {
                break
            }
            
            let rightChild = rightChild(parent)
            var minChild = leftChild
            if rightChild < self.queue.count && comparing(self.queue[rightChild], self.queue[minChild]) {
                minChild = rightChild
            }
            
            if  comparing(self.queue[minChild], self.queue[parent]) {
                self.swap(parent, with: minChild)
                parent = minChild
            } else {
                break
            }
        }
        
        
    }
    
    /// Swaps the items located at two different indices in our backing storage.
    /// - parameter firstIndex: The index of the first item to swap.
    /// - parameter secondIndex: The index of the second item to swap.
    
    private mutating func swap(_ firstIndex: Int, with secondIndex: Int) {
        (queue[firstIndex], queue[secondIndex]) = (queue[secondIndex], queue[firstIndex])
    }
}
extension PriorityQueue: CustomStringConvertible {
    var description: String {queue.description}
}


import XCTest

final class PriorityQueueTests: XCTestCase {
    func test() throws {
        var array = [0,1,2,3]
        (array[0], array[1]) = (array[1], array[0])
        XCTAssertEqual(array, [1, 0, 2, 3])
    }
    func testPQueue() throws {
        var sut = PriorityQueue<Int>{ a,b in
            return a>b
        }
//        XCTAssertEqual(sut.dequeue(), nil)
        sut.add(2)
//        XCTAssertEqual(sut.dequeue(), 1)
        sut.add(3)
        sut.add(4)
        sut.add(1)
        sut.add(10)
        XCTAssertEqual(sut.dequeue(), 10)
        XCTAssertEqual(sut.dequeue(), 4)
        XCTAssertEqual(sut.dequeue(), 3)
//        XCTAssertEqual(sut.description, "[4, 2, 3]")
    }
    func testPQueue2() throws {
        var sut = PriorityQueue<Int>{ a,b in
            return a<b
        }
//        XCTAssertEqual(sut.dequeue(), nil)
        sut.add(2)
//        XCTAssertEqual(sut.dequeue(), 1)
        sut.add(3)
        sut.add(4)
        sut.add(1)
        sut.add(10)
        XCTAssertEqual(sut.dequeue(), 1)
        XCTAssertEqual(sut.dequeue(), 2)
        XCTAssertEqual(sut.dequeue(), 3)
//        XCTAssertEqual(sut.description, "[4, 2, 3]")
    }
}
