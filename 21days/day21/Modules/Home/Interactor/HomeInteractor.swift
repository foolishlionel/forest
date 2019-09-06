//
//  HomeInteractor.swift
//  day21
//
//  Created by flion on 2018/12/21.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import Promise

typealias CheckRangeHaibtDictionary = [HabitCheckTimeRange: [Habit]]

class HomeInteractor: NSObject {
    
    func loadCheckRangeHabits(inDate date: Date) -> Promise<[CheckRangeHaibtDictionary]> {
        
        let promise = Promise<[CheckRangeHaibtDictionary]>()
        var checkRangeHaibtsDictionarys = [CheckRangeHaibtDictionary]()
        
        HabitDBManager.shared.queryHabits(inDate: date) { [weak self] habits in
            
            guard let wself = self else { return }
            
            if let morningHabitsDictionary = wself.filterHaibts(habits: habits, compareRange: .morning) {
                checkRangeHaibtsDictionarys
                    .append(morningHabitsDictionary)
            }
            
            if let afternoonHabitsDictionary = wself.filterHaibts(habits: habits, compareRange: .afternoon) {
                checkRangeHaibtsDictionarys
                    .append(afternoonHabitsDictionary)
            }
            
            if let eveningHabitsDictionary = wself.filterHaibts(habits: habits, compareRange: .evening) {
                checkRangeHaibtsDictionarys
                    .append(eveningHabitsDictionary)
            }
            
            if let anyTimeHabitsDictionary = wself.filterHaibts(habits: habits, compareRange: .anyTime) {
                checkRangeHaibtsDictionarys
                    .append(anyTimeHabitsDictionary)
            }
            
            if checkRangeHaibtsDictionarys.count > 0 {
                promise.fulfill(checkRangeHaibtsDictionarys)
            }
            
        }
        
        return promise
    }
    
    func loadDbHabits(inDate date: Date, completeBlock block: ((_ morningHabits: [Habit], _ afternoonHabits: [Habit], _ eveningHabits: [Habit], _ randomTimeHabits: [Habit]) -> Void)?) {
        HabitDBManager.shared.queryHabits(inDate: date) { habits in
            
            let morningHabits = habits.filter { item in
                // morning - am 6:00 - am 11:00
                if item.remindTimes.count == 1 {
                    let remindTime = Array(item.remindTimes)[0]
                    let remindDate = Date.date(from: remindTime)
                    let hour = remindDate?.hourValue() ?? 0
                    if hour >= 6 && hour < 11 {
                        return true
                    }
                }
                return false
            }
            
            let afternoonHabits = habits.filter { item in
                // afternoon - am 11:00 - pm 18:00
                if item.remindTimes.count == 1 {
                    let remindTime = Array(item.remindTimes)[0]
                    let remindDate = Date.date(from: remindTime)
                    let hour = remindDate?.hourValue() ?? 0
                    if hour >= 11 && hour < 18 {
                        return true
                    }
                }
                return false
            }
            
            let eveningHabits = habits.filter { item in
                // evening - pm 18:00 - am 06:00
                if item.remindTimes.count == 1 {
                    let remindTime = Array(item.remindTimes)[0]
                    let remindDate = Date.date(from: remindTime)
                    let hour = remindDate?.hourValue() ?? 0
                    if (hour >= 18 && hour < 24) || (hour >= 0 && hour < 6) {
                        return true
                    }
                    return false
                }
                return false
            }
            
            let randomTimeHabits = habits.filter { item in
                // 提醒时间数量为0 或 大于1
                return (item.remindTimes.count != 1)
            }
            
            block?(morningHabits, afternoonHabits, eveningHabits, randomTimeHabits)
        }
    }
    
    func updateHabit(forHabit habit: Habit, checkIn date: Date, completionBlock block:(() -> Void)?) {
        HabitDBManager.shared.updateHabit(forHabit: habit, checkIn: date, completionBlock: block)
    }
    
    func loadUsefulRecheckCards() -> [RetroactCheckCard] {
        return RetroactCheckCardDBManager.shared.usefullRecheckCards()
    }
    
    func updateHabit(forHabit habit: Habit, recheckIn recheckDate: Date, recheckCard card: RetroactCheckCard, completionBlock block: (() -> Void)?) {
        updateHabit(forHabit: habit, checkIn: recheckDate, completionBlock: block)
        
        
        card.habitId = habit.id
        card.retroactCheckDate = recheckDate
        RetroactCheckCardDBManager.shared.updateRecheckCard(card: card)
    }
    
    
    func loadAllDbHabit() {
        HabitDBManager.shared.queryAllHabits { habits in
            for habit in habits {
                ompLog(habit.checkInDays)
            }
        }
    }
    
    func didGainGold(whenCheck habit: Habit) -> Promise<Bool> {
        let promise = GoldDBManager.shared.insertTable(whenCheck: habit)
        return promise
    }
}

extension HomeInteractor {
    fileprivate func filterHaibts(habits: [Habit], compareRange: HabitCheckTimeRange) -> CheckRangeHaibtDictionary? {
        let filteredHabits = habits
            .filter { return $0.checkRange == compareRange }
        if filteredHabits.count > 0 {
            return [compareRange: filteredHabits]
        }
        return nil
    }
}
