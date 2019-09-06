//
//  HabitCheckTimeRange.swift
//  day21
//
//  Created by flion on 2019/6/18.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

enum HabitCheckTimeRange: Int {
    case anyTime = 0
    case morning = 1
    case afternoon = 2
    case evening = 3
    
    var timeDescription: String {
        switch self {
        case .anyTime:
            return "任意时间"
        case .morning:
            return "造成"
        case .afternoon:
            return "午后"
        case .evening:
            return "晚间"
        }
    }
    
    func isValidCheckTime(compare date: Date) -> Bool {
        if case .anyTime = self {
            return true
        } else {
            let checkHour = date.hourValue()
            let startHour = checkStartTime.hourValue()
            let endHour = checkEndTime.hourValue()
            
            if (checkHour >= startHour && checkHour < endHour) {
                return true
            }
        }
        return false
    }
    
    var minusRangeValue: Int {
        switch self {
        case .morning:
            return 8
        case .afternoon:
            return 13
        case .evening:
            return 17
        default:
            return -1
        }
    }
    
    var maximumRangeValue: Int {
        switch self {
        case .morning:
            return 10
        case .afternoon:
            return 17
        case .evening:
            return 21
        default:
            return 25
        }
    }
    
    fileprivate var checkStartTime: Date {
        let formatter = "HH:mm:ss"
        switch self {
        case .anyTime:
            return Date.date(from: "00:00:00", withFromat: formatter)!
        case .morning:
            return Date.date(from: "08:00:00", withFromat: formatter)!
        case .afternoon:
            return Date.date(from: "13:00:00", withFromat: formatter)!
        case .evening:
            return Date.date(from: "19:00:00", withFromat: formatter)!
        }
    }
    
    fileprivate var checkEndTime: Date {
        let formatter = "HH:mm:ss"
        switch self {
        case .anyTime:
            return Date.date(from: "23:59:59", withFromat: formatter)!
        case .morning:
            return Date.date(from: "09:59:59", withFromat: formatter)!
        case .afternoon:
            return Date.date(from: "17:59:59", withFromat: formatter)!
        case .evening:
            return Date.date(from: "22:59:59", withFromat: formatter)!
        }
    }
}
