//
//  HomePresenter.swift
//  day21
//
//  Created by flion on 2018/12/26.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import TableKit
import EmptyDataSet_Swift

class HomePresenter: NSObject {
    fileprivate var view: UIView!
    fileprivate var tableView: UITableView! {
        didSet {
            tableDirector = TableDirector(
                tableView: tableView,
                shouldUsePrototypeCellHeightCalculation: true
            )
        }
    }
    fileprivate var tableDirector: TableDirector!
    fileprivate var calendar: FSCalendar!
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let pan = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        pan.delegate = self
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 2
        return pan
        }()
    
    required init(view: UIView, tableView: UITableView) {
        super.init()
        self.view = view
        self.tableView = tableView
        self.setupUI()
    }
}

extension HomePresenter {
    fileprivate func setupUI() {
        initCalendar()
        initTableView()
    }
    
    fileprivate func initCalendar() {
        calendar.select(Date())
        calendar.delegate = self
        calendar.scope = .week
        self.view.addGestureRecognizer(scopeGesture)
        tableView.panGestureRecognizer.require(toFail: scopeGesture)
        calendar.accessibilityIdentifier = "calendar"
    }
    
    fileprivate func initTableView() {
        tableView.emptyDataSetSource = self
        tableView.tableFooterView = UIView()
    }
    
}

extension HomePresenter: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = tableView.contentOffset.y <= -tableView.contentInset.top
        if shouldBegin {
            let velocity = scopeGesture.velocity(in: self.view)
            switch calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
}

extension HomePresenter: EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let titleAttrStr = NSAttributedString(string: "没有习惯")
        return titleAttrStr
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let descAttrStr = NSAttributedString(string: "试着添加一个习惯吧")
        return descAttrStr
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "barButtonItemPlus")
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
    
}

extension HomePresenter: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        selectDate = date
    }
}
