//
//  OPEnumableType.swift
//  day21
//
//  Created by flion on 2019/7/10.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

protocol OPEnumableType {
    static var allValues: [Self] { get }
}
