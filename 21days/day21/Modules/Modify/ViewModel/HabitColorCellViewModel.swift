//
//  HabitColorCellViewModel.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitColorCellViewModel {
    var choosedColor: HabitColor = .color3
    init(habit: Habit) {
        self.choosedColor = habit.mirror.color
    }

}
