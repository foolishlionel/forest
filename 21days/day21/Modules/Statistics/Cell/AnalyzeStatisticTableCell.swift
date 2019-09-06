//
//  AnalyzeStatisticTableCell.swift
//  day21
//
//  Created by flion on 2019/1/29.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class AnalyzeStatisticTableCell: UITableViewCell {
    @IBOutlet weak var bgContent: UIView!
    @IBOutlet weak var checkIcon: UIImageView!
    
    @IBOutlet weak var content0View: UIView!
    @IBOutlet weak var alreadyCheckCountLael: UILabel!
    @IBOutlet weak var content1View: UIView!
    @IBOutlet weak var currentContinuousCheckCountLabel: UILabel!
    @IBOutlet weak var content2View: UIView!
    @IBOutlet weak var maxContinuousCountLabel: UILabel!
    @IBOutlet weak var content3View: UIView!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor(246, 246, 246)
        bgContent.layer.cornerRadius = 6
        bgContent.clipsToBounds = true
        content0View.backgroundColor = UIColor(246, 246, 246)
        content1View.backgroundColor = UIColor(246, 246, 246)
        content2View.backgroundColor = UIColor(246, 246, 246)
        content3View.backgroundColor = UIColor(246, 246, 246)
    }
    
}

extension AnalyzeStatisticTableCell: ConfigurableCell {
    func configure(with vm: AnalyzeStatisticViewModel) {
        alreadyCheckCountLael.text = "\(vm.alreadyCheckInCount)"
        currentContinuousCheckCountLabel.text = "\(vm.currentContinuousCount)"
        maxContinuousCountLabel.text = "\(vm.maxContinuousCount)"
        createdAtLabel.text = vm.createdAtText
        checkIcon.image = UIImage(named: "analyze_check")?.renderWith(color: kAppSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
    }
}
