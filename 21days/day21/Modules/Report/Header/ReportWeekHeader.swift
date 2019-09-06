//
//  ReportWeekHeader.swift
//  day21
//
//  Created by flion on 2019/4/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class ReportWeekHeader: UIView {
    
    var progress: Float = 0.0 {
        didSet {
            topViewWidth.constant = CGFloat(progress) * 60
            layoutIfNeeded()
        }
    }
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewWidth: NSLayoutConstraint!
    
    static func loadView() -> UIView {
        let nib = UINib(nibName: "ReportWeekHeader", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bottomView.layer.cornerRadius = 4;
        bottomView.layer.masksToBounds = true;
    }
}
