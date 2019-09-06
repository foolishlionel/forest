//
//  OPButton.swift
//  day21
//
//  Created by flionel on 2019/4/9.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class OPButton: UIButton {
    
    var textRect: CGRect = .zero
    var imgRect: CGRect = .zero

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
//        if titleRect == .zero {
//            return super.titleRect(forContentRect: contentRect)
//        }
        return textRect
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
//        if imageRect == .zero {
//            return super.imageRect(forContentRect: contentRect)
//        }
        return imgRect
    }

}
