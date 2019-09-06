//
//  ReportWeekCellVM.swift
//  day21
//
//  Created by flion on 2019/6/4.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct ReportWeekCellVM {
    fileprivate var habit: Habit!
    fileprivate var current = Date.current()
    init(habit: Habit!, current: Date = Date.current()) {
        self.habit = habit
        self.current = current
    }
    
    var habitName: String {
        return habit.name
    }
    
    var completeRateInWeek: Float {
        let checkCount = completeCountInWeek
        let shouldCheckCount = shouldCompleteCountInWeek
        return Float(checkCount) / Float(shouldCheckCount)
    }
    
    var completeCountInWeek: Int {
        let checkedDays = habit.checkInDays.filter { $0 > startOfWeek && $0 < endOfWeek }
        return checkedDays.count
    }
    
    fileprivate var shouldCompleteCountInWeek: Int {
        if habit.createdAt < startOfWeek {
            let dayOfToday = current.dayNumber
            let shouldCount = 7 - dayOfToday + 1
            return shouldCount
        } else {
            return 7
        }
    }
}

extension ReportWeekCellVM {
    fileprivate var startOfWeek: Date {
        return current.startOfCurrentWeek()!
    }
    
    fileprivate var endOfWeek: Date {
        return current.endOfCurrentWeek()!
    }
}
