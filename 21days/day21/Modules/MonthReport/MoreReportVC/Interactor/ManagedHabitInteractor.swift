//
//  ManagedHabitInteractor.swift
//  day21
//
//  Created by flion on 2018/12/27.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class ManagedHabitInteractor: NSObject {
    
    func loadProcessingHabits(completionBlock block: (([Habit]) -> Void)?) {
        HabitDBManager.shared.queryHabits(isProcessing: true, completionBlock: block)
    }
    
    func loadCompletedHabits(completionBlock block: (([Habit]) -> Void)?) {
        HabitDBManager.shared.queryHabits(isProcessing: false, completionBlock: block)
    }
}
