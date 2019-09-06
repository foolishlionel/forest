//
//  HabitAddTimeTableCell.swift
//  day21
//
//  Created by flion on 2018/10/18.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import TableKit

class HabitAddTimeTableCell: UITableViewCell, OMPCellable {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
    }
    
    @IBAction func addRemindTimeClicked(_ sender: Any) {
        TableCellAction(key: ModifyHabitCellActions.addTimeAction, sender: self).invoke()
    }
    
}

extension HabitAddTimeTableCell: ConfigurableCell {
    func configure(with vm: HabitAddTimeCellViewModel) {
        
    }
}
