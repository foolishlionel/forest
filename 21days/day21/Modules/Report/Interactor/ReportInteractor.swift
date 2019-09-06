//
//  ReportInteractor.swift
//  day21
//
//  Created by flionel on 2019/4/7.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import Promise

enum BeforeTimeGap: Int {
    case before30 = 30
    case before60 = 60
    case before90 = 90
    case before180 = 180
}

class ReportInteractor: NSObject {
    func todayHabits() -> Promise<[Habit]> {
        
        let promise = Promise<[Habit]>()
        HabitDBManager.shared.queryTodayHabits { habits in
            if let temps = habits {
                promise.fulfill(temps)
            } else {
                promise.reject(HabitError.queryFailed)
            }
        }
        return promise
    }
    
    func thisWeekHaits() -> Promise<[Habit]> {
        
        let promise = Promise<[Habit]>()
        
        HabitDBManager.shared.queryThisWeekHabits() { habits in
            if let temps = habits {
                promise.fulfill(temps)
            } else {
                promise.reject(HabitError.queryFailed)
            }
        }
        
        return promise
    }
    
    func thisYearHabits(today: Date) -> Promise<[Habit]> {
        
        
        
        let promise = Promise<[Habit]>()
        HabitDBManager.shared.queryThisYearHabits { habits in
            if let temps = habits {
                let startOfYear = today.startOfCurrentYear()
                let habitsOfYear = temps.filter { $0.createdAt > startOfYear }
                promise.fulfill(habitsOfYear)
            } else {
                promise.reject(HabitError.queryFailed)
            }
        }
        return promise
    }
    
    func completeRateDependOnEveryWeek(until today: Date) -> Promise<[CGFloat]> {
        
        let promise = Promise<[CGFloat]>()
        thisYearHabits(today: today).then { [weak self] habits in
            guard let wself = self else { return }
            let shouldTimes = wself.shouldCheckTimesEveryWeek(until: today, habits: habits)
            let alreadyTimes = wself.alreadyCheckTimeEveryWeek(until: today, habits: habits)
        }
        return promise
    }
    
    
    
    func habitsBefore30days(today: Date) -> Promise<[Habit]> {
        let promise = Promise<[Habit]>()
        HabitDBManager.shared.queryHabitsBefore(timeGap: .before30, compare: today) { habits in
            if let temps = habits {
                promise.fulfill(temps)
            } else {
                promise.reject(HabitError.queryFailed)
            }
        }
        return promise
    }
    
    func habitsBefore60days(today: Date) -> Promise<[Habit]> {
        let promise = Promise<[Habit]>()
        HabitDBManager.shared.queryHabitsBefore(timeGap: .before60, compare: today) { habits in
            if let temps = habits {
                promise.fulfill(temps)
            } else {
                promise.reject(HabitError.queryFailed)
            }
        }
        return promise
    }
    
    func habitsBefore90days(today: Date) -> Promise<[Habit]> {
        let promise = Promise<[Habit]>()
        HabitDBManager.shared.queryHabitsBefore(timeGap: .before90, compare: today) { habits in
            if let temps = habits {
                promise.fulfill(temps)
            } else {
                promise.reject(HabitError.queryFailed)
            }
        }
        
        return promise
    }
    
    func habitsBefore180days(today: Date) -> Promise<[Habit]> {
        let promise = Promise<[Habit]>()
        HabitDBManager.shared.queryHabitsBefore(timeGap: .before180, compare: today) { habits in
            if let temps = habits {
                promise.fulfill(temps)
            } else {
                promise.reject(HabitError.queryFailed)
            }
        }
        return promise
    }
}

extension ReportInteractor {
    fileprivate func shouldCheckTimesEveryWeek(until today: Date, habits: [Habit]) -> [Int] {
        let startOfYear = today.startOfCurrentYear()
        
        let weekComponents = DateHelper.weekComponentsOfThisYear(today: today)
        var shouldCheckTimes: [Int] = []
        for component in weekComponents {
            var insideShouldCheckCount: Int = 0
            for habit in habits {
                if habit.createdAt.isLessNotEqual(compare: startOfYear) {
                    
                    if case .everyDay(_, let count) = habit.checkRate {
                        let weekCheckCount = 7 * count
                        insideShouldCheckCount += weekCheckCount
                    }
                    
                } else {
                    let isLargerOrEqual = habit.createdAt.isLargerOrEqual(compare: component.start)
                    let isLessOrEqual = habit.createdAt.isLessOrEqual(compare: component.end)
                    let inRnage = isLargerOrEqual && isLessOrEqual
                    if !inRnage {
                        insideShouldCheckCount += 0
                    } else {
                        
                        if case .everyDay(_, let count) = habit.checkRate {
                            let weekCheckCount = 7 * count
                            insideShouldCheckCount += weekCheckCount
                        }
                    }
                }
            }
            shouldCheckTimes.append(insideShouldCheckCount)
        }
        
        
        return shouldCheckTimes
    }
    
    fileprivate func alreadyCheckTimeEveryWeek(until today: Date, habits: [Habit]) -> [Int] {
        
        let startOfYear = today.startOfCurrentYear()
        
        
        
        let weekComponents = DateHelper.weekComponentsOfThisYear(today: today)
        var alreadyCheckTimes: [Int] = []
        
        for component in weekComponents {
            
            var insideAlreadyCheckCount: Int = 0
            
            for habit in habits {
                if habit.createdAt.isLessNotEqual(compare: startOfYear) {
                    
                    if case .everyDay(_, let count) = habit.checkRate {
                        let weekCheckCount = 7 * count
                        insideAlreadyCheckCount += weekCheckCount
                    }
                    
                } else {
                    let isLargerOrEqual = habit.createdAt.isLargerOrEqual(compare: component.start)
                    let isLessOrEqual = habit.createdAt.isLessOrEqual(compare: component.end)
                    let inRnage = isLargerOrEqual && isLessOrEqual
                    if !inRnage {
                        insideAlreadyCheckCount += 0
                    } else {
                        
                        if case .everyDay(_, let count) = habit.checkRate {
                            let weekCheckCount = 7 * count
                            insideAlreadyCheckCount += weekCheckCount
                        }
                        
                    }
                }
            }
        }
        
        
        
        
        
        return []
    }
}
