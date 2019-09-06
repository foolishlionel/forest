//
//  ThemeTableCell.swift
//  day21
//
//  Created by flion on 2019/1/17.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class ThemeTableCell: UITableViewCell {

    @IBOutlet weak var themeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        themeImageView.clipsToBounds = true
    }
}

extension ThemeTableCell: ConfigurableCell {
    func configure(with themeIndex: Int) {
        if themeIndex == 0 {
            themeImageView.image = UIImage.init(named: "theme_bright_sunny")
        } else if themeIndex == 1 {
            themeImageView.image = UIImage.init(named: "theme_dark_night")
        } else {
            themeImageView.image = UIImage.init(named: "theme_summer")
        }
    }
}
