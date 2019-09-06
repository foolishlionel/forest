//
//  MonthReportState.swift
//  day21
//
//  Created by flion on 2019/1/23.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import ReSwift

struct MonthReportState: StateType {
    var selectMonth = Date()
    var isNextButtonClickEnabled: Bool = false
    var secondMenuVMs: [SecondMenuCellViewModel] = []
    var habits = [Habit]()
}
