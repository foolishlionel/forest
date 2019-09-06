//
//  UIView+Gradient.swift
//  day21
//
//  Created by flion on 2019/1/20.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

extension UIView {
    func addExcessiveGradientLayer(startColor: UIColor, endColor: UIColor, inFrame frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradient)
    }
}
