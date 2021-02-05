//
// Created by 游宗諭 in 2020/12/15
//
//
// Using Swift 5.0
//
// Running on macOS 10.15


import Foundation
public struct Strategy:Equatable {
    init() {}
    let uuid = UUID()
    public static let brute_force = Strategy()
    public static let timeout = Strategy()
    public static let hashmap = Strategy()
    public static let twopointer = Strategy()
}

func test() throws {
    let s = Strategy.brute_force
    
    switch s {
        case .brute_force:
            break
        default:
            fatalError()
    }
}

