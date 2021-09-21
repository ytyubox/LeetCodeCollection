//
/*
 *		Created by 游宗諭 in 2021/9/6
 *
 *		Using Swift 5.0
 *
 *		Running on macOS 12.0
 */

import Foundation
extension Int {
    var _1: String {
        format(1)
    }

    var _2: String {
        format(2)
    }

    var _3: String {
        format(3)
    }

    var _4: String {
        format(4)
    }

    func format(_ d: Int) -> String {
        String(format: "%0\(d)d", self)
    }
}
