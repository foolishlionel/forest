//
//  GoldIntegralProvider.swift
//  day21
//
//  Created by flionel on 2019/1/5.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

extension DefaultsKeys {
    static let kGoldIntegralKey = DefaultsKey<Int>("goldIntegral")
}

class GoldIntegralProvider: NSObject {
    
    static var goldIntegral: Int {
        return Defaults[.kGoldIntegralKey]
    }
    
    static func addIntegral(addValue: Int) {
        Defaults[.kGoldIntegralKey] += addValue
    }
    
    static func reduceIntegral(reduceValue: Int) {
        if Defaults[.kGoldIntegralKey] >= reduceValue {
            Defaults[.kGoldIntegralKey] -= reduceValue
        }
    }
}
