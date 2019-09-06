//
//  HabitModuleHelper.swift
//  day21
//
//  Created by flion on 2019/1/20.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class HabitModuleHelper: NSObject {
    
    static func calculateCurrentWeekMenuItems() -> [HomeMenuModel] {
        let current = Date.current()
        let todayWeekday = current.weekday
        var menuItems = [HomeMenuModel]()
        for i in 1...7 {
//            let isSelect = (i == todayWeekday)
            
            if i <= todayWeekday {
                let daysBefore = todayWeekday - i
                let dateBefore = current.dateBefore(days: daysBefore)
                let item = HomeMenuModel(date: dateBefore, index: i)
                menuItems.append(item)
            } else {
                let daysAfter = i - todayWeekday
                let dateAfter = current.dateAfter(days: daysAfter)
                let item = HomeMenuModel(date: dateAfter, index: i)
                menuItems.append(item)
            }
        }
        return menuItems
    }
    
    
    
    static func finishedHabitCount(inHabits habits: [Habit]) -> Int {
        let finishedHabits = habits.filter { $0.checkInDays.count >= $0.goal.rawValue }
        return finishedHabits.count
    }
    
    static func continuousCheckDays(whenHabit habit: Habit) -> Int {
        
            let checkInArray = Array(habit.checkInDays).sorted(by: <)
            
            guard checkInArray.count > 0 else { return 0 }
            guard checkInArray.last!.compare(.isToday) else { return 0 }
            var checkCount = 1
            
            for i in (0..<checkInArray.count).reversed() {
                if i-1 >= 0 {
                    let next = checkInArray[i]
                    let pre = checkInArray[i-1]
                    if pre.daysBetweenDate(toDate: next) == 1 {
                        checkCount += 1
                    } else {
                        break
                    }
                }
            }
            return checkCount
    }
    
    static func maxContinuousCheckDays(whenHabit habit: Habit) -> Int {
        let checkInArray = Array.init(habit.checkInDays).sorted(by: <)
        guard checkInArray.count > 0 else { return 0 }
        var maxContinuousCount = 1
        
        var cursorIndex = 1
        for i in 0..<checkInArray.count {
            if i+1 < checkInArray.count {
                let pre = checkInArray[i]
                let next = checkInArray[i+1]
                if pre.daysBetweenDate(toDate: next) == 1 {
                    cursorIndex += 1
                    if cursorIndex > maxContinuousCount {
                        maxContinuousCount = cursorIndex
                    }
                } else {
                    cursorIndex = 1
                }
            }
        }
        
        return maxContinuousCount
    }
    
    static func maxContinuousCheckDays(inHabits habits: [Habit]) -> Int {
        var max = 0
        for habit in habits {
            let maxCountWhenHabit = HabitModuleHelper.maxContinuousCheckDays(whenHabit: habit)
            if maxCountWhenHabit > max {
                max = maxCountWhenHabit
            }
        }
        return max
    }
    
    static func newHabitsCountOfCurrentMonth(habits: [Habit], compare specDate: Date) -> Int {
        let startOfMonth = specDate.startOfCurrentMonth()
        let endOfMonth = specDate.endOfCurrentMonth()
        
        var newCount = 0
        for habit in habits {
            if habit.createdAt >= startOfMonth && habit.createdAt <= endOfMonth {
                newCount += 1
            }
        }
        return newCount
    }
    
    static func processingHabitsCountOfCurrent(habits: [Habit], compare specDate: Date) -> Int {
//        let startOfMonth = specDate.startOfCurrentMonth()
        let endOfMonth = specDate.endOfCurrentMonth()
        
        var processingCount = 0
        for habit in habits {
            if habit.createdAt < endOfMonth {
                let gap = habit.createdAt.daysBetweenDate(toDate: endOfMonth)
                if gap >= 0 {
                    processingCount +=  1
                }
            }
        }
        return processingCount
    }
    
}
