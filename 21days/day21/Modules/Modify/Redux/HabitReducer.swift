//
//  HabitReducer.swift
//  day21
//
//  Created by flion on 2018/10/18.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import ReSwift

func habitReducer(_ action: ModifyHabitAction, _ state: HabitState) -> HabitState {
    
    switch action {
    case .installHabitInfo(let habit):
        return HabitState(habit: habit)
    case .endInputHabitName(let name):
        var habit = copiedHabit(origin: state.habit)
        habit.name = name
        return HabitState(habit: habit)
    case .switchFrequencyMenu(let rate):
        var habit = copiedHabit(origin: state.habit)
        habit.checkRate = rate
        return HabitState(habit: habit)
    case .chooseCheckTime(let checkRange):
        var habit = copiedHabit(origin: state.habit)
        habit.checkRange = checkRange
        return HabitState(habit: habit)
    case .changeRemindSwitch(let isOn):
        var habit = copiedHabit(origin: state.habit)
        habit.isOpenRemind = isOn
        return HabitState(habit: habit)
    case .endInputEncourageWords(let words):
        var habit = copiedHabit(origin: state.habit)
        habit.encourgeWords = words
        return HabitState(habit: habit)
    case .addRemindTime(let time):
        var habit = copiedHabit(origin: state.habit)
        if !habit.remindTimes.contains(time) {
            habit.remindTimes.insert(time)
        }
        return HabitState(habit: habit)
    case .deleteRemindTime(let time):
        var habit = copiedHabit(origin: state.habit)
        habit.remindTimes.remove(time)
        return HabitState(habit: habit)
    case .selectColor(let color):
        var habit = copiedHabit(origin: state.habit)
        habit.mirror.color = color
        return HabitState(habit: habit)
    case .chooseRepeatDays(let days):
        var habit = copiedHabit(origin: state.habit)
        
        let checkRate = habit.checkRate
        if case .everyDay(_, let count) = checkRate {
            let newCheckRate = CheckRateType.everyDay(days: days, count: count)
            habit.checkRate = newCheckRate
        }
        return HabitState(habit: habit)
    case .chooseMirror(let mirror):
        var habit = copiedHabit(origin: state.habit)
        habit.mirror = mirror
        return HabitState(habit: habit)
    }
}

fileprivate func copiedHabit(origin: Habit) -> Habit {
    let newHabit = origin
    return newHabit
}


