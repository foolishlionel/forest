//
//  AnalyzeAction.swift
//  day21
//
//  Created by flion on 2019/1/30.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import ReSwift

enum AnalyzeAction: Action {
    case didCheckAt(date: Date)
    case clickChangeCheckTime
    case didChangeCheckTime(left: Date, right: Date)
    case delete
    case archive
}
