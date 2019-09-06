//
//  SupplimentCheckCardDBManager.swift
//  day21
//
//  Created by flion on 2019/1/16.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import SQLite

class RetroactCheckCardDBManager: DBManagerable {
    static let shared = RetroactCheckCardDBManager()
    
    fileprivate let dbHandle = DatabaseHandleProvider.shared.db
    fileprivate let retroactCheckTbl = Table("TBLRetroactCheckCard")
    
    fileprivate let idCol = Expression<Int64>("id")
    fileprivate let habitIdCol = Expression<Int64?>("habitId")
    fileprivate let createdAtCol = Expression<Date>("createdAt")
    fileprivate let retroactCheckDateCol = Expression<Date?>("retroactCheckInDate")
    fileprivate let isPaidCol = Expression<Bool>("isPaid")
    fileprivate let isDeleteCol = Expression<Bool>("isDelete")
    
}

extension RetroactCheckCardDBManager {
    func createTable() {
        
//        try! dbHandle.run(retroactCheckTbl.drop())
        
        try! dbHandle.run(retroactCheckTbl.create(ifNotExists: true) { t in
            t.column(idCol, primaryKey: true)
            t.column(habitIdCol)
            t.column(createdAtCol)
            t.column(retroactCheckDateCol)
            t.column(isPaidCol)
            t.column(isDeleteCol)
        })
    }
    
    func insertTable(card: RetroactCheckCard, completionBlock block: ((Bool) -> Void)?) {
        do {
            let createdAt = card.createdAt
            let habitId = card.habitId
            let reCheckDate = card.retroactCheckDate
            let isPaid = card.isPaid
            
            try dbHandle.run(retroactCheckTbl.insert(
                createdAtCol <- createdAt,
                habitIdCol <- habitId,
                retroactCheckDateCol <- reCheckDate,
                isPaidCol <- isPaid,
                isDeleteCol <- false
            ))
            
            block?(true)
        } catch {
            block?(false)
        }
    }
}

extension RetroactCheckCardDBManager {
    func usefullRecheckCards() -> [RetroactCheckCard] {
        var recheckCards = [RetroactCheckCard]()
        for result in try! dbHandle.prepare(retroactCheckTbl.filter(
            isDeleteCol == false &&
            habitIdCol == nil &&
            retroactCheckDateCol == nil
        )) {
            
            let id = result[idCol]
            let createdAt = result[createdAtCol]
            let isPaid = result[isPaidCol]
            
            let recheckCard = RetroactCheckCard(id: id, habitId: nil, createdAt: createdAt, retroactCheckDate: nil, isPaid: isPaid)
            
            recheckCards.append(recheckCard)
        }
        return recheckCards
    }
    
    func updateRecheckCard(card: RetroactCheckCard) {
        try! dbHandle.run(retroactCheckTbl.update(
            isDeleteCol <- true,
            habitIdCol <- card.habitId,
            retroactCheckDateCol <- card.retroactCheckDate
        ))
    }
}
