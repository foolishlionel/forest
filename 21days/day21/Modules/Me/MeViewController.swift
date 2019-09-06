//
//  MeViewController.swift
//  day21
//
//  Created by flion on 2019/1/17.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class MeViewController: UIViewController, OMPTableControllerType {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector = TableDirector(
                tableView: tableView,
                shouldUsePrototypeCellHeightCalculation: true
            )
        }
    }
    
    fileprivate var tableDirector: TableDirector!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        let headerRow = TableRow<MeHeaderTableCell>(item: Date())
        let secondaryRow = TableRow<MeSecondaryOptionCell>(item: Date(), actions: [checkHistoryAction(), goldHistoryAction()])
        let gamingRow = TableRow<MeGamingTableCell>(item: Date())
        let settingRow = TableRow<MeSettingTableCell>(item: Date())
        
        tableDirector.append(rows: [headerRow, secondaryRow, gamingRow, settingRow])
    }
    
    fileprivate func checkHistoryAction() -> TableRowAction<MeSecondaryOptionCell> {
        let action = TableRowAction<MeSecondaryOptionCell>(MeTableCellActions.checkHistory) { [weak self] option in
            guard let wself = self else { return }
            let checkHistoryVC = CheckHistoryViewController()
            wself.navigationController?.pushViewController(checkHistoryVC, animated: true)
        }
        return action
    }
    
    fileprivate func goldHistoryAction() -> TableRowAction<MeSecondaryOptionCell> {
        let action = TableRowAction<MeSecondaryOptionCell>(MeTableCellActions.goldHistory) { [weak self] option in
            guard let wself = self else { return }
            let goldVC = GoldViewController()
            wself.navigationController?.pushViewController(goldVC, animated: true)
        }
        return action
    }

}
