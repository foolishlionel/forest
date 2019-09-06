//
//  ModifyPresenter.swift
//  day21
//
//  Created by flionel on 2018/11/23.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import TableKit

class ModifyPresenter: NSObject {
    fileprivate var tableDirector: TableDirector!
    init(tableView: UITableView) {
        super.init()
        tableDirector = TableDirector(
            tableView: tableView,
            shouldUsePrototypeCellHeightCalculation: true)
//        makeSections(habit: Habit())
    }
    
    
    
//    func makeSections(habit: Habit) {
//        let nameRow = TableRow<HabitNameTableCell>()
//    }
}
