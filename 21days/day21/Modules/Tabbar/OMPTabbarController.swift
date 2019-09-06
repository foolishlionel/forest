//
//  OMPTabbarController.swift
//  day21
//
//  Created by flion on 2018/12/18.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

class OMPTabbarController: UITabBarController {

    fileprivate var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        initialize()
        
        createChildVC(vc: HomeViewController(), title: "打卡", image: "tabbarHome", selectedImage: "tabbarHomeSelect", isHideHavigationBar: false)
        createChildVC(vc: ReportViewController(), title: "月报", image: "tabbarChart", selectedImage: "tabbarChartSelect")
        createChildVC(vc: SettingViewController(), title: "消息", image: "tabbarWeather", selectedImage: "tabbarWeatherSelect")
//        let meVC = MeViewController()
//        createChildVC(vc: meVC, title: "我的", image: "tabbarMe", selectedImage: "tabbarMeSelect")
        
        let testVC = TestViewController()
        createChildVC(vc: testVC, title: "测试", image: "tabbarMe", selectedImage: "tabbarMeSelect")
        setupCustomTabBar()
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        ompLog("点击的item:\(item.tag), \(item.title ?? "")")
    }
}


extension OMPTabbarController {
    
    fileprivate func initialize() {
        let normalAttrs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10),
            NSAttributedStringKey.foregroundColor: UIColor.gray
        ]
        
        let selectedAttrs = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10),
            NSAttributedStringKey.foregroundColor: UIColor(153, 93, 196)
        ]
        
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes(normalAttrs, for: .normal)
        item.setTitleTextAttributes(selectedAttrs, for: .selected)
    }
    
    fileprivate func createChildVC(
        vc: UIViewController,
        title: String,
        image: String,
        selectedImage: String,
        isHideHavigationBar: Bool = false
        ) {
        vc.navigationItem.title = title
        vc.tabBarItem.title = title
        vc.tabBarItem.image = UIImage(named: image)?.renderWith(color: kAppLightSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.renderWith(color: kAppLightSkyBlueThemeColor).withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.tag = index
        index += 1
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.barTintColor = kAppSkyBlueThemeColor
        if isHideHavigationBar {
            navController.navigationBar.isHidden = true
        }
        addChildViewController(navController)
    }
    
    fileprivate func setupCustomTabBar() {
        let tabBar = OMPTabBar(frame: .zero)
        setValue(tabBar, forKey: "tabBar")
        tabBar.centerButton.addTarget(self, action: #selector(centerButtonClicked), for: .touchUpInside)
    }
    
    @objc fileprivate func centerButtonClicked() {
        let habitListNavController = UINavigationController(rootViewController: DefaultHabitListVC())
        habitListNavController.navigationBar.barTintColor = kAppSkyBlueThemeColor
        present(habitListNavController, animated: true, completion: nil)
    }
}
