//
//  SingleReportCollectCell.swift
//  day21
//
//  Created by flion on 2019/1/24.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class SingleReportCollectCell: UICollectionViewCell {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var chartContentView: UIView!
    @IBOutlet weak var chartTop: NSLayoutConstraint!
    @IBOutlet weak var chartLeft: NSLayoutConstraint!
    @IBOutlet weak var chartWidth: NSLayoutConstraint!
    
    @IBOutlet weak var smallContent0: UIView!
    @IBOutlet weak var smallContent0Left: NSLayoutConstraint!
    @IBOutlet weak var smallContent0Width: NSLayoutConstraint!
    @IBOutlet weak var currentContinuousLabel: UILabel!
    
    @IBOutlet weak var smallContent1: UIView!
    @IBOutlet weak var maxContinuousCountLabel: UILabel!
    
    @IBOutlet weak var smallContent2: UIView!
    @IBOutlet weak var restCountLabel: UILabel!
    
    @IBOutlet weak var smallContent3: UIView!
    @IBOutlet weak var alreadyCheckCountLabel: UILabel!
    
    @IBOutlet weak var smallContent4: UIView!
    @IBOutlet weak var attemptCountLabel: UILabel!
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var separateLine: UIView!
    @IBOutlet weak var allHabitLabel: UILabel!
    @IBOutlet weak var habitSummaryLabel: UILabel!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var donwloadButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    fileprivate var circleProgress: OPCircleProgress!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.white
        chartContentView.backgroundColor = UIColor.clear
        separateLine.backgroundColor = kAppDefaultBackgroundColor
        
        // setupOutsideConstraints()
        // setupInsideConstraints()
        chartTop.constant = (20.0 / 350.0) * contentView.width
        chartLeft.constant = (20.0 / 350.0) * contentView.width
        chartWidth.constant = (200.0 / 350.0) * contentView.width
        smallContent0Left.constant = (20.0 / 350.0) * contentView.width
        smallContent0Width.constant = (90.0 / 350.0) * contentView.width
//        chartContentView.backgroundColor = UIColor.blue
        smallContent0.backgroundColor = UIColor.red
        smallContent1.backgroundColor = UIColor.purple
        smallContent2.backgroundColor = UIColor.orange
        smallContent3.backgroundColor = UIColor.lightGray
        smallContent4.backgroundColor = UIColor.green
        
        circleProgress = OPCircleProgress(frame: chartContentView.bounds)
        chartContentView.addSubview(circleProgress)
        circleProgress.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configCell(with vm: SingleReportCellViewModel) {
        currentContinuousLabel.text = "\(vm.continuousCount)"
        maxContinuousCountLabel.text = "\(vm.maxContinuousCount)"
        restCountLabel.text = "\(vm.restCount)"
        alreadyCheckCountLabel.text = "\(vm.alreadyCheckCount)"
        attemptCountLabel.text = "\(vm.goalCount)"
        circleProgress.progress = vm.progress
    }
}
