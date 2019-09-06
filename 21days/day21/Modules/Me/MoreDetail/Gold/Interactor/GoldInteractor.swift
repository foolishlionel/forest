//
//  GoldInteractor.swift
//  day21
//
//  Created by flion on 2019/2/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import Promise

class GoldInteractor: NSObject {
    func didCheckHabit(forHabit habit: Habit) {
        GoldDBManager.shared.insertTable(whenCheck: habit)
    }
    
    func loadGoldHistory() -> Promise<[Gold]> {
        return GoldDBManager.shared.queryGoldHistory()
    }
}
