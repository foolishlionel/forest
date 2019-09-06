//
//  GoldViewController.swift
//  day21
//
//  Created by flion on 2019/2/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class GoldViewController: UIViewController {
    fileprivate var tableDirector: TableDirector!
    fileprivate let goldInteractor = GoldInteractor()
    
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
        goldInteractor.loadGoldHistory().then { golds in
            ompLog("golds is \(golds)")
        }
        
    }

}
