//
//  OMPTableControllerTyoe.swift
//  day21
//
//  Created by flion on 2019/2/3.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

protocol OMPTableControllerType: class {
    var tableView: UITableView! { get set }
}

extension OMPTableControllerType where Self: UIViewController {
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = kAppDefaultBackgroundColor
    }
}

