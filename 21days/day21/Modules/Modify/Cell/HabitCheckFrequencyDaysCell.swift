//
//  HabitCheckFrequencyDaysCell.swift
//  day21
//
//  Created by flion on 2019/6/19.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit
import RxSwift
import RxCocoa

class HabitCheckFrequencyDaysCell: UITableViewCell, OMPCellable, OMPMarginCellable {
    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var mondayBtn: UIButton!
    @IBOutlet weak var tuesdayBtn: UIButton!
    @IBOutlet weak var wednesdayBtn: UIButton!
    @IBOutlet weak var thursdayBtn: UIButton!
    @IBOutlet weak var fridayBtn: UIButton!
    @IBOutlet weak var saturdayBtn: UIButton!
    @IBOutlet weak var sundayBtn: UIButton!
    fileprivate lazy var dayBtns: [UIButton] = {
        return [mondayBtn, tuesdayBtn, wednesdayBtn, thursdayBtn, fridayBtn, saturdayBtn, sundayBtn]
    }()
    
    fileprivate let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        makeSuperViewConstraints()
        privateInit()
        privateActions()
    }

}

extension HabitCheckFrequencyDaysCell {
    
    fileprivate func privateInit() {
        for dayBtn in dayBtns {
            dayBtn.backgroundColor = kAppTableCellComponentColor
        }
    }
    
    fileprivate func privateActions() {
        mondayBtn.rx.tap.subscribe(onNext: {
            self.tapOnButton(btn: self.mondayBtn)
        }).disposed(by: disposeBag)
        
        tuesdayBtn.rx.tap.subscribe(onNext: {
            self.tapOnButton(btn: self.tuesdayBtn)
        }).disposed(by: disposeBag)
        
        wednesdayBtn.rx.tap.subscribe(onNext: {
            self.tapOnButton(btn: self.wednesdayBtn)
        }).disposed(by: disposeBag)
        
        thursdayBtn.rx.tap.subscribe(onNext: {
            self.tapOnButton(btn: self.thursdayBtn)
        }).disposed(by: disposeBag)
        
        fridayBtn.rx.tap.subscribe(onNext: {
            self.tapOnButton(btn: self.fridayBtn)
        }).disposed(by: disposeBag)
        
        saturdayBtn.rx.tap.subscribe(onNext: {
            self.tapOnButton(btn: self.saturdayBtn)
        }).disposed(by: disposeBag)
        
        sundayBtn.rx.tap.subscribe(onNext: {
            self.tapOnButton(btn: self.sundayBtn)
        }).disposed(by: disposeBag)
    }
    
    fileprivate func tapOnButton(btn: UIButton) {
        
        for button in dayBtns {
            if (btn == button) {
                button.isSelected = !button.isSelected
                break
            }
        }
        let selections = dayBtns.map { ($0.tag, $0.isSelected) }
        let info = ["btnSelect": selections]
        TableCellAction(key: ModifyHabitCellActions.tapRateWeekDayAction, sender: self, userInfo: info).invoke()
    }
}

extension HabitCheckFrequencyDaysCell: ConfigurableCell {
    
    func configure(with vm: HabitFrequencyDaysViewModel) {
        let days = vm.repeatDays
        let numbers = days.map { $0.rawValue }
        for button in dayBtns {
            if numbers.contains(button.tag) {
                button.isSelected = true
                button.backgroundColor = kAppSkyBlueThemeColor
            } else {
                button.isSelected = false
                button.backgroundColor = kAppTableCellComponentColor
            }
        }
    }
}
