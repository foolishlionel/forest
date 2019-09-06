//
//  MakeIconCollectCell.swift
//  day21
//
//  Created by flion on 2019/7/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class MakeIconCollectCell: UICollectionViewCell, OMPCellReuseIdentify {

    @IBOutlet weak var bgContent: UIView!
    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgContent.layer.cornerRadius = 4
        bgContent.layer.masksToBounds = true
        bgContent.backgroundColor = kAppDefaultBackgroundColor
        
    }

    func handleCell(mirror: HabitMirror) {
        let renderColor = mirror.color.cocoaColor
        let name = mirror.icon.stringValue
        iconView.image = UIImage(named: name)?.renderWith(color: renderColor)
    }
}
