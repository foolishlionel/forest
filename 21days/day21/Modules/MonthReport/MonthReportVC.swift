//
//  MonthReportVC.swift
//  day21
//
//  Created by flion on 2019/1/8.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit
import ReSwift
import TYCyclePagerView

fileprivate let kMonthReportCollectReuseId = "kMonthReportCollectReuseId"
fileprivate let kSingleReportCollectReuseId = "kSingleReportCollectReuseId"

class MonthReportVC: UIViewController {
    
    typealias StoreSubscriberStateType = MonthReportState
    
    @IBOutlet weak var monthTitleLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageView: TYCyclePagerView!
    
    let monthReportInteractor = MonthReportInteractor()
    
    fileprivate let monthReportStore = Store<MonthReportState>(reducer: { (action, state) in
        return monthReportReducer(action: action as! MonthReportAction, state: state) ?? MonthReportState()
    }, state: MonthReportState())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        monthReportStore.subscribe(self) { state in state }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        monthReportStore.unsubscribe(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initCollectionView()
        loadMonthHabits()
    }
    
    fileprivate func initCollectionView() {
        pageView.backgroundColor = kAppDefaultBackgroundColor
        pageView.register(UINib(nibName: "SingleReportCollectCell", bundle: nil), forCellWithReuseIdentifier: kMonthReportCollectReuseId)
        pageView.register(UINib(nibName: "MonthReportCollectCell", bundle: nil), forCellWithReuseIdentifier: kSingleReportCollectReuseId)
        pageView.isInfiniteLoop = false
        pageView.dataSource = self
        pageView.delegate = self
    }
    
    fileprivate func loadMonthHabits() {
        let selectDate = monthReportStore.state.selectMonth
        monthReportInteractor.loadMonthHabits(compare: selectDate) { [weak self] habits in
            guard let wself = self else { return }
            wself.monthReportStore.state.habits = habits // hard code
            wself.monthReportStore
                .dispatch(MonthReportAction.loadHabits(habits: habits))
            if habits.count >= 2 {
                wself.pageView.scrollToItem(at: 1, animate: true)
            }
        }
    }
    
    @IBAction func preMonthClicked(_ sender: Any) {
        monthReportStore
            .dispatch(MonthReportAction.clickPrevious)
    }
    
    @IBAction func nextMonthClicked(_ sender: Any) {
        monthReportStore
            .dispatch(MonthReportAction.clickNext)
    }
    
    fileprivate func setPageViewLinerStyle() {
        if pageView.layout.layoutType != .linear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let wself = self else { return }
                wself.pageView.layout.layoutType = .coverflow
                wself.pageView.setNeedUpdateLayout()
            }
        }
    }
}

extension MonthReportVC: StoreSubscriber {
    func newState(state: MonthReportVC.StoreSubscriberStateType) {
        nextButton.isEnabled = state.isNextButtonClickEnabled
        pageView.reloadData()
        handleTimeStatus(monthTime: state.selectMonth)
        setPageViewLinerStyle()
    }
}

extension MonthReportVC {
    func handleTimeStatus(monthTime: Date) {
        if monthTime.isPreviousYear() {
            let year = monthTime.yearNumber
            let month = monthTime.monthNumber
            monthTitleLabel.text = "\(year)年\(month)月"
        } else {
            let month = monthTime.monthNumber
            monthTitleLabel.text = "\(month)月"
        }
    }
}

extension MonthReportVC: TYCyclePagerViewDelegate {
    func pagerView(_ pageView: TYCyclePagerView, didSelectedItemCell cell: UICollectionViewCell, at index: Int) {
        guard pageView.curIndex != index else { return }
        pageView.scrollToItem(at: index, animate: true)
    }
}

extension MonthReportVC: TYCyclePagerViewDataSource {
    
    func numberOfItems(in pageView: TYCyclePagerView) -> Int {
        guard monthReportStore.state.habits.count > 0 else { return 0 }
        return 1 + monthReportStore.state.habits.count
    }
    
    func pagerView(_ pagerView: TYCyclePagerView, cellForItemAt index: Int) -> UICollectionViewCell {
        
        let shouldShowMonthReport = (index == 0)
        if shouldShowMonthReport {
            let cell = pageView.dequeueReusableCell(withReuseIdentifier: kSingleReportCollectReuseId, for: index) as! MonthReportCollectCell
            let monthReportVM = makeMonthHabitsVM()
            cell.configCell(vm: monthReportVM)
            return cell
        } else {
            let cell = pageView.dequeueReusableCell(withReuseIdentifier: kMonthReportCollectReuseId, for: index) as! SingleReportCollectCell
            
            let habit = monthReportStore.state.habits[index-1]
            let singleReportVM = SingleReportCellViewModel(compareDate: monthReportStore.state.selectMonth, habit: habit)
            cell.configCell(with: singleReportVM)
            return cell
        }
    }
    
    func layout(for pageView: TYCyclePagerView) -> TYCyclePagerViewLayout {
        let layout = TYCyclePagerViewLayout()
        // 0.618黄金比例
        let heightRatio = isIPhone5 ? 1.29 : 1.29
        layout.itemSize = CGSize(width: view.width * 0.82, height: kScreenWidth * CGFloat(heightRatio))
        layout.itemSpacing = 10
        layout.itemHorizontalCenter = true
        return layout
    }
}


extension MonthReportVC {
    
    fileprivate func makeMonthHabitsVM() -> MonthReportCollectCellViewModel {
        let allHabits = monthReportStore.state.habits
        let compare = monthReportStore.state.selectMonth
        let vm = MonthReportCollectCellViewModel(compareDate: compare, habits: allHabits)
        return vm
    }
}
