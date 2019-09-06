//
//  HabitRemindSwitchTableCell.swift
//  day21
//
//  Created by flion on 2018/10/16.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import TableKit

class HabitRemindSwitchTableCell: UITableViewCell, OMPCellable {

    @IBOutlet weak var remindSwitch: UISwitch!
    @IBOutlet weak var clockIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
        clockIcon.image = UIImage(named: "modify_clock")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
    }
    
    @IBAction func openSwitchClicked(_ sender: UISwitch) {
        let isOpen = sender.isOn
        let userInfo = ["isOpenRemind": isOpen]
        TableCellAction(key: ModifyHabitCellActions.switchRemindAction, sender: self, userInfo: userInfo).invoke()
    }
    
}

extension HabitRemindSwitchTableCell: ConfigurableCell {
    func configure(with vm: HabitRemindCellViewModel) {
        remindSwitch.isOn = vm.isOpenRemind
    }
}
