//
//  HomeViewController.swift
//  day21
//
//  Created by flion on 2018/10/13.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import TableKit
import RxSwift
import RxCocoa
import EmptyDataSet_Swift
import Parchment
import Then

class HomeViewController: UIViewController {
    
    fileprivate var menuItems = HabitModuleHelper.calculateCurrentWeekMenuItems()
    fileprivate let pagingViewController = PagingViewController<HomeMenuModel>().then {
        $0.menuItemSource = .nib(nib: UINib(nibName: "HomeMenuCollectCell", bundle: nil))
        $0.menuItemSize = .fixed(width: kScreenWidth / 7, height: 55)
        $0.indicatorColor = kAppLightSkyBlueThemeColor
    }
    
    @IBOutlet weak var walletButton: UIButton!
    @IBOutlet weak var walletButtonTrailing: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initEnableModule()
        initMenuView()
    }
    
    fileprivate func initMenuView() {
        
        pagingViewController.dataSource = self
        
        // Add the paging view controller as a child view controller
        // and contrain it to all edges.
        scrollToToday()
        
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        pagingViewController.didMove(toParentViewController: self)
    }
    
    fileprivate func scrollToToday() {
        let weekDay = Date().weekday
        let index = weekDay - 1
        guard index >= 0 && index < 7 else { return }
        pagingViewController.select(index: index)
    }
    
}

extension HomeViewController: PagingViewControllerDataSource {
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
        let homeList = HomeContentListVC(selectDate: menuItems[index].date)
        return homeList
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
        let date = menuItems[index].date
        return HomeMenuModel(date: date, index: index) as! T
    }
    
    func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
        return menuItems.count
    }
}

// MARK: - 初始化协议
extension HomeViewController: OPNaviUniversalable {
    fileprivate func initEnableModule() {
        let addItem = OPNavigationBarItemMetric.add
        universal(model: addItem) { [weak self] item in
            guard let wself = self else { return }
            let habitListVC = DefaultHabitListVC()
            habitListVC.hidesBottomBarWhenPushed = true
            wself.navigationController?.pushViewController(habitListVC, animated: true)
        }
    }
}
