//
//  OMPTabBar.swift
//  day21
//
//  Created by flion on 2018/12/18.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import Then

fileprivate let kItemCount: CGFloat = 5.0;

class OMPTabBar: UITabBar {
    let centerButton = UIButton().then {
        $0.setImage(UIImage(named: "barbarAdd")?.renderWith(color: kAppLightSkyBlueThemeColor).withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        centerButton.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        centerButton.center = center
        addSubview(centerButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerButton.center = CGPoint(x: self.width * 0.5, y: self.height * 0.3)
        var index = 0
        let itemWidth = self.width / kItemCount
        for sub in subviews {
            if sub.isKind(of: NSClassFromString("UITabBarButton")!) {
                sub.left = CGFloat(index) * itemWidth
                index += 1
                if index == 2 { index += 1 }
            }
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.isHidden {
            let newPoint = self.convert(point, to: centerButton)
            if centerButton.point(inside: newPoint, with: event) {
                return centerButton
            } else {
                return super.hitTest(point, with: event)
            }
        } else {
            return super.hitTest(_:point, with:event)
        }
    }
}
