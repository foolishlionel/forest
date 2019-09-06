//
//  MonthReportInteractor.swift
//  day21
//
//  Created by flion on 2019/1/18.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class MonthReportInteractor: NSObject {
    func loadExistedHabit(completionBlock block: (([Habit]) -> Void)?) {
        HabitDBManager.shared.queryAllHabits { habits in
            block?(habits)
        }
    }
    
    func loadMonthHabits(compare specDate: Date, completionBlock block: (([Habit]) -> Void)?) {
        HabitDBManager.shared.queryMonthHabits(compare: specDate, block: block)
    }
}
