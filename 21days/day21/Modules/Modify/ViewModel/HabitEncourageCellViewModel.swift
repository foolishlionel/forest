//
//  HabitEncourageCellViewModel.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitEncourageCellViewModel {
    var encourageWords: String? = ""
    init(habit: Habit) {
        self.encourageWords = habit.encourgeWords
    }

}
