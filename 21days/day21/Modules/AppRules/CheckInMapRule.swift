//
//  CheckInMapRule.swift
//  day21
//
//  Created by flionel on 2019/1/6.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class CheckInMapRule: NSObject {
    static func goalIntegral(forContinuousDays day: Int ) -> Int {
        
        guard day >= 0 else {
            fatalError("CHECK IN Days COULDNOT BE MINUS")
        }
        
        switch day {
        case 1:
            return 5
        case 2:
            return 8
        case 3:
            return 12
        case 4:
            return 15
        case 5:
            return 20
        case 6:
            return 22
        case 7:
            return 25
        case 8:
            return 28
        case 9:
            return 30
        case 10:
            return 32
        case 11:
            return 36
        case 12:
            return 40
        case 13:
            return 42
        case 14:
            return 45
        default:
            return 50
        }
    }
}
