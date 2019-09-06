//
//  HomeTableCell.swift
//  day21
//
//  Created by flion on 2018/12/5.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import TableKit

struct HomeTableCellActions {
    static let checkAction = "checkHabitAction"
}

class HomeTableCell: UITableViewCell, ConfigurableCell {

    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var continuousDayLabel: UILabel!
    @IBOutlet weak var totalDayLabel: UILabel!
    @IBOutlet weak var monday: UIView!
    @IBOutlet weak var tuesday: UIView!
    @IBOutlet weak var wednesday: UIView!
    @IBOutlet weak var thursday: UIView!
    @IBOutlet weak var friday: UIView!
    @IBOutlet weak var saturday: UIView!
    @IBOutlet weak var sunday: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        iconImageView.layer.cornerRadius = 3
        iconImageView.clipsToBounds = true
        backgroundColorView.layer.cornerRadius = 2
        backgroundColorView.clipsToBounds = true
        checkButton.backgroundColor = UIColor.clear
        let weeks = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
        for dayIcon in weeks {
            dayIcon?.layer.cornerRadius = 4
            dayIcon?.layer.masksToBounds = true
        }
    }
    
    func configure(with viewModel: HomeCellViewModel) {
        iconImageView.image = UIImage(named: viewModel.habitIcon.stringValue)
        iconImageView.backgroundColor = viewModel.habitColor.cocoaColor
        nameLabel.text = viewModel.habitName
        handleNameLabelModule(vm: viewModel) // 已打卡，名称添加横线划线，例如~~早睡早起~~
        handleContinuousDayLabelModule(vm: viewModel)
        handleCheckButtonModule(vm: viewModel)
        totalDayLabel.text = "\(viewModel.totalCheckInCount)"
        monday.backgroundColor = viewModel.isMondayCheckIn ? kAppLightSkyBlueThemeColor : UIColor.lightGray
        tuesday.backgroundColor = viewModel.isTuesdayCheckIn ? kAppLightSkyBlueThemeColor : UIColor.lightGray
        wednesday.backgroundColor = viewModel.isWednesdayCheckIn ? kAppLightSkyBlueThemeColor : UIColor.lightGray
        thursday.backgroundColor = viewModel.isThursdayCheckIn ? kAppLightSkyBlueThemeColor : UIColor.lightGray
        friday.backgroundColor = viewModel.isFridayCheckIn ? kAppLightSkyBlueThemeColor : UIColor.lightGray
        saturday.backgroundColor = viewModel.isSaturdayCheckIn ? kAppLightSkyBlueThemeColor : UIColor.lightGray
        sunday.backgroundColor = viewModel.isSundayCheckIn ? kAppLightSkyBlueThemeColor : UIColor.lightGray
        
        tempLabel.text = "\(viewModel.checkCount(atDate: viewModel.compareDate))" + "/" + "\(viewModel.shouldCheckCount(atDay: WeekDay(rawValue: viewModel.compareDate.dayNumber) ?? .monday)))"
        
    }
    
    fileprivate func handleNameLabelModule(vm: HomeCellViewModel) {
        let hasCheck = vm.hasCheckIn(atDate: vm.compareDate)
        let foregroundColor = hasCheck ? UIColor.lightGray : UIColor.black
        let style = hasCheck ? 1 : 0
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.strikethroughStyle: style,
            NSAttributedStringKey.foregroundColor: foregroundColor
        ]

        let attributeString = NSMutableAttributedString(string: vm.habitName)
        attributeString.addAttributes(attributes, range: NSRange(location: 0, length: vm.habitName.count))
        nameLabel.attributedText = attributeString
    }
    
    fileprivate func handleContinuousDayLabelModule(vm: HomeCellViewModel) {
        let hasCheck = vm.hasCheckIn(atDate: vm.compareDate)
        continuousDayLabel.text = "已连续\(vm.currentContinuousCheckInCount)天"
        continuousDayLabel.textColor = hasCheck ? UIColor.lightGray : UIColor.black
    }
    
    fileprivate func handleCheckButtonModule(vm: HomeCellViewModel) {
        let hasCheck = vm.hasCheckIn(atDate: vm.compareDate)
        let checkImgStr = hasCheck ? "home_checked" : "home_uncheck"
        let checkImg = UIImage(named: checkImgStr)?.renderWith(color: UIColor.lightGray).withRenderingMode(.alwaysOriginal)
        checkImageView.image = checkImg
    }
    
    @IBAction func checkButtonClicked(_ sender: Any) {
        TableCellAction(key: HomeTableCellActions.checkAction, sender: self).invoke()
    }
}
