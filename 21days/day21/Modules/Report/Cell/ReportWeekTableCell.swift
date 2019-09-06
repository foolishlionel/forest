//
//  ReportWeekTableCell.swift
//  day21
//
//  Created by flionel on 2019/4/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class ReportWeekTableCell: UITableViewCell {

    @IBOutlet weak var circleContent: UIView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var completeCountLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    fileprivate var circle: OPCircle!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        circle = OPCircle(frame: CGRect(x: 0, y: 0, width: 30, height: 30), lineWidth: 4)
        circle.progress = 0.5
        circleContent.addSubview(circle)
    }
    
}

extension ReportWeekTableCell: ConfigurableCell {
    typealias CellData = ReportWeekCellVM
    
    func configure(with vm: ReportWeekCellVM) {
        circle.progress = CGFloat(vm.completeRateInWeek)
        completeCountLabel.text = "\(circle.progress)--\(vm.completeCountInWeek) / 7"
        habitNameLabel.text = vm.habitName
    }
}
