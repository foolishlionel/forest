//
//  MonthReportCollectCellViewModel.swift
//  day21
//
//  Created by flion on 2019/1/24.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import PieCharts

struct MonthReportCollectCellViewModel {
    
    var compareDate: Date = Date()
    var habits: [Habit] = []
    init(compareDate: Date, habits: [Habit]) {
        self.compareDate = compareDate
        self.habits = habits
    }
    
    var yearNumber: Int {
        return compareDate.yearNumber
    }
    
    var monthNumer: Int {
        return compareDate.monthNumber
    }
    
    var shouldCheckHabits: Int {
        return habits.count
    }
    
    var shouldCheckDays: Int {
        var monthCheckDays: Int = 0
        for habit in habits {
            monthCheckDays += habit.shouldCheckDays(compareDate: compareDate)
        }
        return monthCheckDays
    }
    
    var alreadyCheckDays: Int {
        var alreadyCount: Int = 0
        for habit in habits {
            alreadyCount += habit.alreadyCheckDaysInMonth(compareDate: compareDate)
        }
        return alreadyCount
    }
    
    var sliceModels: [PieSliceModel] {
        let alpha: CGFloat = 0.5
        let models = habits.map { PieSliceModel(value: Double($0.alreadyCheckDaysInMonth(compareDate: compareDate)), color: $0.mirror.color.cocoaColor.withAlphaComponent(alpha)) }
        return models
    }
    
    var progress: CGFloat {
        return CGFloat(totalCheckInCount) / CGFloat(totalGoalCount)
    }
    var finishedCount: Int {
        return HabitModuleHelper.finishedHabitCount(inHabits: habits)
    }
    
    var maxContinuousCount: Int {
        return HabitModuleHelper.maxContinuousCheckDays(inHabits: habits)
    }
    
    var unfinishedCount: Int {
        return (habits.count - processingCount)
    }
    
    var processingCount: Int {
        return HabitModuleHelper.processingHabitsCountOfCurrent(habits: habits, compare: compareDate)
    }
    var newCount: Int {
        return HabitModuleHelper.newHabitsCountOfCurrentMonth(habits: habits, compare: compareDate)
    }
    
    fileprivate var totalCheckInCount: Int {
        return habits.map { $0.checkInDays.count }.reduce(0) { $0 + $1 }
    }
    
    fileprivate var totalGoalCount: Int {
        return  habits.map { $0.goal.rawValue }.reduce(0) { $0 + $1 }
    }
}
