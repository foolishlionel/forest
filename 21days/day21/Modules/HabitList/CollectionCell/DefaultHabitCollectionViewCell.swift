//
//  DefaultHabitCollectionViewCell.swift
//  day21
//
//  Created by flion on 2018/11/20.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class DefaultHabitCollectionViewCell: UICollectionViewCell {

    var habit: Habit? {
        didSet { handleHabit(habit: habit) }
    }
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
    }
    
    fileprivate func handleHabit(habit: Habit?) {
        guard let temp = habit else { return }
        iconImageView.image = UIImage(named: temp.mirror.icon.stringValue)
        iconImageView.backgroundColor = temp.mirror.color.cocoaColor
        iconNameLabel.text = temp.name
    }

}
