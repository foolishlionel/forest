//
//  HomeContentListVC.swift
//  day21
//
//  Created by flion on 2019/1/20.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit
import RxSwift
import RxCocoa
import EmptyDataSet_Swift
import Promise
import Toast_Swift
import Presentr

let kHabitTBLDidChangeNofication = "kHabitDidChangeNotification"

class HomeContentListVC: UIViewController, OMPTableControllerType {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableDirector = TableDirector(
                tableView: tableView,
                shouldUsePrototypeCellHeightCalculation: true
            )
        }
    }
    fileprivate var tableDirector: TableDirector!
    
    fileprivate let homeInteractor = HomeInteractor()
    fileprivate let presenter = Presentr(presentationType: .bottomHalf)
    fileprivate let archivePresenter = Presentr(presentationType: .alert).then {
        $0.transitionType = .coverVerticalFromTop
        $0.dismissTransitionType = .coverVertical
    }
    
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate var selectDate: Date!
    init(selectDate: Date) {
        super.init(nibName: "HomeContentListVC", bundle: nil)
        self.selectDate = selectDate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        tableView.emptyDataSetSource = self
        
        queryHabits()
        initNotification()
    }
    
    fileprivate func queryHabits() {
        let promise = homeInteractor.loadCheckRangeHabits(inDate: selectDate)
        promise.then { [weak self] checkRangeHaibtDictionarys in
            guard let wself = self else { return }
            wself.clearTable()
            for checkRangeHabitDic in checkRangeHaibtDictionarys {
                for range in checkRangeHabitDic.keys {
                    let habits = checkRangeHabitDic[range]
                    let section = wself.makeCheckRangeSection(range: range, habits: habits!)
                    wself.tableDirector.append(section: section)
                }
            }
            wself.reloadTable()
        }
    }
    
    fileprivate func initNotification() {
        NotificationCenter.default
            .rx.notification(Notification.Name(rawValue: kHabitTBLDidChangeNofication))
            .subscribe(onNext: { [weak self] noti in
                guard let wself = self else { return }
                wself.queryHabits()
            }).disposed(by: disposeBag)
    }
    
    fileprivate func makeCheckRangeSection(range: HabitCheckTimeRange, habits: [Habit]) -> TableSection {
        
        let section = TableSection()
        section.headerView = sectionHeader(range: range)
        
        let rowDetailAction = detailAction(habits: habits)
        let rowCheckAction = checkAction(habits: habits)
        
        let rows = habits
            .map { TableRow<HomeTableCell>(item: HomeCellViewModel(habit: $0, compareDate: selectDate), actions: [rowDetailAction, rowCheckAction]) }
        
        section.append(rows: rows)
        return section
    }
    
    fileprivate func detailAction(habits: [Habit]) -> TableRowAction<HomeTableCell> {
        let click = TableRowAction<HomeTableCell>(.click) { [weak self] options in
            
            guard let wself = self else { return }
            let index = options.indexPath.row
            let detailHabit = habits[index]
            wself.gotoHabitAnalyzePage(habit: detailHabit)
        }
        return click
    }
    
    fileprivate func checkAction(habits: [Habit]) -> TableRowAction<HomeTableCell> {
        let detail = TableRowAction<HomeTableCell>(HomeTableCellActions.checkAction) { [weak self] options in
            
            guard let wself = self else { return }
            
            let index = options.indexPath.row
            let checkInHabit = habits[index]
            wself.attemptCheckHabit(habit: checkInHabit)
        }
        return detail
    }
    
    fileprivate func clearTable() {
        tableDirector.clear()
    }
    
    fileprivate func reloadTable() {
        tableDirector.reload()
        tableView.reloadEmptyDataSet()
    }
    
    fileprivate func sectionHeader(range: HabitCheckTimeRange) -> UIView {
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: kScreenWidth - 40, height: 20))
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = kAppDefaultBackgroundColor
        label.text = range.timeDescription
        
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 20))
        sectionView.backgroundColor = kAppDefaultBackgroundColor
        sectionView.addSubview(label)
        
        return sectionView
    }
}

// MARK -
extension HomeContentListVC {
    
    fileprivate func handlePastCheckIn(habit: Habit) {
        let vm = HomeCellViewModel(habit: habit, compareDate: selectDate)
        if vm.hasCheckIn(atDate: selectDate) {
            view.makeToast("不能取消非今日的打卡", duration: 1.2, position: .center, completion: nil)
        } else {
            
            let alert = UIAlertController(title: "签到过期", message: "请使用补签卡", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "确认", style: .default) { [weak self] _ in
                
                guard let wself = self else { return }
                
                let recheckCards = wself.homeInteractor.loadUsefulRecheckCards()
                guard recheckCards.count > 0 else {
                    fatalError("请购买补签卡")
                }
                let firstRecheckCard = recheckCards[0]
                
                wself.handleRecheck(forHabit: habit, withRecheckCard: firstRecheckCard)
            }
            alert.addAction(cancel)
            alert.addAction(confirm)
            present(alert, animated: true, completion: nil)
        }
    }
    
    fileprivate func handleTodayCheckIn(habit: Habit) -> Promise<Bool> {
        
        let promise = Promise<Bool>()
        let current = Date.current()
        homeInteractor.updateHabit(forHabit: habit, checkIn: current) {
            [weak self] in
            guard let wself = self else { return }
            wself.queryHabits()
            promise.fulfill(true)
        }
        
        return promise
    }
    
    fileprivate func handleFutureCheckIn(habit: Habit) {
        view.makeToast("该时段不能打卡", duration: 1.2, position: .center, completion: nil)
    }
    
    fileprivate func handleRecheck(forHabit habit: Habit, withRecheckCard recheckCard: RetroactCheckCard) {
        
        homeInteractor.updateHabit(forHabit: habit, recheckIn: selectDate, recheckCard: recheckCard) { [weak self] in
            guard let wself = self else { return }
            wself.queryHabits()
            wself.addGoldIntegralAfterCheckIn(fromHabit: habit)
        }
    }
    
    fileprivate func gotoHabitAnalyzePage(habit: Habit) {
        let analyzeVC = AnalyzeViewController(habit: habit)
        analyzeVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(analyzeVC, animated: true)
    }
}

extension HomeContentListVC: EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        if selectDate.compare(.isInThePast) {
            let titleAttrStr = NSAttributedString(string: "昨日已去，没有习惯")
            return titleAttrStr
        } else {
            let titleAttrStr = NSAttributedString(string: "没有习惯")
            return titleAttrStr
        }
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        
        if selectDate.compare(.isInThePast) {
            let descAttrStr = NSAttributedString(string: "今天，试着添加一个习惯吧")
            return descAttrStr
        } else {
            let descAttrStr = NSAttributedString(string: "试着添加一个习惯吧")
            return descAttrStr
        }
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "barButtonItemPlus")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
    
}

extension HomeContentListVC {
    func attemptCheckHabit(habit: Habit) {
        
        if selectDate.compare(.isToday) {
            let attemptCount = habit.attemptCheckCountInDay()
            let notTotalCheckInToday = habit.checkInDays.filter { $0.compare(.isSameDay(as: selectDate)) }.count < attemptCount
            if notTotalCheckInToday {
                let habitCheckVC = HabitCheckViewController(habit: habit, delegate: self)
                customPresentViewController(presenter, viewController: habitCheckVC, animated: true)
            } else {
                view.makeToast("今日已打卡，不可重复打卡", duration: 1.2, position: .center)
            }
            
        } else if selectDate.compare(.isInThePast) {
            handlePastCheckIn(habit: habit)
        } else if selectDate.compare(.isInTheFuture) {
            handleFutureCheckIn(habit: habit)
        }
    }
}


extension HomeContentListVC: HabitCheckDelegate {
    
    func comfirmCheckHabit(habit: Habit) {
        handleTodayCheckIn(habit: habit).then { [weak self] succeed in
            guard let wself = self else { return }
            if succeed {
                wself.obtainGold(fromHabit: habit)
            } else {
                wself.view.makeToast("打卡时间\(habit.checkRange.timeDescription)，当前不可打卡", duration: 0.5)
            }
        }
    }
    
    fileprivate func obtainGold(fromHabit habit: Habit) {
        homeInteractor.didGainGold(whenCheck: habit).then({ [weak self] succeed in
            guard let wself = self else { return }
            wself.addGoldIntegralAfterCheckIn(fromHabit: habit)
        })
    }
    
    fileprivate func addGoldIntegralAfterCheckIn(fromHabit habit: Habit) {
        let continuousCheckDay = HabitModuleHelper.continuousCheckDays(whenHabit: habit)
        let obtainIntegral = CheckInMapRule.goalIntegral(forContinuousDays: continuousCheckDay)
        GoldIntegralProvider.addIntegral(addValue: obtainIntegral)
    }
}
