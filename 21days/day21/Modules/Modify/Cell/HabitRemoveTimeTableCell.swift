//
//  HabitDeleteTimeTableCell.swift
//  day21
//
//  Created by flion on 2018/10/16.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import TableKit

class HabitRemoveTimeTableCell: UITableViewCell, OMPCellable {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        if let time = self.timeLabel.text {
            
        }
    }
}

extension HabitRemoveTimeTableCell: ConfigurableCell {
    func configure(with vm: HabitRemoveTimeCellViewModel) {
        timeLabel.text = vm.remindTime
    }
}
