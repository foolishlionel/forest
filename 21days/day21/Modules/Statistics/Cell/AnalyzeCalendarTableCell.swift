//
//  AnalyzeCalendarTableCell.swift
//  day21
//
//  Created by flion on 2019/1/29.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class AnalyzeCalendarTableCell: UITableViewCell {

    @IBOutlet weak var bgContent: UIView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var separateLine: UIView!
    @IBOutlet weak var checkRangeView: UIView!
    @IBOutlet weak var checkTimeRangeLabel: UILabel!
    fileprivate var viewModel: AnalyzeCalendarViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.init(246, 246, 246)
        bgContent.layer.cornerRadius = 6
        bgContent.clipsToBounds = true
        separateLine.backgroundColor = UIColor(246, 246, 246)
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.delegate = self
        calendar.dataSource = self
    }
    
    @IBAction func changeTimeButtonClicked(_ sender: Any) {
        
    }
    
}

extension AnalyzeCalendarTableCell: ConfigurableCell {
    func configure(with vm: AnalyzeCalendarViewModel) {
        viewModel = vm
        calendar.reloadData()
    }
}

extension AnalyzeCalendarTableCell: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let createdAt = viewModel.createdAt
        let today = Date()
        let checkDates = viewModel.checkInDays
        
        if date > createdAt && date < today || date.compare(.isToday) {
            let filterDates = checkDates.filter { $0.compare(.isSameDay(as: date)) }
            if filterDates.count == 0 {
                // 可签到
                ompLog("签到成功 继续加油")
                if date.compare(.isToday) {
                    checkTodayHabit(at: date)
                } else {
                    recheckPreviousHabit(at: date)
                }
            }
        }
    }
}

extension AnalyzeCalendarTableCell {
    fileprivate func checkTodayHabit(at date: Date) {
        
    }
    
    fileprivate func recheckPreviousHabit(at date: Date) {
        
    }
}

extension AnalyzeCalendarTableCell: FSCalendarDelegateAppearance, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        
        if date < viewModel.createdAt || date > Date() {
            return UIColor.white
        }
        
        return viewModel.habitColor.cocoaColor
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let checkDates = viewModel.checkInDays
        for checkDate in checkDates {
            if date.compare(.isSameDay(as: checkDate)) {
                return viewModel.habitColor.cocoaColor
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return UIColor.darkText
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        return UIColor.darkText
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        return UIColor.clear
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
        return UIColor.darkText
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 1.0
    }
}
