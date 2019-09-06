//
//  ModifyInteractor.swift
//  day21
//
//  Created by flionel on 2018/11/23.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

class ModifyInteractor: NSObject {
    
    func createDBHabit(forHabit habit: Habit, completionBlock block: ((Bool) -> Void)?) {
        guard habit.name.count > 0 else { fatalError("NAME IS EMPTY") }
        HabitDBManager.shared.insertTable(habit: habit) { succeed in
            block?(succeed)
        }
    }
    
    func updateDBHabit(forHabit habit: Habit, completionBlock block: ((Habit) -> Void)?) {
        HabitDBManager.shared.updateHabit(withHabit: habit) { succeed in
            ompLog("IS UPDATE SUCCEED \(succeed)")
            block?(habit)
        }
    }
    
    func randomEncourageWords() -> String {
        guard let path = Bundle.main.path(forResource: "RandomEncourageWords.plist", ofType: nil) else {
            fatalError("ERROR: Random Encourage Word File empty!!!")
        }
        let rootDic = NSDictionary(contentsOfFile: path) as! [String: Any]
        
        let wordList = rootDic["encourageWordList"] as! [String]
        let randomNumber = Int(arc4random()) % wordList.count
        return wordList[randomNumber];
        
    }
}
