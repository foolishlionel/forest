//
//  UIViewController+Ext.swift
//  OMPToolKit
//
//  Created by flion on 2018/11/1.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addChildViewController(_ childVC: UIViewController, toView: UIView) {
        addChildViewController(childVC)
        childVC.beginAppearanceTransition(true, animated: false)
        toView.addSubview(childVC.view)
        childVC.endAppearanceTransition()
        childVC.didMove(toParentViewController: self)
    }
    
    var currentViewController: UIViewController? {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while topVC?.presentedViewController != nil {
            topVC = _getTopViewController(vc: topVC)
        }
        return topVC
    }

    fileprivate func _getTopViewController(vc: UIViewController?) -> UIViewController? {
        guard let temp = vc else { return nil }
        if temp.isKind(of: UINavigationController.self) {
            let naviVC = temp as! UINavigationController
            return _getTopViewController(vc: naviVC.topViewController)
        } else if temp.isKind(of: UITabBarController.self) {
            let tabVC = temp as! UITabBarController
            return _getTopViewController(vc: tabVC.selectedViewController)
        } else {
            return vc
        }
    }
}
