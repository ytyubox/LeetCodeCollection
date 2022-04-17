
import XCTest
import DequeModule

typealias Queue = Deque
extension Queue {
    mutating func enqueue(_ val: Element) {
        append(val)
    }
    mutating func dequeue() -> Element? {
        self.popFirst()
    }
    var front: Element? { first }
}
final class QueueTests: XCTestCase {
    func test() throws {
    }
}


extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}
