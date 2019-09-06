//
//  DatabaseManager.swift
//  day21
//
//  Created by flion on 2018/11/15.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit
import SQLite
import Then

class DatabaseHandleProvider: NSObject {
    static let shared = DatabaseHandleProvider()
    
    lazy var db: Connection = {
        return try! Connection(dbPath)
    }()
    
    fileprivate let dbPath: String = {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let filename = "day21DB.sqlite3"
        let temp = "\(path)/\(filename)"
        ompLog("sandbox filepath is \(temp)")
        return temp
    }()
}

