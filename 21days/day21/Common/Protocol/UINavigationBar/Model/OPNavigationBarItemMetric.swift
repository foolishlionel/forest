//
//  OPNavigationBarItemMetric.swift
//  day21
//
//  Created by flion on 2018/10/17.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

struct OPNavigationBarItemMetric {
    // MARK: - constant 常量
    struct Metric {
        static let itemSize: CGFloat = 30.0
    }

    // Left
    static let back = OPNavigationBarItemModel(
        type: .back,
        position: .left,
        description: "返回",
        imageNamed: "common_back"
    )
    
    static let theme = OPNavigationBarItemModel(
        type: .theme,
        position: .left,
        description: "主题",
        imageNamed: "barButtonItemTheme"
    )
    
    static let close = OPNavigationBarItemModel(
        type: .close,
        position: .left,
        description: "关闭", imageNamed: "common_close"
    )
    
    // Right
    static let add = OPNavigationBarItemModel(
        type: .add,
        position: .right,
        description: "添加新的习惯",
        imageNamed: "barButtonItemAdd"
    )
    
    static let share = OPNavigationBarItemModel(
        type: .share,
        position: .right,
        description: "分享",
        imageNamed: "playpage_icon_share_white"
    )
    
    static let more = OPNavigationBarItemModel(
        type: .more,
        position: .right,
        description: "更多",
        imageNamed: "playpage_icon_more"
    )
    
    static let message = OPNavigationBarItemModel(
        type: .message,
        position: .right,
        description: "消息",
        imageNamed: "barButtonItemMessage"
    )
    
    static let history = OPNavigationBarItemModel(
        type: .history,
        position: .right,
        description: "历史记录",
        imageNamed: "top_history_n"
    )
    
    static let setting = OPNavigationBarItemModel(
        type: .setting,
        position: .right,
        description: "设置",
        imageNamed: "barButtonItemSetting"
    )
    
    static let finishModify = OPNavigationBarItemModel(
        type: .finishModify,
        position: .right,
        imageNamed: "modify_ok"
    )
    
    static let modify = OPNavigationBarItemModel(
        type: .modify,
        position: .right,
        imageNamed: "modify_edit"
    )
}
