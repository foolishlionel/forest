//
//  Habit.swift
//  day21
//
//  Created by flion on 2018/10/16.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

extension Habit {
    static let kDefaultTimeFormat: String = "yyyy-MM-dd HH:mm:ss"
    static let kDefaultCheckInFormat: String = "yyyy-MM-dd"
    static let kDefaultRemindTimeFormat: String = "HH:mm"
}

extension Habit {
    static let defaultHabitMirror = HabitMirror(icon: .bath, color: .color4, category: .other)
}

typealias CheckInDay = (Date, Int)

struct Habit {
    
    var id: Int64 = 0
    var name: String = "" // 习惯名称
    var createdAt = Date() // .date(from: "10/01/2019 12:04:44")! // 创建时间
    var startedAt = Date() // 开始时间
    var isOpenRemind: Bool = false // 是否开启提醒
    var remindTimes = Set<String>() // 提醒时间
    var goal = HabitGoal.forever // 目标坚持的时长
    var mirror: HabitMirror // 习惯图标一瞥
    var encourgeWords: String? // 鼓励的话
    var checkInDays = Set<Date>() // 签到的天
    var checkRange: HabitCheckTimeRange = .anyTime
    var isArchive: Bool = false
    var isDelete: Bool = false
    // 2019-06-21
    var checkRate: CheckRateType = .everyDay(days: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday], count: 1)
    var lastCheckRate: CheckRateType = .everyDay(days: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday], count: 1)
    
    init(id: Int64 = 0,
        name: String = "",
        createdAt: Date = Date(),
        startedAt: Date = Date(),
        isOpenRemind: Bool = false,
        remindTimes: Set<String> = [],
        goal: HabitGoal = .day21,
        mirror: HabitMirror = Habit.defaultHabitMirror,
        encourageWords: String? = nil,
        checkInDays: Set<Date> = [],
        checkRange: HabitCheckTimeRange = .morning,
        isArchive: Bool = false,
        isDelete: Bool = false,
        checkRate: CheckRateType = .everyDay(days: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday], count: 1),
        lastCheckRate: CheckRateType = .everyDay(days: [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday], count: 1)
        ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.startedAt = startedAt
        self.isOpenRemind = isOpenRemind
        self.remindTimes = remindTimes
        self.goal = goal
        self.mirror = mirror
        self.encourgeWords = encourageWords
        self.checkInDays = checkInDays
        self.checkRange = checkRange
        self.isArchive = isArchive
        self.isDelete = isDelete
        self.checkRate = checkRate
        self.lastCheckRate = lastCheckRate
    }
    
    func shouldCheckDays(compareDate: Date) -> Int {
        var checkDays: Int = 0
        let startDateOfMonth = compareDate.startOfCurrentMonth()
        let endDateOfMonth = compareDate.endOfCurrentMonth()
        let gapDays = createdAt.daysBetweenDate(toDate: endDateOfMonth) + 1
        
        
        if createdAt < startDateOfMonth && !createdAt.compare(.isSameDay(as: startDateOfMonth)) {
            let shouldCheckDays = compareDate.monthNumber
            checkDays += shouldCheckDays
        }
        
        if createdAt.isSameYearMonth(compareDate: compareDate) {
            
            if gapDays >= 21 {
                checkDays += 21
            } else {
                checkDays += gapDays
            }
        }
        
        return checkDays
    }
    
    func alreadyCheckDaysInMonth(compareDate: Date) -> Int {
        let alreadyCount = checkInDays.filter { $0.isSameYearMonth(compareDate: compareDate) }.count
        return alreadyCount
    }
    
    func attemptCheckCountInDay() -> Int {
        if case .everyDay(_, let count) = checkRate {
            return count
        }
        return 0
    }
}
