//
//  HabitRemindCellViewModel.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitRemindCellViewModel {
    var isOpenRemind: Bool = false
    init(habit: Habit) {
        self.isOpenRemind = habit.isOpenRemind
    }
}
