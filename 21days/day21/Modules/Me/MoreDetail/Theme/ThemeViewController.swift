//
//  ThemeViewController.swift
//  day21
//
//  Created by flion on 2019/1/17.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class ThemeViewController: UIViewController, OMPTableControllerType {
    fileprivate var tableDirector: TableDirector!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector = TableDirector(
                tableView: tableView,
                shouldUsePrototypeCellHeightCalculation: true
            )
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        
        let action = TableRowAction<ThemeTableCell>(.click) { options in
            
        }
        let rows = [0, 1, 2].map { TableRow<ThemeTableCell>(item: $0, actions: [action]) }
        tableDirector.append(rows: rows)
        tableDirector.reload()
    }
}
