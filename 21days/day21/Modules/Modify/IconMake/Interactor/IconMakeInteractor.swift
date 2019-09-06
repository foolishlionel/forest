//
//  IconMakeInteractor.swift
//  day21
//
//  Created by flion on 2019/6/28.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class IconMakeInteractor: NSObject {
    
    fileprivate var totalHabitMirrors: [[HabitMirror]] = []
    fileprivate var lifeMirrors: [HabitMirror] = []
    fileprivate var healthMirrors: [HabitMirror] = []
    fileprivate var sportMirrors: [HabitMirror] = []
    fileprivate var learnMirrors: [HabitMirror] = []
    fileprivate var emotionMirrors: [HabitMirror] = []
    fileprivate var otherMirrors: [HabitMirror] = []
    
    override init() {
        
        let fullIcons = ModifyHabitIconProvider.defaultIcons()
        
        for icon in fullIcons {
            let rawValue = icon.rawValue
            if rawValue >= 100 && rawValue < 200 {
                let mirror = HabitMirror(icon: icon, color: HabitColor.color1, category: .life)
                lifeMirrors.append(mirror)
            } else if rawValue >= 200 && rawValue < 300 {
                let mirror = HabitMirror(icon: icon, color: HabitColor.color1, category: .health)
                healthMirrors.append(mirror)
            } else if rawValue >= 300 && rawValue < 400 {
                let mirror = HabitMirror(icon: icon, color: .color1, category: .sport)
                sportMirrors.append(mirror)
            } else if rawValue >= 400 && rawValue < 500 {
                let mirror = HabitMirror(icon: icon, color: .color1, category: .learn)
                learnMirrors.append(mirror)
            } else if rawValue >= 500 && rawValue < 600 {
                let mirror = HabitMirror(icon: icon, color: .color1, category: .emotion)
                emotionMirrors.append(mirror)
            } else {
                let mirror = HabitMirror(icon: icon, color: .color1, category: .other)
                otherMirrors.append(mirror)
            }
        }
        totalHabitMirrors.append(contentsOf: [lifeMirrors, healthMirrors, sportMirrors, learnMirrors, emotionMirrors, otherMirrors])
    }
    
    func doubleLevelHabitMirrors() -> [[HabitMirror]] {
        return totalHabitMirrors
    }
}
