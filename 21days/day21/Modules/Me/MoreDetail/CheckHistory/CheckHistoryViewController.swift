//
//  CheckHistoryViewController.swift
//  day21
//
//  Created by flion on 2019/2/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class CheckHistoryViewController: UIViewController, OMPTableControllerType {

    fileprivate var tableDirector: TableDirector!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector = TableDirector(
                tableView: tableView,
                shouldUsePrototypeCellHeightCalculation: true
            )
        }
    }
    fileprivate let historyInteractor = CheckHistoryInteractor()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        historyInteractor.loadAllCheckHistory().then { [weak self] sectionOfHistory in
            guard let wself = self else { return }
            
            for historys in sectionOfHistory {
                let historyRows = historys
                    .map { CheckHistoryViewModel(checkHistory: $0) }
                    .map { TableRow<CheckHistoryTableCell>(item: $0) }
                let section = TableSection.init(rows: historyRows)
                section.headerHeight = 25.0
                
//                let checkDates = Array(historys[0].checkDates)
//                section.headerView = wself.createHistoryScection(date: checkDates[0])
                wself.tableDirector.append(section: section)
            }
            
            wself.tableDirector.reload()
        }
    }
}

extension CheckHistoryViewController {
    func createHistoryScection(date: Date) -> UIView {
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 25))
        sectionView.backgroundColor = UIColor.white
        let checkMonthlabel = UILabel(frame: CGRect(x: 10, y: 0, width: kScreenWidth-10, height: 25.0))
        checkMonthlabel.text = checkDateText(date: date)
        sectionView.addSubview(checkMonthlabel)
        return sectionView
    }
    
    fileprivate func checkDateText(date: Date) -> String {
        if date.compare(.isToday) {
            return "今天"
        } else if date.compare(.isYesterday) {
            return "昨天"
        } else {
            return date.string(withFormat: "yyyyy-MM-dd")
        }
    }
}
