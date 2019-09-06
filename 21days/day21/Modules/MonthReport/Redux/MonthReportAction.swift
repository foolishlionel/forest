//
//  MonthReportAction.swift
//  day21
//
//  Created by flion on 2019/1/23.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import ReSwift

enum MonthReportAction: Action {
    case clickPrevious
    case clickNext
    case loadHabits(habits: [Habit])
}
