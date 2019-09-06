//
//  User.swift
//  day21
//
//  Created by flion on 2018/12/29.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

enum UserGender: Int {
    case male = 0
    case female = 1
}

class User: NSObject {
    var id: Int64 = 0
    var telephone: String = ""
    var email: String = ""
    var password: String = ""
    var wxOpenId: String = ""
    var wxUnionId: String = ""
    
    var name: String = ""
    var nickname: String = ""
    var avatar: String = ""
    var avatarImage = UIImage(named: "tabbarIconUserSelect")
    var age: Int = 0
    var gender: UserGender = .female
    var address: String = ""
    var goldIntegral: Int = 0
}
