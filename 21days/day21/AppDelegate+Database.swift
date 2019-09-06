//
//  AppDelegate+Database.swift
//  day21
//
//  Created by flion on 2018/11/21.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

extension AppDelegate {
    func installAppDatabase() {
        HabitDBManager.shared.createTable()
        CheckHistoryDBManager.shared.createTable()
        RetroactCheckCardDBManager.shared.createTable()
        GoldDBManager.shared.createTable()
    }
}
