//
//  OPCircleProgress.swift
//  day21
//
//  Created by flion on 2019/1/21.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class OPCircleProgress: UIView {
    var progress: CGFloat = 0 {
        didSet {
            circle.progress = progress
            percentLabel.text = String(format: "完成率:%.1f", progress * 100) + "%"
        }
    }
    fileprivate var circle: OPCircle!
    fileprivate let percentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUI()
    }
    
    fileprivate func initUI() {
        
        percentLabel.frame = bounds
        percentLabel.textColor = UIColor.black
        percentLabel.textAlignment = .center
        percentLabel.font = UIFont.systemFont(ofSize: 15)
        percentLabel.text = "0%"
        addSubview(percentLabel)
        
        circle = OPCircle.init(frame: bounds, lineWidth: 4)
        addSubview(circle)
    }
    
}
