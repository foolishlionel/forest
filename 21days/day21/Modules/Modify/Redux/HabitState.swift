//
//  HabitState.swift
//  day21
//
//  Created by flion on 2018/10/18.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import ReSwift

struct HabitState: StateType {
    var habit: Habit!
    var enableInteract: Bool = true
    
    init(habit: Habit, enableInteract: Bool = true) {
        self.habit = habit
        self.enableInteract = enableInteract
    }
}
