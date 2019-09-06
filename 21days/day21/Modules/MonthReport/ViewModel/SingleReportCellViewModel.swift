//
//  MonthReportCellect1CellViewModel.swift
//  day21
//
//  Created by flion on 2019/1/30.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct SingleReportCellViewModel {
    
    fileprivate var compareDate = Date()
    fileprivate var habit: Habit!
    init(compareDate: Date, habit: Habit) {
        self.habit = habit
    }
    
    var habitName: String { return habit.name }
    var color: HabitColor { return habit.mirror.color }
    var goalCount: Int { return habit.shouldCheckDays(compareDate: compareDate) }
    var alreadyCheckCount: Int {
        return habit.alreadyCheckDaysInMonth(compareDate: compareDate)
    }
    var checkCount: Int { return habit.checkInDays.count }
    var restCount: Int { return goalCount - checkCount }
    var continuousCount: Int {
        return HabitModuleHelper.continuousCheckDays(whenHabit: habit)
    }
    var maxContinuousCount: Int {
        return HabitModuleHelper.maxContinuousCheckDays(whenHabit: habit)
    }
    var progress: CGFloat {
        return CGFloat(alreadyCheckCount) / CGFloat(goalCount)
    }
}
