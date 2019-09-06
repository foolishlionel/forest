//
//  MakeColorCollectCell.swift
//  day21
//
//  Created by flion on 2019/7/5.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class MakeColorCollectCell: UICollectionViewCell, OMPCellReuseIdentify {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorView.layer.cornerRadius = 15
        colorView.layer.masksToBounds = true
    }

    func handleCell(color: HabitColor) {
        let isSelect = false
        
        colorView.backgroundColor = color.cocoaColor
        
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
