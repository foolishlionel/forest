//
//  HabitFrequencyDaysViewModel.swift
//  day21
//
//  Created by flion on 2019/6/19.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitFrequencyDaysViewModel {
    var repeatDays: Set<WeekDay> = []
    init(repeatDays: Set<WeekDay> = []) {
        self.repeatDays = repeatDays
    }
}
