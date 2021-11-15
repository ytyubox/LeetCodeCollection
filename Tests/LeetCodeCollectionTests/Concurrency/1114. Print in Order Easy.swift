import Foundation
import XCTest
typealias Callable = () -> Void
private class Foo {
    let lockA = NSLock()
    let lockB = NSLock()
    func first(printFirst: Callable) {
        // printFirst() outputs "first". Do not change or remove this line.
        printFirst()
        
    }
    
    func second(printSecond: Callable) {
        
        // # printSecond() outputs "second". Do not change or remove this line.
        printSecond()
    }
    
    func third(printThird: Callable)  {
        
        // # printThird() outputs "third". Do not change or remove this line.
        printThird()
    }
}

final class _1114PrintInOrderEasyTests: XCTestCase {
    func test() throws {
        let sut = Foo()
        var history:[String] = []
        let threadA = Thread {
            sut.first {
                history.append("first")
            }
        }
        let threadB = Thread {
            sut.second {
                history.append("second")
            }
        }
        let threadC = Thread {
            sut.third {
                history.append("third")
            }
        }
        for thread in [threadA, threadB, threadC].shuffled() {
            thread.start()
        }
        usleep(1000)
//        XCTAssertEqual(history, ["first", "second", "third"])
    }
}

