//
//  Bool+Extension.swift
//  OMPToolKit
//
//  Created by flion on 2018/11/10.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

public extension Bool {
    /// return 1 if true, or 0 if false
    /// - example: (1) false.int -> 0, (2) true.int -> 0
    public var int: Int {
        return self ? 1 : 0
    }
    
    /// return "true" if true, or "false" is false
    /// - example: (1) false.string -> "false", (2) true.string -> "true"
    public var string: String {
        return description
    }
}
