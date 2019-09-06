//
//  Common.swift
//  OMPToolKit
//
//  Created by flion on 2018/10/29.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

/// 屏幕宽度
let kScreenWidth = UIScreen.main.bounds.width
/// 屏幕高度
let kScreenHeight = UIScreen.main.bounds.height

/// 适配iPhoneX
let kStatusBarHeight = UIApplication.shared.statusBarFrame.height // 44 or 20
let isIPhoneXOrUpgrades = (kStatusBarHeight > 40.0)
let isIPhone5 = (UIScreen.main.bounds.size == CGSize(width: 640, height: 1136))
let kNaviBarHeight: CGFloat = isIPhoneXOrUpgrades ? 88.0 : 64.0
let kTabBarHeight: CGFloat = isIPhoneXOrUpgrades ? 49.0 + 34.0 : 49.0
let iPhoneXBottomHeight: CGFloat = 34.0
let iPhoneXTopHeight: CGFloat = 24.0

let kThemeWhiteColor = UIColor(hex: 0xFFFFFF)
let kThemeWhiteSmokeColor = UIColor(hex: 0xF5F5F5)
let kThemeMistyRoseColor = UIColor(hex: 0xFFE4E1)  // 薄雾玫瑰
let kThemeGainsboroColor = UIColor(hex: 0xF3F4F5)  // 亮灰色
let kThemeOrangeRedColor = UIColor(hex: 0xFF4500)  // 橙红色
let kThemeLimeGreenColor = UIColor(hex: 0x32CD32)  // 酸橙绿
let kThemeSnowColor = UIColor(hex: 0xFFFAFA)
let kThemeLightGreyColor = UIColor(hex: 0xD3D3D3)
let kThemeGreyColor = UIColor(hex: 0xA9A9A9)
let kThemeTomatoColor = UIColor(hex: 0xF7583B)
let kThemeDimGrayColor = UIColor(hex: 0x696969)
let kThemeBlackColor = UIColor(hex: 0x000000)
let kThemeBackgroundColor = UIColor(hex: 0xF4F4F4)

let kHabitIconBisqueColor = UIColor(hex: 0xFFE4C4)
let kHabitIconBurlyWoodColor = UIColor(hex: 0xDEB887)
let kHabitIconCornflowerBlueColor = UIColor(hex: 0x6495ED)
let kHabitIconCyanColor = UIColor(hex: 0x00FFFF)
let kHabitIconDarkCyanColor = UIColor(hex: 0x008B8B)
let kHabitIconDarkSalmonColor = UIColor(hex: 0xE9967A)
let kHabitIconDeepSkyBlueColor = UIColor(hex: 0x00BFFF)
let kHabitIconGreenYellowColor = UIColor(hex: 0xADFF2F)
let kHabitIconLavenderColor = UIColor(hex: 0xE6E6FA)
let kHabitIconLightPinkColor = UIColor(hex: 0xFFB6C1)
let kHabitIconPlumColor = UIColor(hex: 0xDDA0DD)
let kHabitIconThistleColor = UIColor(hex: 0xD8BFD8)
let kHabitIconTomatoColor = UIColor(hex: 0xFF6347)


/// MARK: - 颜色方法
func ompRGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.9, alpha: a)
}

/// MARK: - 自定义打印方法
func ompLog<T>(_ message: T,
               file: String = #file,
               functionName: String = #function,
               lineNumber: Int = #line) {
    #if DEBUG
    let filename = (file as NSString).lastPathComponent
    print("\(filename):\(lineNumber)-\(message)")
    #endif
}

func appVersion() -> String {
    guard let infoDic = Bundle.main.infoDictionary else {
        fatalError("ERROR: INFO DICTIONARY EMPTY")
    }
    return infoDic["CFBundleShortVersionString"] as! String
}

