//
//  OMPGapCellable.swift
//  day21
//
//  Created by flionel on 2019/4/9.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import SnapKit

protocol OMPMarginCellable {
    var bgContentView: UIView! { get set }
}

extension OMPMarginCellable {
    func makeSuperViewConstraints() {
        bgContentView.snp.remakeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
    }
}
