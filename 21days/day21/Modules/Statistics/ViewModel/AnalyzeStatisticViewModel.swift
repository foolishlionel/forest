//
//  AnalyzeStatisticViewModel.swift
//  day21
//
//  Created by flion on 2019/1/28.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct AnalyzeStatisticViewModel {
    fileprivate var habit: Habit!
    init(habit: Habit) {
        self.habit = habit
    }
    
    var alreadyCheckInCount: Int {
        return habit.checkInDays.count
    }
    
    var restCheckInCount: Int {
        return habit.goal.rawValue - habit.checkInDays.count
    }
    
    var currentContinuousCount: Int {
        return HabitModuleHelper.continuousCheckDays(whenHabit: habit)
    }
    
    var maxContinuousCount: Int {
        return HabitModuleHelper.maxContinuousCheckDays(whenHabit: habit)
    }
    
    var createdAtText: String {
        return habit.createdAt.string(withFormat: "yyyy.MM.dd")
    }
}
