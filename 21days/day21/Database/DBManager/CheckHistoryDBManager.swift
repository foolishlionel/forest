//
//  CheckInDBManager.swift
//  day21
//
//  Created by flion on 2019/1/4.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import SQLite
import Promise
import SwiftyJSON

class CheckHistoryDBManager: DBManagerable {
    static let shared = CheckHistoryDBManager()
    
    fileprivate let dbHandle = DatabaseHandleProvider.shared.db
    fileprivate let checkInTbl = Table("TBLCheckIn")
    
    fileprivate let idCol = Expression<Int64>("id")
    fileprivate let habitIdCol = Expression<Int64>("habitId")
    fileprivate let habitNameCol = Expression<String>("habitName")
    fileprivate let checkInDateCol = Expression<Date>("checkInDate")
    fileprivate let isDeleteCol = Expression<Bool>("isDelete")
    fileprivate let recheckDateCol = Expression<Date?>("recheckDate")
}

extension CheckHistoryDBManager {
    func createTable() {
        try! dbHandle.run(checkInTbl.create(ifNotExists: true) { t in
            t.column(idCol, primaryKey: true)
            t.column(habitIdCol)
            t.column(habitNameCol)
            t.column(checkInDateCol)
            t.column(isDeleteCol)
            t.column(recheckDateCol)
        })
    }
}

extension CheckHistoryDBManager {
    
    func didCheckIn(forHabit habit: Habit, checkInDate date: Date) {
        
        queryCheckInDates(forHabit: habit.id, inDate: date) { [weak self] historysInDate in
            
            guard let wself = self else { return }
            
            let checkCountInDate = historysInDate.count
            var attemptCount: Int = 0
            if case .everyDay(_, let count) = habit.checkRate {
                attemptCount = count
            }
            
            if (checkCountInDate < attemptCount) {
                // 未达到“计划签到”次数
                wself.insertTodayCheckDate(forHabit: habit)
            } else if checkCountInDate == attemptCount {
                // 已达到“计划签到”次数
                ompLog(historysInDate.map { $0.checkInDate })
            }
        }
    }
    
    func queryCheckInHistory() -> Promise<[CheckHistory]> {
        let promise = Promise<[CheckHistory]>(work: { [weak self] fullfill, reject in
            guard let wself = self else { return }
            let historys = wself.allCheckedHistory().sorted(by: { left, right in
                return left.checkInDate > right.checkInDate
            })
            fullfill(historys)
        })
        return promise
    }
    
    fileprivate func queryCheckInDates(forHabit habitId: Int64, inDate date: Date, completionBlock block: (([CheckHistory]) -> Void)?) {
        var checkInHistorys = [CheckHistory]()
        
        for result in try! dbHandle.prepare(checkInTbl.filter(habitIdCol == habitId)) {
            let id = result[idCol]
            let habitName = result[habitNameCol]
            let checkInDate = result[checkInDateCol]
            
            if checkInDate.compare(.isSameDay(as: date)) {
                let history = CheckHistory(
                    id: id,
                    habitId: habitId,
                    habitName: habitName,
                    checkInDate: checkInDate
                )
                
                checkInHistorys.append(history)
            }
            
        }
        block?(checkInHistorys)
    }
    
    func checkedInItems(forHabit habitId: Int64) -> [CheckHistory] {
        var historys = [CheckHistory]()
        for result in try! dbHandle.prepare(checkInTbl.filter(
            habitIdCol == habitId
        )) {
            let id = result[idCol]
            let habitName = result[habitNameCol]
            let checkDate = result[checkInDateCol]
            
            let history = CheckHistory(
                id: id,
                habitId: habitId,
                habitName: habitName,
                checkInDate: checkDate
            )
            
            historys.append(history)
        }
        return historys
    }
    
    fileprivate func allCheckedHistory() -> [CheckHistory] {
        var allHistory = [CheckHistory]()
        for result in try! dbHandle.prepare(checkInTbl) {
            let id = result[idCol]
            let habitId = result[habitIdCol]
            let name = result[habitNameCol]
            let checkDate = result[checkInDateCol]
            
            let history = CheckHistory(
                id: id,
                habitId: habitId,
                habitName: name,
                checkInDate: checkDate
            )
            allHistory.append(history)
        }
        return allHistory
    }
    
}


extension CheckHistoryDBManager {
    
    fileprivate func insertTodayCheckDate(forHabit habit: Habit) {
        // 未签到 数据库更新签到数据
        let current = Date.current()
        
        try! dbHandle.run(checkInTbl.insert(
            habitIdCol <- habit.id,
            habitNameCol <- habit.name,
            checkInDateCol <- current,
            isDeleteCol <- false
        ))
    }
    
    fileprivate func addTodayCheckDate(forHabit habit: Habit) {
        let current = Date.current()
        var checks = Array(habit.checkInDays)
        checks.append(current)
        let checkDatas = try! JSON(checks.map { $0.string(withFormat: Habit.kDefaultTimeFormat) }).rawData()
        
        let specifyCheckInTbl = checkInTbl.filter(habit.id == habitIdCol && checkInDateCol == current)
        
        try! dbHandle.run(specifyCheckInTbl.update(
            
        ))
        
    }
    
    fileprivate func removeTodayCheckDate(forHabit habit: Habit) {
        var checks = Array(habit.checkInDays).sorted(by: <)
        checks.removeLast()
        let checkDatas = try! JSON(checks.map{ $0.string(withFormat: Habit.kDefaultTimeFormat) }).rawData()
        let specifyCheckInTbl = checkInTbl.filter(habit.id == rowid)
        try! dbHandle.run(specifyCheckInTbl.update(
            
        ))
    }
}
