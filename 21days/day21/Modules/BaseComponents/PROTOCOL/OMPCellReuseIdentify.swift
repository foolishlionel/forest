//
//  OMPCellReuseIdentify.swift
//  day21
//
//  Created by flion on 2019/6/28.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

protocol OMPCellReuseIdentify {
    static var cellReuseIdentifier: String { get }
}

extension OMPCellReuseIdentify where Self: UITableViewCell {
    static var cellReuseIdentifier: String {
        return "\(String(describing: self))ReuseId"
    }
}

extension OMPCellReuseIdentify where Self: UICollectionViewCell {
    static var cellReuseIdentifier: String {
        return "\(String(describing: self))ReuseId"
    }
}
