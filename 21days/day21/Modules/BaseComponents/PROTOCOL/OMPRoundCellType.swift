//
//  OMPRoundCellType.swift
//  day21
//
//  Created by flionel on 2019/2/11.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

protocol OMPRoundCellType {
    var bgContentView: UIView! { get set }
}

extension OMPRoundCellType where Self: UITableViewCell {
    func setupRoundRectangle() {
        backgroundColor = UIColor.clear
        bgContentView.backgroundColor = UIColor.white
        bgContentView.layer.cornerRadius = 5
    }
}
