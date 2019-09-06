//
//  AppLunchTimeRecorder.swift
//  day21
//
//  Created by flion on 2019/1/16.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    static let kAppVersionLunchTime = DefaultsKey<Int>("\(appVersion())" + "appVersionLunchTime")
}

class AppLunchTimeRecorder: NSObject {
    
    static func appDidLunch() {
        
        if isAppFirstLunch {
            AppLunchTimeRecorder
                .loadOneFreeRetroactCheckCardWhenFirstLaunch()
        }
        Defaults[.kAppVersionLunchTime] += 1
    }
    
    static var isAppFirstLunch: Bool {
        return Defaults[.kAppVersionLunchTime] == 0
    }
    
    static fileprivate func loadOneFreeRetroactCheckCardWhenFirstLaunch() {
        let freeRecheckCard = RetroactCheckCard(
            id: 0,
            habitId: nil,
            createdAt: Date(),
            retroactCheckDate: nil,
            isPaid: false
        )
        RetroactCheckCardDBManager.shared
            .insertTable(card: freeRecheckCard) { succeed in
                guard succeed else {
                    fatalError("ERROR: FAILED TO GET FREE RECHECK CARD")
                }
                
                let appDelegate = UIApplication.shared.delegate
                let rootVC = appDelegate?.window!?.rootViewController
                rootVC?.view.makeToast("免费获得一张补签卡", duration: 2.8, position: .center, title: "新版本用户",completion: nil)
                
        }
    }
}
