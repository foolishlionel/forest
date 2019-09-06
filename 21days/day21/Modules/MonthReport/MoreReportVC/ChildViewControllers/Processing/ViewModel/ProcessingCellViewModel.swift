//
//  ProcessingCellViewModel.swift
//  day21
//
//  Created by flion on 2018/12/27.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

struct ProcessingCellViewModel {
    
    fileprivate let habit: Habit
    init(habit: Habit) {
        self.habit = habit
    }
    
    var habitName: String { return habit.name }
    var habitIcon: HabitIcon { return habit.mirror.icon }
    var habitColor: HabitColor { return habit.mirror.color }
    var goalCheckDays: Int { return habit.goal.rawValue }
    var totalCheckInDays: Int { return habit.checkInDays.count }
    var leftCheckDays: Int {
        guard goalCheckDays > totalCheckInDays else {
            fatalError("ERROR: GOAL DAYS IS LESS THAN CHECK IN DAYS")
        }
        return goalCheckDays - totalCheckInDays
    }
}
