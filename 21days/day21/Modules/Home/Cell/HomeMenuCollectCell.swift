//
//  HomeMenuCollectCell.swift
//  day21
//
//  Created by flion on 2019/1/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import Parchment

class HomeMenuCollectCell: PagingCell {

    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var dateDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        dateDayLabel.layer.cornerRadius = 8
        dateDayLabel.clipsToBounds = true
    }
    
    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
        guard let item = pagingItem as? HomeMenuModel else {
            return
        }
        handleWeekdayModule(item: item, isSelect: selected)
        handleDatedayModule(item: item, isSelect: selected)
    }
    
    fileprivate func handleWeekdayModule(item: HomeMenuModel, isSelect: Bool) {
        weekdayLabel.text = item.weekdayText
        weekdayLabel.font = UIFont.systemFont(ofSize: isSelect ? 18 : 12)
        weekdayLabel.textColor = isSelect ? kAppLightSkyBlueThemeColor : UIColor.black
    }
    
    fileprivate func handleDatedayModule(item: HomeMenuModel, isSelect: Bool) {
        dateDayLabel.text = item.datedayText
        dateDayLabel.font = UIFont.systemFont(ofSize: isSelect ? 12 : 9)
        dateDayLabel.textColor = isSelect ? UIColor.white : UIColor.black
        dateDayLabel.backgroundColor = isSelect ? kAppLightSkyBlueThemeColor : UIColor.white
    }
    
}
