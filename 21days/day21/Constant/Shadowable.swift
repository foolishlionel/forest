//
//  Shadowable.swift
//  day21
//
//  Created by flion on 2019/2/1.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

protocol Shadowable {
    func addAllRoundLayer()
}

extension Shadowable where Self: UIView {
    func addAllRoundLayer() {
        ompLog(frame)
    }
}
