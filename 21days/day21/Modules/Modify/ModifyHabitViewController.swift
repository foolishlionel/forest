//
//  ModifyHabitViewController.swift
//  day21
//
//  Created by flion on 2018/10/13.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import SQLite
import Toast_Swift
import ReSwift
import TableKit
import Presentr

class ModifyHabitViewController: UIViewController {
    init(habit: Habit) {
        super.init(nibName: "ModifyHabitViewController", bundle: nil)
        self.habit = habit
    }
    
    fileprivate var habit: Habit!
    fileprivate var currentHabitName: String = ""
    fileprivate var currentHabitEncourageWords: String = ""
    
    fileprivate lazy var modifyStore: Store<HabitState> = {
        let defaultState = HabitState(habit: habit)
        let store = Store<HabitState>(reducer: { action, state -> HabitState in
            return habitReducer(action as! ModifyHabitAction, state ?? defaultState)
        }, state: defaultState)
        return store
    }()
    
    fileprivate var datePicker: WSDatePickerView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var tableDirector: TableDirector!
    
    fileprivate lazy var TABLEVIEW: UITableView = {
        let tableViewController = UITableViewController(style: .grouped)
        addChildViewController(tableViewController)
        let table = tableViewController.tableView
        table?.separatorStyle = .none
        return table!
    }()
    
    fileprivate let modifyInteractor = ModifyInteractor()
    
    fileprivate let presenter = Presentr(presentationType: .bottomHalf)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        modifyStore.subscribe(self) { state in state }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        modifyStore.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(TABLEVIEW)
        TABLEVIEW.keyboardDismissMode = .onDrag
        TABLEVIEW.snp.makeConstraints { make in
//            make.left.right.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        tableDirector = TableDirector(
            tableView: TABLEVIEW,
            shouldUsePrototypeCellHeightCalculation: true
        )
        
        initHabitInfo()
        initEnableModule()
    }
}

extension ModifyHabitViewController: StoreSubscriber {
    typealias StoreSubscriberStateType = HabitState
    func newState(state: ModifyHabitViewController.StoreSubscriberStateType) {
        
        let habit = modifyStore.state.habit!
        
        tableDirector.clear()
        
        let inputNameRow = TableRow<HabitNameTableCell>(item: HabitNameCellViewModel(habit: habit), actions: [inputNameAction(), changeIconAction()])
        let firstSection = TableSection(rows: [inputNameRow])
        firstSection.headerView = defaultHeaderView()
        firstSection.footerView = defaultFooterView()
        
        let secondSection0 = TableSection()
        secondSection0.footerView = defaultFooterView()
        
        let frequencyMenuRow = TableRow<HabitCheckFrequencyMenuCell>(item: HabitFrequencyMenuViewModel())
        
        secondSection0.append(row: frequencyMenuRow)
        
        if case .everyDay(let repeatDays, _) = modifyStore.state.habit.checkRate {
            let frequencyDaysRow = TableRow<HabitCheckFrequencyDaysCell>(item: HabitFrequencyDaysViewModel(repeatDays: repeatDays), actions: [tapRateWeekDayAction()])
            secondSection0.append(row: frequencyDaysRow)
        }
        
        
        
        let checkRate = modifyStore.state.habit.checkRate
        var tapIndex: Int = 0
        if case .everyDay(_, let count) = checkRate {
            tapIndex = count
        }
        
        let frequencyCountRow = TableRow<HabitCheckFrequencyChooseCountCell>(item: HabitFrequencyCountViewModel(index: tapIndex), actions: [tapRepeatCountAction()])
        secondSection0.append(row: frequencyCountRow)
        
        
        let checkRangeRow = TableRow<HabitCheckRangeCell>(item: HabitCheckRangeCellViewModel(habit: habit), actions: [checkRangeAction()])
        let remindRow = TableRow<HabitRemindSwitchTableCell>(item: HabitRemindCellViewModel(habit: habit), actions: [openRemindAction()])
        
        
        let secondSection = TableSection(rows: [checkRangeRow, remindRow])
        secondSection.footerView = defaultFooterView()
        
        let isOpenRemind = modifyStore.state.habit.isOpenRemind
        if isOpenRemind {
            let reminds = modifyStore.state.habit.remindTimes
            if reminds.count > 0 {
                let existRemindRows = reminds.map {
                    TableRow<HabitRemoveTimeTableCell>(item: HabitRemoveTimeCellViewModel(time: $0), actions: [removeTimeAction()])
                }
                secondSection.append(rows: existRemindRows)
            }
            let addTimeRow = TableRow<HabitAddTimeTableCell>(item: HabitAddTimeCellViewModel(), actions: [addTimeAction()])
            secondSection.append(row: addTimeRow)
        }
        
        let colorRow = TableRow<HabitColorTableCell>(item: HabitColorCellViewModel(habit: habit), actions: [chooseColorAction()])
        let thirdSection = TableSection(rows: [colorRow])
        thirdSection.footerView = defaultFooterView()
        
        let encourageRow = TableRow<HabitEncourageTableCell>(item: HabitEncourageCellViewModel(habit: habit), actions: [inputEncourageAction(), randomEncourageAction()])
        let forthSection = TableSection(rows: [encourageRow])
        forthSection.footerView = defaultFooterView()
        
        let fullSections = [firstSection, secondSection0, secondSection, thirdSection, forthSection]
        tableDirector.append(sections: fullSections)
        tableDirector.reload()
    }
    
    fileprivate func defaultHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 10))
        header.backgroundColor = kAppDefaultBackgroundColor
        return header
    }
    
    fileprivate func defaultFooterView() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 10))
        footer.backgroundColor = UIColor.lightGray
        return footer
    }
    
    fileprivate func inputNameAction() -> TableRowAction<HabitNameTableCell> {
        let inputAction = TableRowAction<HabitNameTableCell>(ModifyHabitCellActions.inputNameAction) { [weak self] options in
            guard let wself = self else { return }
            let name = options.userInfo?["inputName"] as! String
            wself.currentHabitName = name
            /// HARD CODE
//            let action = ModifyHabitAction.endInputHabitName(name: name)
//            wself.modifyStore.dispatch(action)
        }
        
        return inputAction
    }
    
    fileprivate func changeIconAction() -> TableRowAction<HabitNameTableCell> {
        let changeAction = TableRowAction<HabitNameTableCell>(ModifyHabitCellActions.clickChangeIconAction) { [weak self] _ in
            guard let wself = self else { return }
            let makeIconVC = IconsViewController()
            makeIconVC.clickMirrorBlock = { [weak self] mirror in
                guard let wself = self else { return }
                wself.didChooseMiddor(mirror: mirror)
            }
            wself.customPresentViewController(wself.presenter, viewController: makeIconVC, animated: true)
        }
        return changeAction
    }
    
    fileprivate func didChooseMiddor(mirror: HabitMirror) {
        let action = ModifyHabitAction.chooseMirror(mirror: mirror)
        modifyStore.dispatch(action)
    }
    
    
    fileprivate func newCheckRate(tapCount: Int) -> CheckRateType {
        let lastRate = modifyStore.state.habit.checkRate
        if case .everyDay(let days, _) = lastRate {
            return CheckRateType.everyDay(days: days, count: tapCount)
        }
        return CheckRateType.everyDay(days: [.monday, .sunday], count: 1)
    }
    
    fileprivate func tapRateWeekDayAction() -> TableRowAction<HabitCheckFrequencyDaysCell> {
        let tapWeekDayAction = TableRowAction<HabitCheckFrequencyDaysCell>(ModifyHabitCellActions.tapRateWeekDayAction) { [weak self] options in
            
            guard let wself = self else { return }
            let info = options.userInfo?["btnSelect"] as! [(Int, Bool)]
            let repeatDays = Set(info.filter {
                $0.1 }.map { WeekDay(rawValue: $0.0)! })
            let repeatDaysAction = ModifyHabitAction.chooseRepeatDays(days: repeatDays)
            wself.modifyStore.dispatch(repeatDaysAction)
        }
        return tapWeekDayAction
    }
    
    fileprivate func tapRepeatCountAction() -> TableRowAction<HabitCheckFrequencyChooseCountCell> {
        
        let tapRepeatAction = TableRowAction<HabitCheckFrequencyChooseCountCell>(ModifyHabitCellActions.tapAtPointForRepeatCount) { [weak self] options in
            
            guard let wself = self else { return }
            let tapCount = options.userInfo?["tapCount"] as! Int
            let checkRate = wself.newCheckRate(tapCount: tapCount)
            let repeatAction = ModifyHabitAction.switchFrequencyMenu(rate: checkRate)
            wself.modifyStore.dispatch(repeatAction)
        }
        
        return tapRepeatAction
    }
    
    fileprivate func checkRangeAction() -> TableRowAction<HabitCheckRangeCell> {
        let rangeAction = TableRowAction<HabitCheckRangeCell>(ModifyHabitCellActions.chooseCheckRangeAction) { [weak self] options in
            let selectIndex = options.userInfo?["selectIndex"] as! Int
            let checkRange = HabitCheckTimeRange(rawValue: selectIndex)!
            let action = ModifyHabitAction.chooseCheckTime(checkRange: checkRange)
            guard let wself = self else { return }
            wself.modifyStore.dispatch(action)
        }
        return rangeAction
    }
    
    fileprivate func openRemindAction() -> TableRowAction<HabitRemindSwitchTableCell> {
        let remindAction = TableRowAction<HabitRemindSwitchTableCell>(ModifyHabitCellActions.switchRemindAction) { [weak self] options in
            guard let wself = self else { return }
            let isRemind = options.userInfo?["isOpenRemind"] as! Bool
            let action = ModifyHabitAction.changeRemindSwitch(isOn: isRemind)
            wself.modifyStore.dispatch(action)
        }
        return remindAction
    }
    
    fileprivate func addTimeAction() -> TableRowAction<HabitAddTimeTableCell> {
        let addTimeAction = TableRowAction<HabitAddTimeTableCell>(ModifyHabitCellActions.addTimeAction) { [weak self] _ in
            guard let wself = self else { return }
            wself.attemptAddRemindTime()
        }
        return addTimeAction
    }
    
    fileprivate func removeTimeAction() -> TableRowAction<HabitRemoveTimeTableCell> {
        let removeTiemAction = TableRowAction<HabitRemoveTimeTableCell>(ModifyHabitCellActions.removeTimeAction) { options in
            
        }
        return removeTiemAction
    }
    
    fileprivate func chooseColorAction() -> TableRowAction<HabitColorTableCell> {
        let colorAction = TableRowAction<HabitColorTableCell>(ModifyHabitCellActions.chooseColorAction) { [weak self] options in
            let colorValue = options.userInfo?["colorValue"] as! Int
            let color = HabitColor.init(rawValue: colorValue)!
            let action = ModifyHabitAction.selectColor(color: color)
            guard let wself = self else { return }
            wself.modifyStore.dispatch(action)
        }
        return colorAction
    }
    
    fileprivate func inputEncourageAction() -> TableRowAction<HabitEncourageTableCell> {
        let inputAction = TableRowAction<HabitEncourageTableCell>(ModifyHabitCellActions.inputEncourageAction) { [weak self] options in
            let encourageWords = options.userInfo?["encourageWords"] as! String
            guard let wself = self else { return }
            wself.currentHabitEncourageWords = encourageWords
            /// HARD CODE
//            let action = ModifyHabitAction.endInputEncourageWords(words: encourageWords)
//            wself.modifyStore.dispatch(action)
            
        }
        return inputAction
    }
    
    fileprivate func randomEncourageAction() -> TableRowAction<HabitEncourageTableCell> {
        let randomAction = TableRowAction<HabitEncourageTableCell>(ModifyHabitCellActions.randomEncoruageAction) { [weak self] options in
            guard let wself = self else { return }
            
            let randomWords = wself.modifyInteractor.randomEncourageWords()
            let action = ModifyHabitAction.endInputEncourageWords(words: randomWords)
            wself.modifyStore.dispatch(action)
        }
        return randomAction
    }
}

extension ModifyHabitViewController {
    
    fileprivate func initHabitInfo() {
        modifyStore
            .dispatch(ModifyHabitAction.installHabitInfo(habit: habit))
    }
}

extension ModifyHabitViewController: OPNaviUniversalable {
    fileprivate func initEnableModule() {
        
        let backItem = OPNavigationBarItemMetric.back
        universal(model: backItem) { [weak self] _ in
            guard let wself = self else { return }
            wself.navigationController?.popViewController(animated: true)
        }
        
        if habitEditable {
            let modifyItem = OPNavigationBarItemMetric.modify
            universal(model: modifyItem) { [weak self] _ in
                guard let wself = self else { return }
                wself.modifyInteractor.updateDBHabit(forHabit: wself.habit, completionBlock: nil)
            }
        } else {
            let finishItem = OPNavigationBarItemMetric.finishModify
            universal(model: finishItem) { [weak self] _ in
                guard let wself = self else { return }
                wself.createNewHabit()
            }
        }
    }
    
    fileprivate func createNewHabit() {
        
        var newHabit = modifyStore.state.habit!
        if currentHabitName.count > 0 {
            newHabit.name = currentHabitName
        }
        newHabit.encourgeWords = currentHabitEncourageWords
        modifyInteractor.createDBHabit(forHabit: newHabit) { [weak self] succeed in
            guard let wself = self else { return }
            guard succeed else { return }
            wself.showToast(message: "习惯`\(wself.habit.name)`创建成功")
        }
    }
    
}

extension ModifyHabitViewController {
    
    fileprivate func _handleGoalCellClick() {
        let alertController = UIAlertController(title: "目标时长", message: nil, preferredStyle: .actionSheet)
        let action0 = UIAlertAction(title: HabitGoal.day7.goalName, style: .default) { [weak self] _ in
            guard let wself = self else { return }
            wself.habitGoalTableCell(didChoose: HabitGoal.day7)
        }
        
        let action1 = UIAlertAction(title: HabitGoal.day21.goalName, style: .default) { [weak self] _ in
            guard let wself = self else { return }
            wself.habitGoalTableCell(didChoose: HabitGoal.day21)
        }
        
        let action2 = UIAlertAction(title: HabitGoal.day30.goalName, style: .default) { [weak self] _ in
            guard let wself = self else { return }
            wself.habitGoalTableCell(didChoose: HabitGoal.day30)
        }
        
        let action3 = UIAlertAction(title: HabitGoal.day365.goalName, style: .default) { [weak self] _ in
            guard let wself = self else { return }
            wself.habitGoalTableCell(didChoose: HabitGoal.day365)
        }
        
        let action4 = UIAlertAction(title: HabitGoal.forever.goalName, style: .default) { [weak self] _ in
            guard let wself = self else { return }
            wself.habitGoalTableCell(didChoose: HabitGoal.forever)
        }
        
        let action5 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(action0)
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)
        alertController.addAction(action5)
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func attemptAddRemindTime() {
        datePicker = makeDatePicker(withStyle: .hourMinute)
        datePicker.show()
    }
}

extension ModifyHabitViewController {
    fileprivate func _updateHabitName(name: String) {
        habit.name = name
    }
    
    fileprivate func _updateHabitGoal(goal: HabitGoal) {
        habit.goal = goal
    }
    
    fileprivate func updateHabitStartDate(date: Date) {
        habit.startedAt = date
    }
    
    fileprivate func updateHabitRemindTimes(newDate: Date) {
        let time = newDate.string(withFormat: Habit.kDefaultTimeFormat)
        habit.remindTimes.insert(time)
    }
    
    fileprivate func updateHabitRemindTimes(existedTime: String) {
        habit.remindTimes.remove(existedTime)
    }
    
    fileprivate func _updateHabitOpenRemindFlag(isOn: Bool) {
        habit.isOpenRemind = isOn
    }
    
    fileprivate func _updateHabitColor(color: HabitColor) {
        habit.mirror.color = color
    }
    
    fileprivate func _updateHabitIcon(icon: HabitIcon) {
        habit.mirror.icon = icon
    }
    
    fileprivate func _updateHabitEncouageWords(words: String) {
        habit.encourgeWords = words
    }
    
    fileprivate func updateHabitCheckRange(checkRange: HabitCheckTimeRange) {
        habit.checkRange = checkRange;
    }
    
    fileprivate func attemptDeleteHabit() {
        let alert = UIAlertController(title: "删除习惯", message: "确认要删除该习惯吗", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        let confirm = UIAlertAction(title: "确定", style: .default) { [unowned self] _ in
            self.didDeleteHabit()
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func didDeleteHabit() {
        self.habit.isDelete = true
        self.modifyInteractor.updateDBHabit(forHabit: self.habit, completionBlock: { [weak self] temp in
            guard let wself = self else { return }
            wself.showToast(message: "习惯`\(temp.name)`已删除")
        })
    }
    
    fileprivate func attemptArchiveHaibt() {
        let alert = UIAlertController(title: "归档习惯", message: "确认要归档该习惯吗", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        let confirm = UIAlertAction(title: "确定", style: .default) { [unowned self] _ in
            self.didArchiveHabit()
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    fileprivate func didArchiveHabit() {
        habit.isArchive = true
        modifyInteractor.updateDBHabit(forHabit: self.habit, completionBlock: { [weak self] temp in
            guard let weakself = self else { return }
            weakself.showToast(message: "习惯`\(temp.name)`已归档")
        })
    }
    
    fileprivate func showToast(message: String) {
        view.makeToast(message, duration: 1.2, position: .center, completion: { [weak self] _ in
            NotificationCenter.default.post(Notification(name: Notification.Name(kHabitTBLDidChangeNofication)))
            guard let wself = self else { return }
            
            wself.backToRootVC()
            
        })
    }
    
    fileprivate func backToRootVC() {
        navigationController?.popToRootViewController(animated: true)
    }
}


extension ModifyHabitViewController {
    func habitNameTableCell(didInput habitName: String) {
        _updateHabitName(name: habitName)
    }
    
    
    func habitSwitchTableCell(didChange open: Bool) {
        _updateHabitOpenRemindFlag(isOn: open)
    }
    
    func habitRemoveTimeCell(didRemove time: String) {
        updateHabitRemindTimes(existedTime: time)
    }
    
    func habitGoalTableCell(didChoose goal: HabitGoal) {
        _updateHabitGoal(goal: goal)
    }
    
    func habitEncourageCell(didInput encourageWords: String) {
        _updateHabitEncouageWords(words: encourageWords)
    }
    
    func habitChooseCheckRange(checkRange: HabitCheckTimeRange) {
        updateHabitCheckRange(checkRange: checkRange)
    }
    
}

extension ModifyHabitViewController {
    
    fileprivate func copyHabit() -> Habit {
        let copy = habit
        return copy!
    }
    
    fileprivate var habitEditable: Bool {
        return habit.id != 0
    }
    
    fileprivate func makeDatePicker(withStyle style: WSDateShowStyle) -> WSDatePickerView {
        let picker = WSDatePickerView(dateStyle: WSDateStyle(UInt32(style.rawValue))) {
            [unowned self] date in
            self.didClickDatePickToAddRemindTime(date: date)
            
            }?.then {
                $0.dateLabelColor = kAppSkyBlueThemeColor
                $0.datePickerColor = UIColor.black
                $0.doneButtonColor = kAppSkyBlueThemeColor
            }
        return picker!
    }
    
    fileprivate func didClickDatePickToAddRemindTime(date: Date?) {
        guard let date = date else { return }
        let remindTime = date.string(withFormat: Habit.kDefaultRemindTimeFormat)
        let action = ModifyHabitAction.addRemindTime(time: remindTime)
        modifyStore.dispatch(action)
    }
}
