//
//  OPNaviUniversalable.swift
//  day21
//
//  Created by flion on 2018/10/17.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Then
import SnapKit

protocol OPNaviUniversalable {}

// MARK: - 添加到视图的组件，需要自己主动设置位置
extension OPNaviUniversalable where Self: UIView {
    // MARK: - 导航栏 通用组件
    func universal(model: OPNavigationBarItemModel, onNext: @escaping (_ model: OPNavigationBarItemModel) -> Void) -> UIView {
        let view = UIView().then {
            $0.backgroundColor = .clear
        }
        
        let btn = UIButton().then {
            $0.contentMode = .scaleAspectFit
            $0.setTitle(model.title, for: .normal)
            $0.setBackgroundImage(UIImage(named: model.imageNamed), for: .normal)
            $0.rx.tap.subscribe(onNext: { _ in
                onNext(model)
            }).disposed(by: rx.disposeBag)
        }
        
        view.addSubview(btn)
        addSubview(view)
        
        view.snp.makeConstraints { make in
            make.width.height.equalTo(OPNavigationBarItemMetric.Metric.itemSize)
            make.centerY.equalToSuperview()
        }
        
        btn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return view
    }
}

// MARK: - 添加到控制器的组件，指定Position(位置)即可
extension OPNaviUniversalable where Self: UIViewController {
    // MARK: - 导航栏 通用组件
    func universal(model: OPNavigationBarItemModel, onNext: @escaping (_ model: OPNavigationBarItemModel) -> Void) {
        var item: UIBarButtonItem
        
        if let title = model.title {
            // 文字标题
            item = UIBarButtonItem(
                title: title,
                style: .plain,
                target: nil,
                action: nil
            )
            
            item.rx.tap.do(onNext: {
                onNext(model)
            }).subscribe().disposed(by: rx.disposeBag)
        } else {
            let btn = UIButton(type: .custom)
            btn.setBackgroundImage(UIImage(named: model.imageNamed), for: .normal)
            if model.highlightedImageNamed.count > 0 {
                btn.setBackgroundImage(UIImage(named: model.highlightedImageNamed), for: .highlighted)
            }
            item = UIBarButtonItem(customView: btn)
            btn.rx.tap.do(onNext: {
                onNext(model)
            }).subscribe().disposed(by: rx.disposeBag)
        }
        
        switch model.itemPosition {
        case .left:
            let leftItemCount = navigationItem.leftBarButtonItems?.count ?? 0
            if  leftItemCount == 0 {
                navigationItem.leftBarButtonItems = [item]
            } else {
                var items: [UIBarButtonItem] = [] + navigationItem.leftBarButtonItems!
                items.append(item)
                navigationItem.leftBarButtonItems = items
            }
        case .right:
            let rightItemCount = navigationItem.rightBarButtonItems?.count ?? 0
            if rightItemCount == 0 {
                navigationItem.rightBarButtonItems = [item]
            } else {
                var items: [UIBarButtonItem] = [] + navigationItem.rightBarButtonItems!
                items.append(item)
                navigationItem.rightBarButtonItems = items
            }
        default:
            break
        }
    }
    
    // MARK: - 导航栏 通用组件
    func universals(models: [OPNavigationBarItemModel], onNext: @escaping (_ model: OPNavigationBarItemModel) -> Void) {
        
        models.enumerated().forEach { [weak self] (index, element) in
            let temp = element
            guard let wself = self else { return }
            wself.universal(model: temp, onNext: { model in
                onNext(model)
            })
        }
    }
}


