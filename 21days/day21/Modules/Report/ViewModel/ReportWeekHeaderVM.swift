//
//  ReportWeekHeaderVM.swift
//  day21
//
//  Created by flion on 2019/6/5.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct ReportWeekHeaderVM {
    fileprivate var habits: [Habit]?
    fileprivate var current = Date.current()
    
    init(habits: [Habit], current: Date = Date.current()) {
        self.habits = habits
        self.current = current
    }
    
    var progress: Float {
        guard let temps = habits else { return 0.0 }
        guard temps.count > 0 else { return 0.0 }
        
        let totalCount = temps.count * 7
        var checkedCount = 0
        
        let startOfWeek = current.startOfCurrentWeek()!
        let endOfWeek = current.endOfCurrentWeek()!
        
        for habit in temps {
            
            let checkedDays = habit.checkInDays
                .filter { $0 > startOfWeek && $0 < endOfWeek }
            checkedCount += checkedDays.count
        }
        
        let tempProgress = Float(checkedCount) / Float(totalCount)
        return tempProgress
        
    }
}
