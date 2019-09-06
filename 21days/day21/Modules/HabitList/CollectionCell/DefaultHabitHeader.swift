//
//  DefaultHabitHeader.swift
//  day21
//
//  Created by flion on 2018/11/20.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class DefaultHabitHeader: UICollectionReusableView {
    var index: Int = 0 {
        didSet {
            if index == 0 {
                habitCategoryLabel.text = "身体"
            } else if index == 1 {
                habitCategoryLabel.text = "学习"
            } else if index == 2 {
                habitCategoryLabel.text = "思想"
            } else if index == 3 {
                habitCategoryLabel.text = "健康"
            } else {
                habitCategoryLabel.text = "情感"
            }
        }
    }
    
    @IBOutlet weak var habitCategoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
