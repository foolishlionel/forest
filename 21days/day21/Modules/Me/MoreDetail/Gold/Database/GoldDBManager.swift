//
//  GoldDBManager.swift
//  day21
//
//  Created by flion on 2019/2/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import SQLite
import Promise

class GoldDBManager: DBManagerable {
    
    static let shared = GoldDBManager()
    
    fileprivate let dbHandle = DatabaseHandleProvider.shared.db
    fileprivate let goldTbl = Table("TBLGoldHistory")
    
    fileprivate let idCol = Expression<Int64>("id")
    fileprivate let habitIdCol = Expression<Int64>("habitId")
    fileprivate let habitNameCol = Expression<String>("habitName")
    fileprivate let opreateDateCol = Expression<Date>("opreatDate")
    fileprivate let valueCol = Expression<Int>("value")
    fileprivate let flowCol = Expression<Int>("flow")
    
    func createTable() {
        try! dbHandle.run(goldTbl.create(ifNotExists: true, block: { t in
            t.column(idCol, primaryKey: true)
            t.column(habitIdCol)
            t.column(habitNameCol)
            t.column(opreateDateCol)
            t.column(valueCol)
            t.column(flowCol)
        }))
    }
    
}

extension GoldDBManager {
    func insertTable(whenCheck habit: Habit) -> Promise<Bool> {
        let promise = Promise<Bool>()
        do {
            let habitId = habit.id
            let name = habit.name
            let date = Date()
            let value = 100
            let flow = GoldFlow.check.rawValue
            
            try dbHandle.run(goldTbl.insert(
                habitIdCol <- habitId,
                habitNameCol <- name,
                opreateDateCol <- date,
                valueCol <- value,
                flowCol <- flow
                )
            )
            promise.fulfill(true)
        } catch let except {
            ompLog("INSERT ERROR")
            ompLog(except)
            promise.fulfill(false)
        }
        return promise
    }
    
    func insertTable(whenBuy feed: Int) {
        
    }
    
    func insertTable(whenExchange steps: Int) {
        
    }
    
    func queryGoldHistory() -> Promise<[Gold]> {
        
        var golds = [Gold]()
        for result in try! dbHandle.prepare(goldTbl) {
            let id = result[idCol]
            let habitId = result[habitIdCol]
            let habitName = result[habitNameCol]
            let date = result[opreateDateCol]
            let value = result[valueCol]
            let flow = GoldFlow(rawValue: result[flowCol]) ?? .check
            
            let gold = Gold(
                id: id,
                habitId: habitId,
                habitName: habitName,
                operateDate: date,
                value: value,
                flow: flow
            )
            golds.append(gold)
        }
        
//        let promise = Promise<[Gold]>
        
        return Promise<[Gold]>(work: { fulfill, _ in
            fulfill(golds)
        })
    }
}
