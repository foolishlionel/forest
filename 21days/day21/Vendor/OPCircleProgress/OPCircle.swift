//
//  OPCircle.swift
//  day21
//
//  Created by flion on 2019/1/21.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit


class OPCircle: UIView {

    var progress: CGFloat = 0.0 {
        didSet { progressLayer.strokeEnd = progress }
    }
    var lineWidth: CGFloat = 0.0
    fileprivate var progressLayer: CAShapeLayer!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(frame: CGRect, lineWidth: CGFloat) {
        super.init(frame: frame)
        self.lineWidth = lineWidth
        buildLayout()
    }
}

extension OPCircle {
    fileprivate func buildLayout() {
        let centerX = bounds.centerX
        let centerY = bounds.centerY
        let radius = (bounds.width - lineWidth) / 2.0
        // 创建贝塞尔路径
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)
        
        // 添加背景圆环
        let backLayer = CAShapeLayer()
        backLayer.frame = bounds
        backLayer.fillColor = UIColor.clear.cgColor
        backLayer.strokeColor = UIColor(242, 247, 250).cgColor
        backLayer.lineWidth = lineWidth
        backLayer.path = path.cgPath
        backLayer.strokeEnd = 1
        layer.addSublayer(backLayer)
        
        //创建进度layer
        progressLayer = CAShapeLayer()
        progressLayer.frame = bounds
        progressLayer.fillColor =  UIColor.clear.cgColor
        //指定path的渲染颜色
        progressLayer.strokeColor  = UIColor.black.cgColor
        progressLayer.lineCap = kCALineCapRound
        progressLayer.lineWidth = lineWidth
        progressLayer.path = path.cgPath
        progressLayer.strokeEnd = 0
        
        //设置渐变颜色
        let gradientLayer =  CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor(255, 251, 0).cgColor, UIColor(255, 203, 0).cgColor]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.mask = progressLayer // 用progressLayer来截取渐变层
        layer.addSublayer(gradientLayer)
    }
}
