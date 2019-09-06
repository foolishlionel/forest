//
//  ReportTodayTableCell.swift
//  day21
//
//  Created by flionel on 2019/4/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import TableKit

class ReportTodayTableCell: UITableViewCell, OMPMarginCellable {

    @IBOutlet weak var bgContentView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        makeSuperViewConstraints()
    }

}

extension ReportTodayTableCell: ConfigurableCell {
    typealias CellData = ReportTodayCellVM
    
    func configure(with vm: ReportTodayTableCell.CellData) {
        let todayHabitCount = vm.todayHabitsCount
        let checkHaibtCount = vm.checkedHabitsCount
        countLabel.text = "\(checkHaibtCount)/\(todayHabitCount)"
    }
}
