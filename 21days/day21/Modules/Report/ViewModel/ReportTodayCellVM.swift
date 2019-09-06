//
//  ReportTodayVM.swift
//  day21
//
//  Created by flionel on 2019/4/8.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct ReportTodayCellVM {
    fileprivate var habits: [Habit] = []
    fileprivate var current = Date.current()
    init(habits: [Habit], current: Date) {
        self.habits = habits
        self.current = current
    }
    
    var todayHabitsCount: Int {
        return habits.count
    }
    
    var checkedHabitsCount: Int {
        return habits
            .filter { isChecked(habit: $0, compare: current) }
            .count
    }
}

extension ReportTodayCellVM {
    fileprivate func isChecked(habit: Habit, compare: Date) -> Bool {
        let checkInDays = habit.checkInDays.map { date -> String in
            let checkInDateStr = date.string(withFormat: Habit.kDefaultCheckInFormat)
            return checkInDateStr
        }
        let dateStr = compare.string(withFormat: Habit.kDefaultCheckInFormat)
        if checkInDays.contains(dateStr) {
            return true
        }
        return false
    }
}
