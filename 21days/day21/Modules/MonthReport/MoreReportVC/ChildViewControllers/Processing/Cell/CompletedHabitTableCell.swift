//
//  CompletedHabitTableCell.swift
//  day21
//
//  Created by flion on 2019/1/15.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class CompletedHabitTableCell: UITableViewCell {

    @IBOutlet weak var backgroundContent: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var uncompletedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundContent.layer.cornerRadius = 2
        backgroundContent.clipsToBounds = true
    }
    
}

extension CompletedHabitTableCell: ConfigurableCell {
    func configure(with viewModel: CompletedCellViewModel) {
        iconImageView.image = UIImage(named: viewModel.habitIcon.stringValue)
        habitNameLabel.text = viewModel.habitName
        summaryLabel.text = "目标打卡\(viewModel.goalCheckDays)天，已坚持\(viewModel.totalCheckInDays)天"
    }
}
