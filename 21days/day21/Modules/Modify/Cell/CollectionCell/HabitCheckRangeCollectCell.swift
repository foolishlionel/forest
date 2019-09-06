//
//  HabitCheckRangeCollectCell.swift
//  day21
//
//  Created by flion on 2019/2/13.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class HabitCheckRangeCollectCell: UICollectionViewCell {

    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.clear
        bgContentView.backgroundColor = UIColor.lightGray
        bgContentView.layer.cornerRadius = 5
        bgContentView.clipsToBounds = true
    }
    
    func handleCell(currentIndex: Int, selectIndex: Int) {
        handleTimeLabelModule(index: currentIndex)
        handleTimeIconModule(current: currentIndex)
        if currentIndex == selectIndex {
            bgContentView.backgroundColor = kAppSkyBlueThemeColor
            bgContentView.layer.borderWidth = 1
            bgContentView.layer.borderColor = UIColor.black.cgColor
        } else {
            bgContentView.backgroundColor = UIColor(246, 246, 246)
            bgContentView.layer.borderWidth = 0
            bgContentView.layer.borderColor = UIColor.clear.cgColor
        }
    }

    fileprivate func handleTimeLabelModule(index: Int) {
        let checkRange = HabitCheckTimeRange(rawValue: index)
        timeLabel.text = checkRange?.timeDescription ?? "任意时间"
    }
    
    fileprivate func handleTimeIconModule(current: Int) {
        
        let range = HabitCheckTimeRange(rawValue: current)!
        switch range {
        case .anyTime:
            timeIcon.image = UIImage(named: "modify_getup")
        case .morning:
            timeIcon.image = UIImage(named: "modify_morning")
        case .afternoon:
            timeIcon.image = UIImage(named: "modify_afternoon")
        case .evening:
            timeIcon.image = UIImage(named: "modify_evening")
        }
    }
}
