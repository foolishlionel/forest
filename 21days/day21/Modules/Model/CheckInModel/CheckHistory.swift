//
//  CheckHistory.swift
//  day21
//
//  Created by flion on 2019/1/8.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

struct CheckHistory {
    var id: Int64 = 0
    var habitId: Int64 = 0
    var habitName: String = ""
    var checkInDate = Date.current()
    
    init(
        id: Int64,
        habitId: Int64,
        habitName: String,
        checkInDate: Date = Date.current()
        ) {
        self.id = id
        self.habitId = habitId
        self.habitName = habitName
        self.checkInDate = checkInDate
    }
}
