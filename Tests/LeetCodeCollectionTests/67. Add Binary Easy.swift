import Foundation
import XCTest
private class Solution {
    func addBinary(_ a: String, _ b: String) -> String {
        var p1:String.Index! = a.endIndex, p2:String.Index! = b.endIndex
        
        var r = String(repeating: " ", count: max(a.count, b.count))
        var rp = r.endIndex
        var c: Int = 0
        while true {
            p1 = p1 == nil || p1 == a.startIndex ? nil : a.index(before: p1)
            p2 = p2 == nil || p2 == b.startIndex ? nil : b.index(before: p2)
            
            if p1 == nil && p2 == nil && c == 0 {
                break
            }
            if let p1 = p1  {c += a[p1] == "1" ? 1 : 0}
            if let p2 = p2  {c += b[p2] == "1" ? 1 : 0}
            if rp == r.startIndex {
                r.insert(contentsOf: "\(c&1)", at: rp)
            } else {
                rp = r.index(before: rp)
                r.set(c & 1 == 1 ? "1" : "0", at: rp)
            }
            c >>= 1
            
        }
        return r
    }
}
final class _67AddBinaryEasyTests: XCTestCase {
    func test() throws {
        XCTAssertEqual(Solution().addBinary("1", "10"), "11")
        XCTAssertEqual(Solution().addBinary("1", "11"), "100")
    }
    func testBig() {
        let i = Decimal(1)
        XCTAssertEqual(i.leftShifting(3), 8)
        XCTAssertEqual(i.leftShifting(100).description, "1267650600228229401496703205376")
        XCTAssertEqual(i.leftShifting(500).description, "3273390607896141870013189696827599152340000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", "where python is  3273390607896141870013189696827599152216642046043064789483291368096133796404674554883270092325904157150886684127560071009217256545885393053328527589376")
    }
}

extension String {
    mutating func `set`(_ newValue: Character, at index: Index) {
            self.replaceSubrange(index...index, with: [newValue])
    }
}

extension Decimal {
    mutating func leftShift(_ n: Int) {
        self *= pow(2, n)
    }
    func leftShifting(_ n: Int) -> Decimal{
        self * pow(2, n)
    }
}
