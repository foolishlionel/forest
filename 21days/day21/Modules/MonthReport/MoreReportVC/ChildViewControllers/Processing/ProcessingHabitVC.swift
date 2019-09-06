//
//  ProcessingHabitVC.swift
//  day21
//
//  Created by flion on 2018/12/26.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import TableKit

class ProcessingHabitVC: UIViewController, OMPTableControllerType {

    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var tableDirector: TableDirector = {
        let director = TableDirector(
            tableView: tableView,
            shouldUsePrototypeCellHeightCalculation: true
        )
        return director
    }()
    
    fileprivate let interactor = ManagedHabitInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        loadDBProcessingHabits()
    }
    
    fileprivate func loadDBProcessingHabits() {
        interactor.loadProcessingHabits { [weak self] habits in
            guard let wself = self else { return }
            wself.createProcessingRows(habits: habits)
        }
    }
    
    fileprivate func createProcessingRows(habits: [Habit]) {
        let rowAction = processingRowAction(habits: habits)
        let processingRows = habits
            .map { ProcessingCellViewModel(habit: $0) }
            .map { TableRow<ProcessingHabitTableCell>(item: $0, actions: [rowAction]) }
        tableDirector.append(rows: processingRows)
        tableDirector.reload()
    }
    
    fileprivate func processingRowAction(habits: [Habit]) -> TableRowAction<ProcessingHabitTableCell> {
        let clickAction = TableRowAction<ProcessingHabitTableCell>(.click) { [unowned self] options in
            let index = options.indexPath.row
            let habit = habits[index]
            let modifyVC = ModifyHabitViewController.init(habit: habit)
            self.navigationController?.pushViewController(modifyVC, animated: true)
            ompLog(self.navigationController)
        }
        return clickAction
    }
}
