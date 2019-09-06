//
//  HabitListInteractor.swift
//  day21
//
//  Created by flion on 2018/11/20.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import Then

class HabitListInteractor: NSObject {
    public var sections: [[Habit]] {
        get {
            return [bodyHabits, learnHabits, thoughtHabits, healthHabits, emotionHabits]
        }
    }
    
    fileprivate var bodyHabits = [Habit]()
    fileprivate var learnHabits = [Habit]()
    fileprivate var thoughtHabits = [Habit]()
    fileprivate var healthHabits = [Habit]()
    fileprivate var emotionHabits = [Habit]()
    
    override init() {
        super.init()
        guard let path = Bundle.main.path(forResource: "BuildInHabitList.plist", ofType: nil) else {
            fatalError("ERROR: Default habit list plist file empty!!!")
        }
        let rootDic = NSDictionary(contentsOfFile: path) as! [String: Any]
        
        let habitDics = rootDic["habitList"] as! [[String: Any]]
        for habitDic in habitDics {
            ompLog("habit dic \(habitDic)")
            let habit = createHabit(dic: habitDic)
            let category = habit.mirror.category
            switch category {
            case .life:
                bodyHabits.append(habit)
            case .learn:
                learnHabits.append(habit)
            case .emotion:
                emotionHabits.append(habit)
            case .sport:
                thoughtHabits.append(habit)
            case .health:
                healthHabits.append(habit)
            case .other:
                emotionHabits.append(habit)
            case .empty:
                break
            }
        }
        
    }
    
    fileprivate func createHabit(dic: [String: Any]) -> Habit {
        let name = dic["name"] as! String
        let color = HabitColor(rawValue: dic["color"] as! Int) ?? .color0
        let icon = HabitIcon(rawValue: dic["icon"] as! Int) ?? .book
        let category = HabitCategory(rawValue: dic["category"] as! Int) ?? .life
        let words = dic["encourageWords"] as? String
        
        let mirror = HabitMirror(icon: icon, color: color, category: category)

        let habit = Habit(name: name, mirror: mirror, encourageWords: words)
        return habit
    }

}
