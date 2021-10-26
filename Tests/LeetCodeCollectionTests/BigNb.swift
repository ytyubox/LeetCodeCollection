import Foundation
import XCTest
struct BigNb: Equatable {
    internal init(_ container: [UInt8] = []) {
        self.container = container
    }
    
    typealias IntegerLiteralType = Int
    
    var container:[UInt8] = []
}
extension BigNb: ExpressibleByIntegerLiteral {
    init(_ value: Int) {
        self.init(integerLiteral: value)
    }
    init(integerLiteral value: Int) {
        var value = value
        container = []
        while true {
            if value == 0 {
                break
            }
            container.append(UInt8(value & 0xff))
            value >>= 8
        }
    }
    
}
extension BigNb: ExpressibleByStringLiteral {
    typealias StringLiteralType = String
    /// Only Hex from left to right, 255 == ff, (without 0x)
    init(stringLiteral s: StringLiteralType) {
        container = s._hexa.reversed()
    }
}
extension BigNb: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: String...) {
        container = elements.compactMap(\.hexaBytes.first)
    }
    
    typealias ArrayLiteralElement = String
}
extension BigNb: CustomStringConvertible {
    var description: String {
        container.reversed().map(\.hex).joined()
    }
}

extension BigNb: AdditiveArithmetic {
    static func - (lhs: BigNb, rhs: BigNb) -> BigNb {
        lhs
    }
    
    static func + (lhs: BigNb, rhs: BigNb) -> BigNb {
        let a = lhs, b = rhs
        var container:[UInt8] = []
        var p1 = 0, p2 = 0, carry:UInt8 = 0
        while true {
            if p1 >= a.container.count &&
                p2 >= b.container.count &&
                carry == 0 {break}
            
            let i = p1 < a.container.count ? a.container[p1] : 0
            let j = p2 < b.container.count ? b.container[p2] : 0
            let (added, overflow) = andAdd(i, j)
            container.append(added + carry)
            carry = overflow ? 1 : 0
            p1 += 1
            p2 += 1
        }
        
        return BigNb(container)
    }
}


final class BigNbTests: XCTestCase {
    func test() throws {
        XCTAssertEqual(BigNb(Int.max),
                       ["FF", "FF", "FF", "FF", "FF", "FF", "FF", "7F"])
        XCTAssertEqual(BigNb(255).container.map(\.hex),
                       ["FF"])
        XCTAssertEqual(BigNb(255 << 8).container.map(\.hex),
                       ["00", "FF"])
        XCTAssertEqual(BigNb((255 << 8) | 0xff ).container.map(\.hex),
                       ["FF", "FF"])
    }
    func testFromString() throws {
        XCTAssertEqual(BigNb("FF").container.map(\.hex),
                       ["FF"])
        XCTAssertEqual(BigNb("FF00").container.map(\.hex),
                       ["00", "FF"])
        XCTAssertEqual(BigNb("FFFF").container.map(\.hex),
                       ["FF", "FF"])
    }
    
    func testAdditiveArithmetic() throws {
        XCTAssertEqual((BigNb(1) + BigNb(2)), BigNb(3))
        XCTAssertEqual((BigNb(0xFF) + BigNb(0xFF)), BigNb(255+255))
        XCTAssertEqual((BigNb(0x1) + BigNb(0x1FF)), BigNb(0x200))
//        XCTAssertEqual((BigNb(3) - BigNb(1)), BigNb(2))
//        XCTAssertEqual((BigNb(0x1FE) - BigNb(0xFF)), BigNb(0xFF))
//        XCTAssertEqual((BigNb(0x200) - BigNb(0x1)), BigNb(0xFF))
        XCTAssertEqual((0 as UInt8) &- 1, 255)
    }
}

extension UInt8 {
    var hex:String {
        String(format:"%02X", self)
    }
    var oct:String {
        String(format:"%02o", self)
    }
    var bin:String {
        String(self, radix: 2)
    }
}

extension StringProtocol {
    var hexaData: Data { Data(_hexa) }
    var hexaBytes: [UInt8] { [UInt8](_hexa) }
    var _hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}

func andAdd(_ x: UInt8, _ y: UInt8) -> (UInt8, Bool) {
    return (_8add(x, y), overflow(x, y))
}
func overflow(_ i:UInt8, _ j: UInt8) -> Bool {
    j > (UInt8.max - i)
}
func underflow(_ i:UInt8, _ j: UInt8) -> Bool {
    i < j
}


func _8add(_ x: UInt8, _ y: UInt8) -> UInt8
{
    var y = y, x = x
    // Iterate till there is no carry
    while (y != 0)
    {
        // carry now contains common
        // set bits of x and y
        let carry = x & y
        
        // Sum of bits of x and
        // y where at least one
        // of the bits is not set
        x ^= y
        
        // Carry is shifted by
        // one so that adding it
        // to x gives the required sum
        y = carry << 1
    }
    return x;
}
