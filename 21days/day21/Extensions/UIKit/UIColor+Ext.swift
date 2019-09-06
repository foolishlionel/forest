//
//  UIColor+Ext.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/30.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hex value: Int32) {
        self.init(hex: value, alpha: 1.0)
    }
    
    convenience init(hex value: Int32, alpha: CGFloat) {
        let r = CGFloat((value & 0xff0000) >> 16) / 255.0
        let g = CGFloat((value & 0xff00) >> 8) / 255.0
        let b = CGFloat((value & 0xff)) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) {
        self.init(r, g, b, 1.0)
    }
    
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ alpha: CGFloat) {
        let rValue = r / 255
        let gValue = g / 255
        let bValue = b / 255
        self.init(red: rValue, green: gValue, blue: bValue, alpha: alpha)
    }
}
