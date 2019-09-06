//
//  CheckHistoryTableCell.swift
//  day21
//
//  Created by flion on 2019/2/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class CheckHistoryTableCell: UITableViewCell {

    @IBOutlet weak var verticalLine: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var checkTextLabel: UILabel!
    @IBOutlet weak var checkDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        verticalLine.backgroundColor = UIColor(237, 237, 237)
        dotView.backgroundColor = UIColor(237, 237, 237)
        dotView.layer.cornerRadius = 3
        
        checkTextLabel.textColor = UIColor.darkText
        checkDateLabel.textColor = UIColor.lightGray
    }
    
}

extension CheckHistoryTableCell: ConfigurableCell {
    func configure(with vm: CheckHistoryViewModel) {
        checkTextLabel.text = "签到:\(vm.habitName)"
        checkDateLabel.text = "HELLO" // vm.checkTime
    }
}
