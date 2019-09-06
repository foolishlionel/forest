//
//  HabitSubIconCollectCell.swift
//  day21
//
//  Created by flion on 2019/2/22.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class HabitSubIconCollectCell: UICollectionViewCell {

    var iconTuple: (HabitIcon, Bool) = (.yoga, false) {
        didSet {
            handleIconImage(tuple: iconTuple)
        }
    }
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var habitIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    fileprivate func handleIconImage(tuple: (HabitIcon, Bool)) {
        habitIcon.image = UIImage(named: tuple.0.stringValue)
        
        if habitIcon.image == nil {
            ompLog("empty string value \(tuple.0.stringValue)")
        }
        if tuple.1 {
            bgView.layer.cornerRadius = 3
            bgView.layer.borderColor = UIColor(hex: 0x666666).cgColor
            bgView.layer.borderWidth = 1
        } else {
            bgView.layer.cornerRadius = 0
            bgView.layer.borderColor = UIColor.clear.cgColor
            bgView.layer.borderWidth = 0
            
        }
    }

}
