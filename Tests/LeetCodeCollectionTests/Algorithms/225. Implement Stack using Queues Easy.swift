import XCTest
import DequeModule
private class MyStack {
    var queues: [Deque<Int>] = [
        Deque(),
        Deque(),
    ]
    var i = -1
    init() {
        
    }
    
    func push(_ x: Int) {
        i += 1
        queues[1&i].enqueue(x)
        while let t = queues[1&(i+1)].dequeue() {
            queues[1&i].enqueue(t)
        }
    }
    
    func pop() -> Int {
        queues[i&1].dequeue() ?? 0
    }
    
    func top() -> Int {
        queues[i&1].front ?? 0
    }
    
    func empty() -> Bool {
        queues[i&1].isEmpty
    }
}

final class _225Tests: XCTestCase {
    func test() throws {
        let sut = MyStack()
        sut.push(1)
        sut.push(2)
        print(sut.queues.description, sut.i & 1)
        XCTAssertEqual(sut.pop(), 2)
        print(sut.queues.description, sut.i & 1)
    }
    func test1() throws {
        let sut = MyStack()
        sut.push(1)
        sut.push(2)
        print(sut.queues)
        XCTAssertEqual(sut.top(), 2)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.empty(), false)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.empty(), true)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertEqual(sut.top(), 0)
    }
    func test2() throws {
        let sut = MyStack()
        sut.push(1)
        sut.push(2)
        sut.push(3)
        XCTAssertEqual(sut.top(), 3)
        XCTAssertEqual(sut.pop(), 3)
        XCTAssertEqual(sut.empty(), false)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.empty(), false)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.empty(), true)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertEqual(sut.top(), 0)
    }
}

