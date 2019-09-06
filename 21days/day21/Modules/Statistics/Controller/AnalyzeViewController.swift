//
//  AnalyzeViewController.swift
//  day21
//
//  Created by flion on 2019/1/29.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class AnalyzeViewController: UIViewController, OMPTableControllerType {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(habit: Habit) {
        super.init(nibName: "AnalyzeViewController", bundle: nil)
        self.habit = habit
    }

    fileprivate var habit: Habit!
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
        initEnableModule()

        // Do any additional setup after loading the view.
        setupTableView()
        
        let calendarRow = TableRow<AnalyzeCalendarTableCell>(item: AnalyzeCalendarViewModel(habit: habit))
        let calendarSection = TableSection(rows: [calendarRow])
        let footer = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth - 20, height: 10))
        footer.backgroundColor = UIColor.clear
        calendarSection.footerView = footer
        
        let statisticRow = TableRow<AnalyzeStatisticTableCell>(item: AnalyzeStatisticViewModel(habit: habit))
        let statisticSection = TableSection(rows: [statisticRow])
        let footer1 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth - 20, height: 10))
        footer1.backgroundColor = UIColor.clear
        statisticSection.footerView = footer1
        
        let archiveRow = TableRow<AnalyzeArchiveTableCell>(item: nil)
        let archiveSection = TableSection.init(rows: [archiveRow])
        let footer2 = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth - 20, height: 10))
        footer2.backgroundColor = UIColor.clear
        archiveSection.footerView = footer2
        
        let deleteRow = TableRow<AnalyzeDeleteTableCell>(item: nil)
        let deleteSection = TableSection(rows: [deleteRow])
        
        tableDirector.append(sections: [calendarSection, statisticSection, archiveSection, deleteSection])
    }

}

extension AnalyzeViewController: OPNaviUniversalable {
    fileprivate func initEnableModule() {
        
        let backItem = OPNavigationBarItemMetric.back
        universal(model: backItem) { [weak self] _ in
            guard let wself = self else { return }
            wself.navigationController?.popViewController(animated: true)
        }
        
        let modifyItem = OPNavigationBarItemMetric.modify
        universal(model: modifyItem) { [weak self] _ in
            guard let wself = self else { return }
            let modifyVC = ModifyHabitViewController(habit: wself.habit)
            wself.navigationController?.pushViewController(modifyVC, animated: true)
        }
    }
}
