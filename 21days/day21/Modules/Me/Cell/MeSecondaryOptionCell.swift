//
//  MeSecondaryOptionCell.swift
//  day21
//
//  Created by flion on 2019/2/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

struct MeTableCellActions {
    static let checkHistory = "checkHistoryAction"
    static let goldHistory = "goldHistoryAction"
}

class MeSecondaryOptionCell: UITableViewCell, OMPRoundCellType {
    
    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var bgContentHeight: NSLayoutConstraint!
    @IBOutlet weak var themeIcon: UIImageView!
    @IBOutlet weak var coinIcon: UIImageView!
    @IBOutlet weak var recheckIcon: UIImageView!
    @IBOutlet weak var footIcon: UIImageView!
    @IBOutlet weak var historyIcon: UIImageView!
    @IBOutlet weak var weekIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupRoundRectangle()
        
        themeIcon.image = UIImage(named: "theme_icon")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        coinIcon.image = UIImage(named: "coin_icon")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        recheckIcon.image = UIImage(named: "recheck_icon")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        footIcon.image = UIImage(named: "foot_icon")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        historyIcon.image = UIImage(named: "history_icon")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        weekIcon.image = UIImage(named: "week_icon")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        let itemWidth = (kScreenWidth - 20 - 5 * 10.0) / 4.0
        bgContentHeight.constant = itemWidth * 2 + 10.0 * 3
    }
    
    @IBAction func goldClicked(_ sender: Any) {
        TableCellAction(key: MeTableCellActions.goldHistory, sender: self).invoke()
    }
    
    @IBAction func checkHistoryClicked(_ sender: Any) {
        TableCellAction(key: MeTableCellActions.checkHistory, sender: self).invoke()
    }
    
}

extension MeSecondaryOptionCell: ConfigurableCell {
    func configure(with vm: Any) {
        
    }
}
