//
//  Gold.swift
//  day21
//
//  Created by flion on 2019/2/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

enum GoldFlow: Int {
    case check = 0// (habitId: Int64, name: String, continuous: Int)
    case buyFeed = 1
    case stepsExchange = 2
}

struct Gold {
    var id: Int64 = 0
    var habitId: Int64 = 0
    var habitName: String = ""
    var operateDate: Date = Date()
    var value: Int = 0
    var flow: GoldFlow = .buyFeed
}
