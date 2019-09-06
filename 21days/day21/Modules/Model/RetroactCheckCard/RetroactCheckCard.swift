//
//  RetroactCheckCard.swift
//  day21
//
//  Created by flion on 2019/1/16.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class RetroactCheckCard: NSObject {
    var id: Int64 = 0
    var habitId: Int64?
    var createdAt: Date
    var retroactCheckDate: Date?
    var isPaid: Bool = false
    
    init(id: Int64,
         habitId: Int64?,
         createdAt: Date,
         retroactCheckDate: Date?,
         isPaid: Bool
        ) {
        self.id = id
        self.habitId = habitId
        self.createdAt = createdAt
        self.retroactCheckDate = retroactCheckDate
        self.isPaid = isPaid
    }
}
