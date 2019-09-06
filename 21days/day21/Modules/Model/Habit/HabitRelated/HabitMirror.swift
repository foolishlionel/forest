//
//  HabitMirror.swift
//  day21
//
//  Created by flion on 2019/7/9.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct HabitMirror {
    var icon: HabitIcon = .badminton
    var color: HabitColor = .color3
    var category: HabitCategory = .life

    init(icon: HabitIcon, color: HabitColor, category: HabitCategory) {
        self.icon = icon
        self.color = color
        self.category = category
    }
}
