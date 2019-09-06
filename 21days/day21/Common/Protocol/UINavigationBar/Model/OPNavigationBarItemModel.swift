//
//  OPNavigationBarItemModel.swift
//  day21
//
//  Created by flion on 2018/10/17.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

// MARK: - 导航栏通用组件 数据模型
struct OPNavigationBarItemModel {
    enum OPNavigationBarItemPosition {
        case left
        case center
        case right
    }
    
    enum OPNavigationBarItemType {
        case back
        case add
        case share
        case more
        case title(index: Int, title: String)
        case message
        case history
        case setting
        case theme
        case close
        case finishModify
        case modify
    }

    var itemType: OPNavigationBarItemType
    var itemPosition: OPNavigationBarItemPosition
    var title: String?
    var description: String
    var imageNamed: String
    var highlightedImageNamed: String
    
    init(type: OPNavigationBarItemType = .back,
         position: OPNavigationBarItemPosition = .left,
         title: String? = nil,
         description: String = "",
         imageNamed: String = "",
         highlightedImageNamed: String = "") {
        
        self.itemType = type
        self.itemPosition = position
        self.title = title
        self.description = description
        self.imageNamed = imageNamed
        self.highlightedImageNamed = highlightedImageNamed
    }
}
