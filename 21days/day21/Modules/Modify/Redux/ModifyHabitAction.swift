//
//  HabitAction.swift
//  day21
//
//  Created by flion on 2018/10/18.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import ReSwift

enum ModifyHabitAction: Action {
    case installHabitInfo(habit: Habit)
    case endInputHabitName(name: String)
    case chooseCheckTime(checkRange: HabitCheckTimeRange)
    case changeRemindSwitch(isOn: Bool)
    case endInputEncourageWords(words: String)
    case addRemindTime(time: String)
    case deleteRemindTime(time: String)
    case chooseMirror(mirror: HabitMirror)
    case selectColor(color: HabitColor)
    case switchFrequencyMenu(rate: CheckRateType)
    case chooseRepeatDays(days: Set<WeekDay>)
}
