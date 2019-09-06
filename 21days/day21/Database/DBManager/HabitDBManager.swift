//
//  HabitDBManager.swift
//  day21
//
//  Created by flion on 2018/11/15.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON
import Promise

class HabitDBManager: DBManagerable {
    
    static let shared = HabitDBManager()
    
    fileprivate let dbHandle = DatabaseHandleProvider.shared.db
    fileprivate let habitTbl = Table("TBLHabit")
    
    fileprivate let idCol = Expression<Int64>("id")
    fileprivate let nameCol = Expression<String>("name")
    fileprivate let createdAtCol = Expression<Date>("createdAt")
    fileprivate let startedAtCol = Expression<Date>("startedAt")
    fileprivate let goalCol = Expression<Int>("goal")
    fileprivate let repeatCountCol = Expression<Int>("repeatCount")
    fileprivate let repeatDaysCol = Expression<Data?>("repeatDays")
    fileprivate let openRemindCol = Expression<Bool>("isOpenRemind")
    fileprivate let remindTimesCol = Expression<Data?>("remindTimes")
    fileprivate let categoryCol = Expression<Int>("category")
    fileprivate let iconCol = Expression<Int>("icon")
    fileprivate let colorCol = Expression<Int>("color")
    fileprivate let encourageWordsCol = Expression<String?>("encourageWords")
    fileprivate let checkRangeCol = Expression<Int>("checkRange")
    fileprivate let isArchiveCol = Expression<Bool>("isArchive")
    fileprivate let isDeleteCol = Expression<Bool>("isDelete")
    
}

/// MARK: CREATE `HABIT` TABLE
extension HabitDBManager {
    func createTable() {
        try! dbHandle.run(habitTbl.create(ifNotExists: true) { t in
            t.column(idCol, primaryKey: true)
            t.column(nameCol)
            t.column(categoryCol)
            t.column(createdAtCol)
            t.column(startedAtCol)
            t.column(iconCol)
            t.column(openRemindCol)
            t.column(colorCol)
            t.column(goalCol)
            t.column(remindTimesCol)
            t.column(repeatCountCol)
            t.column(repeatDaysCol)
            t.column(encourageWordsCol)
            t.column(checkRangeCol)
            t.column(isArchiveCol)
            t.column(isDeleteCol)
        })
    }
}

/// MARK: CREATE A `HABIT`
extension HabitDBManager {
    func insertTable(habit: Habit, succeedBlock block: BooleanBlock?) {
        do {
            let habitName = habit.name
            let colorValue = habit.mirror.color.rawValue
            let createdAt = habit.createdAt
            let startedAt = habit.startedAt
            let iconValue = habit.mirror.icon.rawValue
            let categoryValue = habit.mirror.category.rawValue
            let goalValue = habit.goal.rawValue
            let word = habit.encourgeWords ?? ""
            
            var repeatCount: Int = 1
            var repeatDays: Set<WeekDay> = []
            
            if case .everyDay(let days, let count) = habit.checkRate {
                repeatCount = count
                repeatDays = days
            }
            
            let repeatSet = repeatDays.sorted { $0.rawValue < $1.rawValue }.map { $0.rawValue }
            let repeatDaysData = try JSON(repeatSet).rawData()
            
            let isOpenRemind = habit.isOpenRemind
            let reminds = habit.remindTimes.sorted { $0 < $1 }
            let remindTimes = try JSON(reminds).rawData()
            let checkRange = habit.checkRange.rawValue
            let isArchive = habit.isArchive
            let isDelete = habit.isDelete
            
            try! dbHandle.run(
                habitTbl.insert(
                    nameCol <- habitName,
                    colorCol <- colorValue,
                    categoryCol <- categoryValue,
                    createdAtCol <- createdAt,
                    startedAtCol <- startedAt,
                    openRemindCol <- isOpenRemind,
                    remindTimesCol <- remindTimes,
                    repeatCountCol <- repeatCount,
                    repeatDaysCol <- repeatDaysData,
                    iconCol <- iconValue,
                    goalCol <- goalValue,
                    checkRangeCol <- checkRange,
                    encourageWordsCol <- word,
                    isArchiveCol <- isArchive,
                    isDeleteCol <- isDelete
            ))
            block?(true)
        } catch {
            block?(false)
        }
    }
}

/// MARK: UPDATE A `HABIT`
extension HabitDBManager {
    
    func updateHabit(withHabit newHabit: Habit, completeBlock block:((_ succeed: Bool) -> Void)?) {
        
        queryHabit(withId: newHabit.id) { [weak self] cachedHabit in
            guard let wself = self else { return }
            guard let cachedHabit = cachedHabit else { return }
            
            block?(true)
        }
    }
    
    func updateHabit(forHabit habit: Habit, checkIn date: Date, completionBlock block:(() -> Void)?) {
        
        CheckHistoryDBManager.shared.didCheckIn(forHabit: habit, checkInDate: date)
        block?()
    }
}

/// MARK: DELETE A `HABIT`
extension HabitDBManager {
    func deleteHabit(habit: Habit, completionBlock block:(() -> Void)?) {
        guard habit.id != 0 else { return }
        let habit = habitTbl.filter(habit.id == rowid)
        try! dbHandle.run(habit.delete())
        block?()
    }
}

/// MARK: QUERY A `HABIT` or SPEC `HABIT`
extension  HabitDBManager {
    
    func queryHabits(inDate date: Date, completionBlock block: (([Habit]) -> Void)?) {
        var habits = [Habit]()
        for result in try! dbHandle.prepare(habitTbl.filter(isDeleteCol == false && isArchiveCol == false)) {
            let createdAt = result[createdAtCol]
            let isLessOrEqual = createdAt.isLessOrEqual(compare: date)
            if (isLessOrEqual) {
                let habit = generateHabit(fromTableRow: result)
                habits.append(habit)
            }
        }
        block?(habits)
    }
    
    func queryTodayHabits(completeBlock block: HabitsBlock?) {
        // 今日习惯，只统计未"归档"和未"删除"的习惯
        allExistingHaibts { habits in
            block?(habits)
        }
    }
    
    func queryThisWeekHabits(completeBlock block: HabitsBlock?) {
        // 本周习惯，只统计未"归档"和未"删除"的习惯
        allExistingHaibts { habits in
            block?(habits)
        }
    }
    
    func queryThisYearHabits(completeBlock block: HabitsBlock?) {
        allExistingHaibts { habits in
            // ⚠️⚠️为了方便和简洁⚠️⚠️
            // ⚠️⚠️只统计正在进行中的习惯⚠️⚠️
            // ⚠️⚠️而不统计已删除和已归档的习惯⚠️⚠️
            block?(habits)
        }
    }
    
    func queryHabitsBefore(timeGap: BeforeTimeGap, compare: Date, completeBlock block: HabitsBlock?) {
        allExistingHaibts { habits in
            if let temps = habits {
                let gapValue = timeGap.rawValue
                let dayInPast = compare.dateBefore(days: gapValue)
                let habitsInPast = temps.filter { $0.createdAt > dayInPast }
                block?(habitsInPast)
            } else {
                block?(nil)
            }
        }
    }
    
    func queryHabits(isProcessing: Bool, completionBlock block: (([Habit]) -> Void)?) {
        if isProcessing {
            let results = try! dbHandle.prepare(habitTbl.filter(isDeleteCol == false && isArchiveCol == false))
            let habits = results.map { generateHabit(fromTableRow: $0) }
            block?(habits)
        } else {
            let results = try! dbHandle.prepare(habitTbl.filter(isDeleteCol == false && isArchiveCol == true))
            let habits = results
                .map { generateHabit(fromTableRow: $0) }
                .filter { habit in
                    let goalDays = habit.goal.rawValue
                    let createdAt = habit.createdAt
                    let passedDays = createdAt.daysBetweenDate(toDate: Date())
                    return (goalDays - passedDays) > 0
            }
            block?(habits)
        }
    }
    
    func queryAllHabits(completionBlock block: (([Habit]) -> Void)?) {
        var habits = [Habit]()
        
        for result in try! dbHandle.prepare(habitTbl.filter(isDeleteCol == false)) {
            let habit = generateHabit(fromTableRow: result)
            habits.append(habit)
        }
        block?(habits)
    }
    
    func queryMonthHabits(compare specDate: Date, block: (([Habit]) -> Void)?) {
        
        var habits = [Habit]()
        for result in try! dbHandle.prepare(habitTbl.filter(isDeleteCol == false)) {
            let habit = generateHabit(fromTableRow: result)
            let habitCreatedAt = habit.createdAt
            let startDateOfMonth = specDate.startOfCurrentMonth()
            let endDateOfMonth = specDate.endOfCurrentMonth()
            
            if habitCreatedAt < startDateOfMonth && !habitCreatedAt.compare(.isSameDay(as: specDate)) {
                let gapDays = habitCreatedAt.daysBetweenDate(toDate: specDate) + 1
                if gapDays <= 21 {
                    habits.append(habit)
                }
            }
            
            if habitCreatedAt.isSameYearMonth(compareDate: specDate) {
                habits.append(habit)
            }
            
//            // 筛选出 "创建时间在本月" 以及 "目标到期日在本月"的 习惯
//            if habitCreatedAt <= endOfMonth && habitCreatedAt >= startOfMonth {
//                let gap = habitCreatedAt.daysBetweenDate(toDate: endOfMonth)
//                guard gap >= 0 else { continue }
//                habits.append(habit)
//            }
        }
        let sortedHabits = habits.sorted { return $0.createdAt < $1.createdAt }
        block?(sortedHabits)
    }
    
    fileprivate func queryHabit(withId id: Int64, completionBlock block: ((Habit?) -> Void)?) {
        
        var habit: Habit?
        for result in try! dbHandle.prepare(habitTbl.filter(id == rowid)) {
            habit = generateHabit(fromTableRow: result)
            if habit != nil { break }
        }
        block?(habit)
    }
}

extension HabitDBManager { 
    
    fileprivate func generateHabit(fromTableRow row: Row) -> Habit {
        let id = row[idCol]
        let name = row[nameCol]
        let createdAt = row[createdAtCol]
        let startedAt = row[startedAtCol]
        let goal = HabitGoal(rawValue: row[goalCol]) ?? .day7
        let reeatDays = transformRepeatDays(data: row[repeatDaysCol]) ?? []
        let repeatCount = row[repeatCountCol]
        let checkRate: CheckRateType = .everyDay(days: reeatDays, count: repeatCount)
        let isOpenRemind = row[openRemindCol]
        let remindTimes = transformRemindTimes(data: row[remindTimesCol]) ?? []
        let category = HabitCategory(rawValue: row[categoryCol]) ?? .life
        let icon = HabitIcon(rawValue: row[iconCol]) ?? .walk
        let color = HabitColor(rawValue: row[colorCol]) ?? .color0
        let words = row[encourageWordsCol]
        let checkInDates = currentCheckInDates(habitId: id)
        let checkRange = HabitCheckTimeRange(rawValue: row[checkRangeCol]) ?? .anyTime
        let isArchive = row[isArchiveCol]
        let isDelete = row[isDeleteCol]
        let mirror = HabitMirror(icon: icon, color: color, category: category)
        
        let habit = Habit(
            id: id,
            name: name,
            createdAt: createdAt,
            startedAt: startedAt,
            isOpenRemind: isOpenRemind,
            remindTimes: remindTimes,
            goal: goal,
            mirror: mirror,
            encourageWords: words,
            checkInDays: checkInDates,
            checkRange: checkRange,
            isArchive: isArchive,
            isDelete: isDelete,
            checkRate: checkRate
        )
        return habit
    }
    
    fileprivate func transformRemindTimes(data: Data?) -> Set<String>? {
        guard let temp = data else { return nil }
        if let times = try! JSONSerialization.jsonObject(with: temp) as? [String] {
            return Set<String>(times)
        }
        return nil
    }
    
    fileprivate func currentCheckInDates(habitId: Int64) -> Set<Date> {
        let checkInArray = CheckHistoryDBManager.shared.checkedInItems(forHabit: habitId)
//            .filter { $0.checkCount() > 0 }
            .map { $0.checkInDate }
            .sorted { date0, date1 in
                return date0 < date1
        }
        return Set<Date>.init(checkInArray)
    }
    
    fileprivate func transformRepeatDays(data: Data?) -> Set<WeekDay>? {
        guard let temp = data else { return nil }
        if let repeats = try! JSON(data: temp).arrayObject {
            ompLog(repeats)
            let days: [WeekDay] = repeats.map { WeekDay(rawValue: $0 as! Int) ?? .monday }
            ompLog(days)
            return Set<WeekDay>(days)
        }
        return nil
    }
    
    fileprivate func transformCheckInDay(data: Data?) -> Set<String>? {
        guard let temp = data else { return nil }
        if let checkIns = try! JSONSerialization.jsonObject(with: temp) as? [String] {
            return Set<String>(checkIns)
        }
        return nil
    }
    
}

extension HabitDBManager {
    fileprivate func allExistingHaibts(completeBlock block: HabitsBlock?) {
        
        var habits = [Habit]()
        
        do {
            for result in try dbHandle.prepare(habitTbl.filter(isDeleteCol == false && isArchiveCol == false)) {
                let habit = generateHabit(fromTableRow: result)
                habits.append(habit)
            }
            block?(habits)
        } catch let error {
            ompLog("ERROR HAPPENED: \(error)")
            block?(nil)
        }
    }
    
    fileprivate func allValidHabits(completeBlock block: HabitsBlock?) {
        var habits = [Habit]()
        do {
            for result in try dbHandle.prepare(habitTbl.filter(isDeleteCol == false)) {
                let habit = generateHabit(fromTableRow: result)
                habits.append(habit)
            }
            block?(habits)
        } catch let error {
            ompLog("ERROR HAPPENED: \(error)")
            block?(nil)
        }
    }
}
