//
//  HabitCategory.swift
//  day21
//
//  Created by flion on 2018/12/3.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

enum HabitCategory: Int {
    case life = 0
    case health = 1
    case sport = 2
    case learn = 3
    case emotion = 4
    case other = 5
    case empty = 6
    
    var chName: String {
        switch self {
        case .life:
            return "日常" // 日常生活
        case .health:
            return "健康"
        case .sport:
            return "运动"
        case .learn:
            return "学习"
        case .emotion:
            return "情感"
        case .other:
            return "其他"
        case .empty:
            fatalError("空空")
        }
    }
    
    var enName: String {
        switch self {
        case .life:
            return "Life"
        case .health:
            return "Health"
        case .sport:
            return "Sport"
        case .learn:
            return "Learn"
        case .emotion:
            return "Emotion"
        case .other:
            return "Other"
        case .empty:
            fatalError("Empty")
        }
    }
}

