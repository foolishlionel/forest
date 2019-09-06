//
//  HabitGoalCellViewModel.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitGoalCellViewModel {
    var isInfinite: Bool = false
    init(habit: Habit) {
//        self.isInfinite = habit.isInfinite
        self.isInfinite = false
    }
}
