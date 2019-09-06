//
//  ReportCompleteRateHeader.swift
//  day21
//
//  Created by flion on 2019/4/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class ReportCompleteRateHeader: UIView {
    static func loadView() -> UIView {
        let nib = UINib(nibName: "ReportCompleteRateHeader", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
