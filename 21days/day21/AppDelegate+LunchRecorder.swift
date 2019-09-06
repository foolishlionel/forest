//
//  AppDelegate+LunchRecorder.swift
//  day21
//
//  Created by flion on 2019/1/16.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

extension AppDelegate {
    func appLaunchTimeDidRecord() {
        AppLunchTimeRecorder.appDidLunch()
    }
}
