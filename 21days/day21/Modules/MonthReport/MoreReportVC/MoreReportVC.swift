//
//  MoreReportVC.swift
//  day21
//
//  Created by flion on 2018/12/26.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import Parchment

class CustomPagingView: PagingView {
    
    override func setupConstraints() {
        // Use our convenience extension to constrain the page view to all
        // of the edges of the super view.
        constrainToEdges(pageView)
    }
}

// Create a custom paging view controller and override the view with
// our own custom subclass.
class CustomPagingViewController: FixedPagingViewController {
    override func loadView() {
        view = CustomPagingView(
            options: options,
            collectionView: collectionView,
            pageView: pageViewController.view)
    }
}

class MoreReportVC: UIViewController {
    
    let processingVC = ProcessingHabitVC().then { $0.title = "进行中" }
    let completedVC = CompletedHabitVC().then { $0.title = "已结束" }
    
    fileprivate lazy var pagingVC: CustomPagingViewController = {
        
        let vcs = [processingVC, completedVC]
        let paging = CustomPagingViewController(
            viewControllers: vcs
            ).then {
                $0.borderOptions = .hidden
                $0.menuBackgroundColor = .clear
                $0.indicatorColor = UIColor.orange
                $0.textColor = UIColor.black
                $0.selectedTextColor = UIColor.orange
            }
        return paging
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPagingVCInfo()
    }
    
    fileprivate func setupPagingVCInfo() {
        addChildViewController(pagingVC, toView: view)
        navigationItem.titleView = pagingVC.collectionView
        view.constrainToEdges(pagingVC.view)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let navigationBar = navigationController?.navigationBar else { return }
        let titleViewLeftGap: CGFloat = 30.0
        navigationItem.titleView?.frame = CGRect(x: titleViewLeftGap, y: 0, width: kScreenWidth - titleViewLeftGap * 2, height: navigationBar.bounds.height)
        pagingVC.menuItemSize = .fixed(width: (kScreenWidth - titleViewLeftGap * 2) / 2, height: navigationBar.bounds.height)
    }
}
