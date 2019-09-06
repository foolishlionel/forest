//
//  CheckRate.swift
//  day21
//
//  Created by flion on 2019/6/24.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

enum CheckRateType {
//    case everyWeek(count: Int)
    case everyDay(days: Set<WeekDay>, count: Int)
}
