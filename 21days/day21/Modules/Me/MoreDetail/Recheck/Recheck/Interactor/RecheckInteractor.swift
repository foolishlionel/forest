//
//  RecheckInteractor.swift
//  day21
//
//  Created by flion on 2019/1/17.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

class RecheckInteractor: NSObject {
    func loadUsefulRecheckCards() -> [RetroactCheckCard] {
        return RetroactCheckCardDBManager.shared.usefullRecheckCards()
    }
}
