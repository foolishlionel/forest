//
//  OMPCellType.swift
//  day21
//
//  Created by flion on 2018/11/16.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

protocol OMPCellable: class {}

extension OMPCellable where Self : UITableViewCell {
    func defaultSelectionStyle() {
        selectionStyle = .none
    }
}
