//
//  DateConstants.swift
//  day21
//
//  Created by flion on 2019/6/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

let appCalendar = Calendar.current
//let zoneShanghai = TimeZone.init(identifier: "Asia/Shanghai")

extension Date {
    /// 当前时间
    static func current() -> Date {
        let today = Date()
        let timeZone = appCalendar.timeZone
        let difference = timeZone.secondsFromGMT(for: today)
        let current = Date(timeInterval: TimeInterval(difference), since: today)
        return current
    }
}
