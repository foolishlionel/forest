//
//  CheckHistoryInteractor.swift
//  day21
//
//  Created by flion on 2019/2/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

import Promise

typealias CheckHistorySection = [[CheckHistory]]

class CheckHistoryInteractor: NSObject {
    func loadAllCheckHistory() -> Promise<CheckHistorySection> {
        
        let newPromise = Promise<CheckHistorySection>()
        
        let promise = CheckHistoryDBManager.shared.queryCheckInHistory()
        promise.then { [weak self] historys in
            guard let wself = self else { return }
            var historySectoin = CheckHistorySection()
            var tempHistorys = [CheckHistory]() // 临时变量
            for history in historys {
                
                if tempHistorys.count > 0 {
                    let firstHistory = tempHistorys[0]
                    if wself.isCheckAtSameDay(left: history, right: firstHistory) {
                        tempHistorys.append(history)
                    } else {
                        historySectoin.append(tempHistorys)
                        tempHistorys = [CheckHistory]()
                        tempHistorys.append(history)
                    }
                } else {
                    tempHistorys.append(history)
                }
            }
            historySectoin.append(tempHistorys)
            
            newPromise.fulfill(historySectoin)
        }
        
        return newPromise
    }
}

extension CheckHistoryInteractor {
    fileprivate func isCheckAtSameDay(left: CheckHistory, right: CheckHistory) -> Bool {
        
        let leftDate = left.checkInDate
        let rightDate = right.checkInDate

        return leftDate.compare(.isSameDay(as: rightDate))
    }
}
