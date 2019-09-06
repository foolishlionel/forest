//
//  AnalyzeCalendarViewModel.swift
//  day21
//
//  Created by flion on 2019/1/28.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct AnalyzeCalendarViewModel {
    var checkInDays: [Date] { return Array.init(habit.checkInDays) }
    var habitColor: HabitColor { return habit.mirror.color }
    var createdAt: Date { return habit.createdAt }
    
    fileprivate var habit: Habit!
    init(habit: Habit) {
        self.habit = habit
    }
}
