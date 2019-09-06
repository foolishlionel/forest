//
//  CheckHistoryViewModel.swift
//  day21
//
//  Created by flion on 2019/2/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct CheckHistoryViewModel {
    fileprivate var history: CheckHistory!
    init(checkHistory: CheckHistory) {
        self.history = checkHistory
    }

    var habitName: String {
        return history.habitName
    }
    
//    var checkTime: String {
//        let checkDates = Array(history.checkDates)
//        return checkDates[0].string(withFormat: "hh:mm")
//    }
}
