//
//  HomeMenu.swift
//  day21
//
//  Created by flion on 2019/1/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import Parchment

struct HomeMenuModel: PagingItem, Hashable, Comparable {
    var date = Date()
    var index: Int = 0
    
    init(date: Date, index: Int) {
        self.date = date
        self.index = index
    }
    
    var hashValue: Int { return date.hashValue }
    static func <(lhs: HomeMenuModel, rhs: HomeMenuModel) -> Bool {
        return lhs.date < rhs.date
    }
    
    static func ==(lhs: HomeMenuModel, rhs: HomeMenuModel) -> Bool {
        return (lhs.date == rhs.date &&
            lhs.index == rhs.index
        )
    }
}

extension HomeMenuModel {
    var weekdayText: String {
        if date.compare(.isToday) {
            return "今日"
        }
        let weekday = date.weekday
        guard weekday >= 1 && weekday <= 7 else {
            fatalError("OUT OF RANGE IN A WEEK")
        }
        switch weekday {
        case 1:
            return "周一"
        case 2:
            return "周二"
        case 3:
            return "周三"
        case 4:
            return "周四"
        case 5:
            return "周五"
        case 6:
            return "周六"
        case 7:
            return "周日"
        default:
            return "周六"
        }
    }
    
    var datedayText: String {
        return date.string(withFormat: "dd")
    }
}
