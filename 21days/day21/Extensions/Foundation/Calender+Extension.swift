//
//  Calender+Extension.swift
//  OMPToolKit
//
//  Created by flion on 2018/11/12.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

public extension Calendar {
    /// Return the number of days in the month for a specified 'Date'.
    ///     - example:
    ///         let date = Date() // 2018 10 21 19:00:33
    ///         Calendar.current.numberOfDaysInMonth(for: date) -> 31
    /// Parameter date: the date from which the number of days in month is calculated
    /// Returns: The number of days in the month of 'Date'.
    public func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }
}
