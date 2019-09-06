//
//  SecondMenuCellViewModel.swift
//  day21
//
//  Created by flion on 2019/1/23.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct SecondMenuCellViewModel {
    var habitName: String = ""
    var habitIcon: HabitIcon = .sleep
    var habitColor: HabitColor = .color0
    var selected: Bool = false
    
    init(name: String, icon: HabitIcon, color: HabitColor, selected: Bool) {
        self.habitName = name
        self.habitIcon = icon
        self.habitColor = color
        self.selected = selected
    }
}
