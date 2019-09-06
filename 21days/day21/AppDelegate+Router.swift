//
//  AppDelegate+Router.swift
//  day21
//
//  Created by flion on 2018/11/21.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import URLNavigator

extension AppDelegate {
    func initAppRouter(navigator: NavigatorType) {
        NavigationMap.initialize(navigator: navigator)
    }
}

enum NavigationMap {
    static func initialize(navigator: NavigatorType) {
//        navigator.register("ompDay21://habitList") { (url, values, context) in
//            return DefaultHabitListVC()
//        }
//        navigator.register("ompDay21://habitModify/<habitId>/<habitName>") { url, value, context in
//            let id = value["habitId"] as? Int64
//            let name = value["habitName"] as? String
//            return ModifyHabitViewController(habitId: id, name: name)
//        }
    }
}
