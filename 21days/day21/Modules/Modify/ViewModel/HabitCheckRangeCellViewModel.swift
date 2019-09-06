//
//  HabitCheckRangeCellViewModel.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitCheckRangeCellViewModel {
    var checkRange: HabitCheckTimeRange = .anyTime
    init(habit: Habit) {
        self.checkRange = habit.checkRange
    }
}
