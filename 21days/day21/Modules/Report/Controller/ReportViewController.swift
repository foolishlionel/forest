//
//  ReportViewController.swift
//  day21
//
//  Created by flionel on 2019/4/1.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class ReportViewController: UIViewController, OMPTableControllerType {

    fileprivate let current = Date.current()
    fileprivate var todayHabits = [Habit]()
    fileprivate var weekHabits = [Habit]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector = TableDirector(
                tableView: tableView,
                shouldUsePrototypeCellHeightCalculation: true
            )
        }
    }
    fileprivate var tableDirector: TableDirector!
    
    fileprivate let reportInteractor = ReportInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        queryReportHabits()
        reportInteractor.completeRateDependOnEveryWeek(until: Date.current()).then { rates in
            
        }
    }
}

extension ReportViewController {
    fileprivate func queryReportHabits() {
        let current = Date.current()
        
        let semaphore = DispatchSemaphore(value: 1)
        let globalQueue = DispatchQueue.global()
        let group = DispatchGroup()
        globalQueue.async(group: group) {
            semaphore.wait()
            self.reportInteractor.todayHabits().then({ [weak self] habits in
                guard let wself = self else { return }
                wself.createTodaySection(haits: habits)
                semaphore.signal()
            })
        }
        
        globalQueue.async(group: group) {
            semaphore.wait()
            self.reportInteractor.thisWeekHaits().then{ [weak self] habits in
                guard let wself = self else { return }
                wself.createWeekSection(weekHabits: habits)
                semaphore.signal()
            }
        }
        
        globalQueue.async(group: group) {
            semaphore.wait()
            self.reportInteractor.thisYearHabits(today: current).then { [weak self] habits in
                guard let wself = self else { return }
                wself.createCompleteRateSection()
                semaphore.signal()
            }
        }
        
        globalQueue.async(group: group) {
            semaphore.wait()
            self.reportInteractor.habitsBefore60days(today: current).then { habits in
                ompLog("habits is \(habits)")
                semaphore.signal()
            }
        }
        
//        globalQueue.async(group: group) {
//            semaphore.wait()
//            self.reportInteractor.thisMonthHabits().then{ [weak self] habits in
//                guard let wself = self else { return }
//                wself.createMonthSection(monthHabits: habits)
//                semaphore.signal()
//            }
//        }
    }
}

extension ReportViewController {
    fileprivate func createTodaySection(haits: [Habit]) {
        let todaySection = TableSection()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 15))
        view.backgroundColor = kAppDefaultBackgroundColor
        todaySection.headerView = view
        
        let vm = ReportTodayCellVM(habits: haits, current: current)
        let todayRow = TableRow<ReportTodayTableCell>(item: vm, actions: nil)
        todaySection.append(row: todayRow)
        tableDirector.append(section: todaySection)
        tableDirector.reload()
    }
    
    fileprivate func createWeekSection(weekHabits: [Habit]) {
        
        let headerVM = ReportWeekHeaderVM(habits: weekHabits, current: current)
        let weekHeader = ReportWeekHeader.loadView() as! ReportWeekHeader
        weekHeader.progress = headerVM.progress
        
        let weekSection = TableSection()
        weekSection.headerView = weekHeader
        tableDirector.append(section: weekSection)
        
        for weekHabit in weekHabits {
            let vm = ReportWeekCellVM(habit: weekHabit)
            let habitRow = TableRow<ReportWeekTableCell>(item: vm, actions: nil)
            weekSection.append(row: habitRow)
        }
        
        tableDirector.reload()
    }
    
    fileprivate func createCompleteRateSection() {
        let rateHeader = ReportCompleteRateHeader.loadView()
        let rateSection = TableSection()
        rateSection.headerView = rateHeader
        tableDirector.append(section: rateSection)
        tableDirector.reload()
    }
    
    fileprivate func createCheckTimeSection() {
        let checkTimeHeader = ReportCheckTimeHeader.loadView()
        let checkTimeSection = TableSection()
        checkTimeSection.headerView = checkTimeHeader
        tableDirector.append(section: checkTimeSection)
        tableDirector.reload()
    }
    
    fileprivate func createWeekdaySection() {
        let everydayHeader = ReportEverydayHeader.loadView()
        let everydaySection = TableSection()
        everydaySection.headerView = everydayHeader
        tableDirector.append(section: everydaySection)
        tableDirector.reload()
    }
    
    fileprivate func createMonthSection(monthHabits: [Habit]) {
        let monthHeader = ReportMonthHeader.loadView()
        let monthSection = TableSection()
        monthSection.headerView = monthHeader
        tableDirector.append(section: monthSection)
        tableDirector.reload()
    }
}
