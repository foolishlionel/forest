//
//  HabitColor.swift
//  day21
//
//  Created by flion on 2018/10/16.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

enum HabitColor: Int {
    case color0 = 0
    case color0Light = 1
    case color1 = 2
    case color1Light = 3
    case color2 = 4
    case color2Light = 5
    case color3 = 6
    case color3Light = 7
    case color4 = 8
    case color4Light = 9
    case color5 = 10
    case color5Light = 11
    case color6 = 12
    case color6Light = 13
    case color7 = 14
    case color7Light = 15
    case color8 = 16
    case color8Light = 17
    case color9 = 18
    case color9Light = 19
    case color10 = 20
    case color10Light = 21
    case color11 = 22
    case color11Light = 23
    case color12 = 24
    case color12Light = 25
    case color13 = 26
    case color13Light = 27
    case color14 = 28
    case color14Light = 29
    case color15 = 30
    case color15Light = 31
    case color16 = 32
    case color16Light = 33
    case color17 = 34
    case color17Light = 35
    case color18 = 36
    case color18Light = 37
    case color19 = 38
    case color19Light = 39
    case color20 = 40
    case color20Light = 41
    case color21 = 42
    case color21Light = 43
    case color22 = 44
    case color22Light = 45
    case color23 = 46
    case color23Light = 47
    case color24 = 48
    case color24Light = 49
    case color25 = 50
    case color25Light = 51
    case color26 = 52
    case color26Light = 53
    case color27 = 54
    case color27Light = 55
    case color28 = 56
    case color28Light = 57
    case color29 = 58
    case color29Light = 59
    
    var cocoaColor: UIColor {
        switch self {
        case .color0:
            return HabitColorConstant.kColor0
        case .color0Light:
            return HabitColorConstant.kColor0Light
        case .color1:
            return HabitColorConstant.kColor1
        case .color1Light:
            return HabitColorConstant.kColor1Light
        case .color2:
            return HabitColorConstant.kColor2
        case .color2Light:
            return HabitColorConstant.kColor2Light
        case .color3:
            return HabitColorConstant.kColor3
        case .color3Light:
            return HabitColorConstant.kColor3Light
        case .color4:
            return HabitColorConstant.kColor4
        case .color4Light:
            return HabitColorConstant.kColor4Light
        case .color5:
            return HabitColorConstant.kColor5
        case .color5Light:
            return HabitColorConstant.kColor5Light
        case .color6:
            return HabitColorConstant.kColor6
        case .color6Light:
            return HabitColorConstant.kColor6Light
        case .color7:
            return HabitColorConstant.kColor7
        case .color7Light:
            return HabitColorConstant.kColor7Light
        case .color8:
            return HabitColorConstant.kColor8
        case .color8Light:
            return HabitColorConstant.kColor8Light
        case .color9:
            return HabitColorConstant.kColor9
        case .color9Light:
            return HabitColorConstant.kColor9Light
        case .color10:
            return HabitColorConstant.kColor10
        case .color10Light:
            return HabitColorConstant.kColor10Light
        case .color11:
            return HabitColorConstant.kColor11
        case .color11Light:
            return HabitColorConstant.kColor11Light
        case .color12:
            return HabitColorConstant.kColor12
        case .color12Light:
            return HabitColorConstant.kColor12Light
        case .color13:
            return HabitColorConstant.kColor13
        case .color13Light:
            return HabitColorConstant.kColor13Light
        case .color14:
            return HabitColorConstant.kColor14
        case .color14Light:
            return HabitColorConstant.kColor14Light
        case .color15:
            return HabitColorConstant.kColor15
        case .color15Light:
            return HabitColorConstant.kColor15Light
        case .color16:
            return HabitColorConstant.kColor16
        case .color16Light:
            return HabitColorConstant.kColor16Light
        case .color17:
            return HabitColorConstant.kColor17
        case .color17Light:
            return HabitColorConstant.kColor17Light
        case .color18:
            return HabitColorConstant.kColor18
        case .color18Light:
            return HabitColorConstant.kColor18Light
        case .color19:
            return HabitColorConstant.kColor19
        case .color19Light:
            return HabitColorConstant.kColor19
        case .color20:
            return HabitColorConstant.kColor20
        case .color20Light:
            return HabitColorConstant.kColor20Light
        case .color21:
            return HabitColorConstant.kColor21
        case .color21Light:
            return HabitColorConstant.kColor21Light
        case .color22:
            return HabitColorConstant.kColor22
        case .color22Light:
            return HabitColorConstant.kColor22Light
        case .color23:
            return HabitColorConstant.kColor23
        case .color23Light:
            return HabitColorConstant.kColor23Light
        case .color24:
            return HabitColorConstant.kColor24
        case .color24Light:
            return HabitColorConstant.kColor24Light
        case .color25:
            return HabitColorConstant.kColor25
        case .color25Light:
            return HabitColorConstant.kColor25Light
        case .color26:
            return HabitColorConstant.kColor26
        case .color26Light:
            return HabitColorConstant.kColor26Light
        case .color27:
            return HabitColorConstant.kColor27
        case .color27Light:
            return HabitColorConstant.kColor27Light
        case .color28:
            return HabitColorConstant.kColor28
        case .color28Light:
            return HabitColorConstant.kColor28Light
        case .color29:
            return HabitColorConstant.kColor29
        case .color29Light:
            return HabitColorConstant.kColor29Light
        }
    }
}

struct HabitColorConstant {
    static let kColor0 = UIColor(224, 114, 76)
    static let kColor0Light = UIColor(244, 134, 96)
    static let kColor1 = UIColor(238, 210, 115)
    static let kColor1Light = UIColor(255, 230, 135)
    static let kColor2 = UIColor(136, 199, 217)
    static let kColor2Light = UIColor(156, 219, 237)
    static let kColor3 = UIColor(162, 215, 202)
    static let kColor3Light = UIColor(182, 235, 222)
    static let kColor4 = UIColor(250, 224, 167)
    static let kColor4Light = UIColor(255, 244, 187)
    static let kColor5 = UIColor(195, 175, 152)
    static let kColor5Light = UIColor(215, 1955, 172)
    static let kColor6 = UIColor(229, 163, 155)
    static let kColor6Light = UIColor(249, 183, 175)
    static let kColor7 = UIColor(162, 160, 203)
    static let kColor7Light = UIColor(182, 180, 223)
    static let kColor8 = UIColor(198, 234, 248)
    static let kColor8Light = UIColor(218, 254, 255)
    static let kColor9 = UIColor(203, 242, 194)
    static let kColor9Light = UIColor(223, 255, 214)
    static let kColor10 = UIColor(97, 159, 218)
    static let kColor10Light = UIColor(117, 179, 238)
    static let kColor11 = UIColor(238, 210, 119)
    static let kColor11Light = UIColor(255, 230, 139)
    static let kColor12 = UIColor(242, 89, 91)
    static let kColor12Light = UIColor(255, 109, 111)
    static let kColor13 = UIColor(248, 153, 55)
    static let kColor13Light = UIColor(255, 173, 75)
    static let kColor14 = UIColor(80, 151, 181)
    static let kColor14Light = UIColor(100, 171, 201)
    static let kColor15 = UIColor(92, 183, 104)
    static let kColor15Light = UIColor(112, 203, 124)
    static let kColor16 = UIColor(254, 103, 99)
    static let kColor16Light = UIColor(255, 123, 119)
    static let kColor17 = UIColor(172, 130, 235)
    static let kColor17Light = UIColor(192, 150, 255)
    static let kColor18 = UIColor(242, 89, 91)
    static let kColor18Light = UIColor(255, 109, 111)
    static let kColor19 = UIColor(248, 153, 55)
    static let kColor19Light = UIColor(255, 173, 75)
    static let kColor20 = UIColor(80, 151, 181)
    static let kColor20Light = UIColor(100, 171, 201)
    static let kColor21 = UIColor(92, 183, 104)
    static let kColor21Light = UIColor(112, 203, 124)
    static let kColor22 = UIColor(255, 102, 99)
    static let kColor22Light = UIColor(255, 122, 119)
    static let kColor23 = UIColor(172, 130, 235)
    static let kColor23Light = UIColor(192, 150, 255)
    static let kColor24 = UIColor(245, 169, 100)
    static let kColor24Light = UIColor(255, 189, 120)
    static let kColor25 = UIColor(30, 134, 194)
    static let kColor25Light = UIColor(50, 154, 214)
    static let kColor26 = UIColor(232, 104, 127)
    static let kColor26Light = UIColor(252, 124, 147)
    static let kColor27 = UIColor(101, 195, 219)
    static let kColor27Light = UIColor(121, 215, 239)
    static let kColor28 = UIColor(240, 152, 189)
    static let kColor28Light = UIColor(255, 172, 209)
    static let kColor29 = UIColor(248, 211, 123)
    static let kColor29Light = UIColor(255, 231, 143)
}
