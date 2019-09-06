//
//  HabitSubColorCollectCell.swift
//  day21
//
//  Created by flion on 2019/2/27.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class HabitSubColorCollectCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    var colorTuple: (HabitColor, Bool) = (.color0, false) {
        didSet {
            colorView.backgroundColor = colorTuple.0.cocoaColor
            handleColorBorder(isSelect: colorTuple.1)
        }
    }
    
    @IBOutlet weak var colorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorView.layer.cornerRadius = 15
        colorView.layer.masksToBounds = true
    }
    
    fileprivate func handleColorBorder(isSelect: Bool) {
        if isSelect {
            bgView.layer.cornerRadius = 20
            bgView.layer.borderWidth = 1
            bgView.layer.borderColor = UIColor(hex: 0x666666).cgColor
        } else {
            bgView.layer.cornerRadius = 0
            bgView.layer.borderWidth = 0
            bgView.layer.borderColor = UIColor.clear.cgColor
        }
    }

}
