//
//  HabitNameCellViewModel.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitNameCellViewModel {
    var name: String = ""
    var mirror = Habit.defaultHabitMirror
    
    init(habit: Habit) {
        self.name = habit.name
        self.mirror = habit.mirror
    }
}
