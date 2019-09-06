//
//  ProcessingHabitTableCell.swift
//  day21
//
//  Created by flion on 2018/12/27.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import TableKit

class ProcessingHabitTableCell: UITableViewCell {

    @IBOutlet weak var backgroundContent: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var leftDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundContent.layer.cornerRadius = 2
        backgroundContent.clipsToBounds = true
    }
    
}

extension ProcessingHabitTableCell: ConfigurableCell {
    func configure(with viewModel: ProcessingCellViewModel) {
        iconImageView.image = UIImage(named: viewModel.habitIcon.stringValue)
        habitNameLabel.text = viewModel.habitName
        summaryLabel.text = "目标打卡\(viewModel.goalCheckDays)天，已坚持\(viewModel.totalCheckInDays)天"
        leftDayLabel.text = "\(viewModel.leftCheckDays)"
    }
}
