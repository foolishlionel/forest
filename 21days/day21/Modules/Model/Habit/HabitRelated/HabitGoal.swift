//
//  HabitGoal.swift
//  day21
//
//  Created by flion on 2018/10/16.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

enum HabitGoal: Int {
    case day7 = 7
    case day21 = 21
    case day30 = 30
    case day365 = 365
    case forever = 9999
    
    var goalName: String {
        switch self {
        case .day7:
            return "7天"
        case .day21:
            return "21天"
        case .day30:
            return "一个月"
        case .day365:
            return "一年"
        case .forever:
            return "永远"
        }
    }
}
