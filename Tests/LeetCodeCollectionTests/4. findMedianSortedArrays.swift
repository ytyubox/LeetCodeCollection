//
/*
 *		Created by 游宗諭 in 2021/7/13
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 12.0
 */

import XCTest

// MARK: - _4Tests

final class _4Tests: XCTestCase {
    func test1() {
        let nums1: [Int] = [1, 3]
        let nums2: [Int] = [2]
        let Output = 2.00000
        findMedianSortedArrays(nums1, nums2).shouldBe(Output)
    }

    func test2() throws {
        let nums1: [Int] = [1, 2]
        let nums2: [Int] = [3, 4]
        let Output = 2.50000
        findMedianSortedArrays(nums1, nums2).shouldBe(Output)
    }

    func test3() throws {
        let nums1: [Int] = [0, 0]
        let nums2: [Int] = [0, 0]
        let Output = 0.00000
        findMedianSortedArrays(nums1, nums2).shouldBe(Output)
    }

    func test4() throws {
        let nums1: [Int] = []
        let nums2: [Int] = [1]
        let Output = 1.00000
        findMedianSortedArrays(nums1, nums2).shouldBe(Output)
    }

    func test5() throws {
        let nums1: [Int] = [2]
        let nums2: [Int] = []
        let Output = 2.00000
        findMedianSortedArrays(nums1, nums2).shouldBe(Output)
    }
}

func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let (m, n) = (nums1.count, nums2.count)
    if n < m {
        // keep nums1 small
        return findMedianSortedArrays(nums2, nums1)
    }
    func helper(_ l: Int, _ u: Int) -> Int {
        guard l <= u else { return l }
        let i = l + (u - l) >> 1
        var j: Int { n - i }
        if nums1.indices.contains(i), nums1[i] < nums2[j - 1] {
            return helper(i + 1, u)
        }

        if i != 0, nums2[j] < nums1[i - 1] {
            return helper(l, i - 1)
        }
        return l
    }
    let i = helper(0, m)
    let j = n - i
    let max_of_left: Int = max(
        nums1[..<i].last ?? .min,
        nums2[..<j].last ?? .min)

    if (m + n) % 2 == 1 {
        return Double(max_of_left)
    }

    let min_of_right: Int = min(
        nums1[i...].first ?? .max,
        nums2[j...].first ?? .max)

    return Double(max_of_left + min_of_right) / 2.0
}

func I_findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let (m, n) = (nums1.count, nums2.count)
    if n < m {
        // keep nums1 small
        return findMedianSortedArrays(nums2, nums1)
    }
//    let i_j_total = n + (m - n + 1) / 2
//    print(i_j_total)
    var (l, u) = (0, m)
    var i = 0
    var j: Int { n - i }
    while true {
        guard l <= u else { break }
        i = l + (u - l) / 2
        // check
//        guard 0 < i && i < m else {break}
        if
            nums1.indices.contains(i),
            nums1[i] < nums2[j - 1]
        {
            l = i + 1
            continue
            // i is too small, must increase it
        }

        if
            i != 0,
            nums2[j] < nums1[i - 1]
        {
            // # i is too big, must decrease it
            u = i - 1
        } else {
            break
        }
    }
    let max_of_left: Int
    if i == 0 {
        max_of_left = nums2[j - 1]
    } else if j == 0 {
        max_of_left = nums1[i - 1]
    } else {
        max_of_left = max(nums1[i - 1], nums2[j - 1])
    }

    if (m + n) % 2 == 1 {
        return Double(max_of_left)
    }

    let min_of_right: Int

    if i == m {
        min_of_right = nums2[j]
    } else if j == n {
        min_of_right = nums2[i]
    } else {
        min_of_right = min(nums1[i], nums2[j])
    }

    return Double(max_of_left + min_of_right) / 2.0
}

// MARK: - PartArray

struct PartArray<E> {
    init(startIndex: Array<PartArray.Element>.Index, endIndex: Array<PartArray.Element>.Index, array: [Element]) {
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.array = array
    }

    init(_ range: ClosedRange<Index>, array: [Element]) {
        self.init(startIndex: range.lowerBound, endIndex: range.upperBound, array: array)
    }

    init(_ range: Range<Index>, array: [Element]) {
        self.init(startIndex: range.lowerBound, endIndex: range.upperBound
            - 1, array: array)
    }

    init(_ range: PartialRangeUpTo<Index>, array: [Element]) {
        self.init(startIndex: array.startIndex, endIndex: range.upperBound - 1, array: array)
    }

    init(_ range: PartialRangeThrough<Index>, array: [Element]) {
        self.init(startIndex: array.startIndex, endIndex: range.upperBound, array: array)
    }

    var startIndex: Array<Element>.Index
    var endIndex: Array<Element>.Index

    typealias Element = E
    typealias Index = Array<Element>.Index
    let array: [Element]

    subscript(position: Index) -> Element {
        assert((0...(endIndex - startIndex)).contains(position))
        let old = (position + startIndex)
        return array[old]
    }

    var first: Element? {
        if array.isEmpty { return nil }
        return array[startIndex]
    }

    var last: Element? {
        if array.isEmpty { return nil }
        return array[endIndex]
    }
}

extension Array {
    func part(_ range: ClosedRange<Index>) -> PartArray<Element> {
        .init(range, array: self)
    }

    func part(_ range: Range<Index>) -> PartArray<Element> {
        .init(range, array: self)
    }

    func part(_ range: PartialRangeUpTo<Index>) -> PartArray<Element> {
        .init(range, array: self)
    }

    func part(_ range: PartialRangeThrough<Index>) -> PartArray<Element> {
        .init(range, array: self)
    }

    func part(_ range: PartialRangeFrom<Int>) -> PartArray<Element> {
        .init(startIndex: range.lowerBound, endIndex: endIndex - 1, array: self)
    }
}

// MARK: - PartArrayTests

class PartArrayTests: XCTestCase {
    func test() {
        let array = [0, 1, 2, 3]
        let sut = PartArray(startIndex: 1, endIndex: 3, array: array)
        sut[0].shouldBe(1)
        sut[1].shouldBe(2)
        sut[2].shouldBe(3)
        sut.first?.shouldBe(1)
        sut.last?.shouldBe(3)
    }

    func testCloseRange() {
        let array = [0, 1, 2, 3]
        let sut = PartArray(1...3, array: array)
        sut[0].shouldBe(1)
        sut[1].shouldBe(2)
        sut[2].shouldBe(3)
        sut.first?.shouldBe(1)
        sut.last?.shouldBe(3)
    }

    func testRange() {
        let array = [0, 1, 2, 3]
        let sut = PartArray(1 ..< 4, array: array)
        sut[0].shouldBe(1)
        sut[1].shouldBe(2)
        sut[2].shouldBe(3)
        sut.first?.shouldBe(1)
        sut.last?.shouldBe(3)
    }

    func testCloseRangeByPart() {
        let sut = [0, 1, 2, 3].part(1...3)
        sut[0].shouldBe(1)
        sut[1].shouldBe(2)
        sut[2].shouldBe(3)
        sut.first?.shouldBe(1)
        sut.last?.shouldBe(3)
    }

    func testRangeByPart() {
        let sut = [0, 1, 2, 3].part(1 ..< 4)
        sut[0].shouldBe(1)
        sut[1].shouldBe(2)
        sut[2].shouldBe(3)
        sut.first?.shouldBe(1)
        sut.last?.shouldBe(3)
    }

    func testRangeByPartPartialRangeUpTo() {
        let r = ..<4
        let sut = [0, 1, 2, 3].part(r)
        sut[0].shouldBe(0)
        sut[1].shouldBe(1)
        sut[2].shouldBe(2)
        sut[3].shouldBe(3)
        sut.first?.shouldBe(0)
        sut.last?.shouldBe(3)
    }

    func testRangeByPartWithPartialRangeThrough() {
        let r = ...3
        let sut = [0, 1, 2, 3].part(r)
        sut[0].shouldBe(0)
        sut[1].shouldBe(1)
        sut[2].shouldBe(2)
        sut[3].shouldBe(3)
        sut.first?.shouldBe(0)
        sut.last?.shouldBe(3)
    }

    func testRangeByPartWithPartialRangeFrom() {
        let r = 1...
        let sut = [0, 1, 2, 3].part(r)
        sut[0].shouldBe(1)
        sut[1].shouldBe(2)
        sut[2].shouldBe(3)
        sut.first?.shouldBe(1)
        sut.last?.shouldBe(3)
    }

    func testArray() {
//        let r = 1...
        let array = [0, 1, 2, 3]
        let sut: Array<Int>.SubSequence = array[1...]
//        sut[0].shouldBe(1)
        sut[1].shouldBe(1)
        sut[2].shouldBe(2)
        sut.first?.shouldBe(1)
        sut.last?.shouldBe(3)
    }

    func testArrayEmpty() {
        let r = 1 ..< 1
        let array = [0, 1, 2, 3]
        let sut = array[r]
        sut.isEmpty.shouldBe(true)
    }
}
