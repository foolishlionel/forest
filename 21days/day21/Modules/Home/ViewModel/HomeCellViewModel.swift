//
//  HomeCellViewModel.swift
//  day21
//
//  Created by flion on 2018/12/18.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

struct HomeCellViewModel {
    var compareDate: Date = Date()
    fileprivate let habit: Habit
    init(habit: Habit, compareDate: Date) {
        self.habit = habit
        self.compareDate = compareDate
    }
    
    /// 名称
    var habitName: String { return habit.name }
    /// 图标
    var habitIcon: HabitIcon { return habit.mirror.icon }
    /// 图标颜色
    var habitColor: HabitColor { return habit.mirror.color }
    /// 累计打卡天数
    var totalCheckInCount: Int { return habit.checkInDays.count }
    /// 当前连续打卡天数
    var currentContinuousCheckInCount: Int {
        return HabitModuleHelper.continuousCheckDays(whenHabit: habit)
    }
    /// 周一是否签到
    var isMondayCheckIn: Bool {
        return hasCheck(atWeekday: 1)
    }
    /// 周二是否签到
    var isTuesdayCheckIn: Bool {
        return hasCheck(atWeekday: 2)
    }
    /// 周三是否签到
    var isWednesdayCheckIn: Bool {
        return hasCheck(atWeekday: 3)
    }
    /// 周四是否签到
    var isThursdayCheckIn: Bool {
        return hasCheck(atWeekday: 4)
    }
    /// 周五是否签到
    var isFridayCheckIn: Bool {
        return hasCheck(atWeekday: 5)
    }
    /// 周六是否签到
    var isSaturdayCheckIn: Bool {
        return hasCheck(atWeekday: 6)
    }
    /// 周日是否签到
    var isSundayCheckIn: Bool {
        return hasCheck(atWeekday: 7)
    }
    /// 某天是否签到
    func hasCheckIn(atDate date: Date) -> Bool {
        
        let dateStr = date.string(withFormat: Habit.kDefaultCheckInFormat)
        
        let checkInDays = habit.checkInDays.map { date -> String in
            let checkInDateStr = date.string(withFormat: Habit.kDefaultCheckInFormat)
            return checkInDateStr
            }.filter { $0 == dateStr }
        
        
        if case .everyDay(_, let count) = habit.checkRate {
            // 签到的次数，大于预期的次数
            return checkInDays.count >= count
        }
        return false
    }
    
    func checkCount(atDate date: Date) -> Int {
        let checkCount = habit.checkInDays.filter { $0.compare(.isSameDay(as: date)) }.count
        return checkCount + 2222
    }
    
    func shouldCheckCount(atDay day: WeekDay) -> Int {
        if case .everyDay(let days, let count) = habit.checkRate {
            if days.contains(day) { return count }
            return 0
        }
        return 0
    }
    
    fileprivate let current = Date.current()
    fileprivate var currentWeekday: Int {
        return current.weekday
    }
    
    fileprivate func makeDateAtWeekday(day: Int) -> Date {
        if day <= currentWeekday {
            let daysBefore = currentWeekday - day
            let dateBefore = NSDate(daysBeforeNow: daysBefore)! as Date
            return dateBefore
        } else {
            let daysAfter = day - currentWeekday
            let dateAfter = NSDate(daysFromNow: daysAfter)! as Date
            return dateAfter
        }
    }
    
    fileprivate func hasCheck(atWeekday day: Int) -> Bool {
        let dayDate = makeDateAtWeekday(day: day)
        let dayCheck = habit.checkInDays.filter { $0.compare(.isSameDay(as: dayDate)) }
        return dayCheck.count > 0
    }
}
