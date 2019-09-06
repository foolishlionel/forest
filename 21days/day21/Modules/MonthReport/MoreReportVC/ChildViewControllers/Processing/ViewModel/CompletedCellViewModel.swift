//
//  CompletedCellViewModel.swift
//  day21
//
//  Created by flion on 2019/1/15.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct CompletedCellViewModel {
    fileprivate let habit: Habit
    init(habit: Habit) {
        self.habit = habit
    }

    var habitName: String { return habit.name }
    var habitIcon: HabitIcon { return habit.mirror.icon }
    var habitColor: HabitColor { return habit.mirror.color }
    var goalCheckDays: Int { return habit.goal.rawValue }
    var totalCheckInDays: Int { return habit.checkInDays.count }
}
