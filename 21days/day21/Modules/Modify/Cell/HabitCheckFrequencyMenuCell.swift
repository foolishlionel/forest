//
//  HabitCheckFrequencyMenuCell.swift
//  day21
//
//  Created by flion on 2019/6/19.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class HabitCheckFrequencyMenuCell: UITableViewCell, OMPCellable {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        defaultSelectionStyle()
    }
    
}

extension HabitCheckFrequencyMenuCell: ConfigurableCell {
    
    func configure(with vm: HabitFrequencyMenuViewModel) {
        
    }
}
