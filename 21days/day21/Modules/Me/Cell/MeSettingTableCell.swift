//
//  MeSettingTableCell.swift
//  day21
//
//  Created by flion on 2019/2/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class MeSettingTableCell: UITableViewCell, OMPRoundCellType {
    
    
    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var bgContentHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupRoundRectangle()
        let itemWidth = (kScreenWidth - 20 - 5 * 10.0) / 4.0
        bgContentHeight.constant = itemWidth + 10.0 * 2
    }
    
}

extension MeSettingTableCell: ConfigurableCell {
    func configure(with vm: Any) {
        
    }
}

