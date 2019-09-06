//
//  RecheckViewController.swift
//  day21
//
//  Created by flion on 2019/1/16.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class RecheckViewController: UITableViewController {
    
    let recheckInteractor = RecheckInteractor()
    
    @IBOutlet weak var usefulRecheckCardCountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let usefulRecheckCards = recheckInteractor.loadUsefulRecheckCards()
        usefulRecheckCardCountLabel.text = " x \(usefulRecheckCards.count)"
    }
}
