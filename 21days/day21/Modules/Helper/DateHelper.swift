//
//  DateHelper.swift
//  day21
//
//  Created by flion on 2019/6/11.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    static func weekComponentsOfThisYear(today: Date) -> [(start: Date, end: Date)] {
        
        var components = [(Date, Date)]()
        
        var dateOfStart = today.startOfCurrentYear()
        let dateOfLimit = today
        
        while dateOfStart < dateOfLimit {

            let cursor = dateOfStart.weekday

            let gapDayOfEnd = 7 - cursor

            let dateOfEndInWeek = dateOfStart.dateAfter(days: gapDayOfEnd)
            if dateOfEndInWeek < today {
                components.append((dateOfStart, dateOfEndInWeek))
            } else {
                components.append((dateOfStart, today))
            }

            // 下周一: 本周末 + 1
            dateOfStart = dateOfEndInWeek.dateAfter(days: 1)
        }
        
        return components
    }
    
    static func monthComponentsOfThisYear(today: Date) -> [(start: Date, end: Date)] {
        var components = [(Date, Date)]()
        return components
    }
}
