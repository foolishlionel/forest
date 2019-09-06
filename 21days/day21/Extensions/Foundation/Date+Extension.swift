//
//  Date+Extension.swift
//  day21
//
//  Created by flion on 2018/12/3.
//  Copyright © 2018 flion. All rights reserved.
//

import UIKit

public extension Date {
    
    /// What day is it today
//    public var weekday: Int {
//        let weekdayGregorian = appCalendar.component(.weekday, from: self)
//        // 字典[:]
//        let weekDayLocals = [1: 7, 2: 1, 3: 2, 4: 3, 5: 4, 6: 5, 7: 1]
//        return weekDayLocals[weekdayGregorian] ?? 1
//    }
    
}

public extension Date {
    /// Date string from date.
    /// - Parameter format: Date format (default is "dd/MM/yyyy")
    /// - Returns: date string
    public func string(withFormat format: String = "dd/MM/yyyy HH:mm:ss") -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.string(from: self)
    }
    
    /// Date from date string
    public func date(from string: String, withFormat format: String = "dd/MM/yyyy HH:mm:ss") -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.date(from: string)
    }
    
    /// Date string from date
    /// - Parameter style: DateFormatter style (default is .medium)
    /// Returns: date string
    public func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /// Time string from date
    /// - Parameter style: DateFormatter style (default is .medium)
    /// - Returns: time string
    public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    public func daysBetweenDate(toDate: Date) -> Int {
//        let components = Calendar.current.dateComponents([.day], from:self, to: toDate)
//        return components.day ?? 0
        let startDay = Calendar.current.ordinality(of: .day, in: .era, for: self)
        let endDay = Calendar.current.ordinality(of: .day, in: .era, for: toDate)
        return endDay! - startDay!
    }
    
    public func hourValue() -> Int {
        let hour = Calendar.current.dateComponents([.hour], from: self).hour ?? 0
        return hour
    }
    
    public func minuteValue() -> Int {
        let minute = Calendar.current.dateComponents([.minute], from: self).minute ?? 0
        return minute
    }
    
    public func secondValue() -> Int {
        let second = Calendar.current.dateComponents([.second], from: self).second ?? 0
        return second
    }
}

extension Date {
    static func date(from string: String, withFromat format: String = "dd/MM/yyyy HH:mm:ss") -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.date(from: string)
    }
}

extension Date {
    func startOfCurrentYear() -> Date {
        let timeZone = appCalendar.timeZone
        
        let components = appCalendar.dateComponents([.year], from: self)
        let year = appCalendar.date(from: components)!
        
        let difference = timeZone.secondsFromGMT(for: year)
        let startOfYear = Date(timeInterval: TimeInterval(difference), since: year)
        return startOfYear
        
    }
    
    func endOfCurrentYear(returnEndTime: Bool = true) -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.year = 1
        if returnEndTime {
            components.second = -1
        } else {
            components.day = -1
        }
        
        let endOfYear = calendar.date(byAdding: components, to: startOfCurrentYear())!
        return endOfYear
    }
}

extension Date {
    func startOfCurrentMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month]), from: self)
        return calendar.date(from: components)!
    }
    
    func endOfCurrentMonth() -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.month = 1
        components.second = -1
        
        let start = startOfCurrentMonth()
        let end = calendar.date(byAdding: components, to: start)!
        return end
    }
}

extension Date {
    func startOfCurrentWeek() -> Date? {
        let gregorian = Calendar.init(identifier: .gregorian)
        if let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekday], from: self)) {
            return gregorian.date(byAdding: .day, value: 1, to: sunday)
        }
        return nil
    }
    
    func endOfCurrentWeek() -> Date? {
        let gregorian = Calendar(identifier: .gregorian)
        if let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) {
            return gregorian.date(byAdding: .day, value: 7, to: sunday)
        }
        return nil
    }
}

extension Date {
    func dateBefore(days: Int) -> Date {
        let interval = TimeInterval(-days * 24 * 60 * 60)
        let before = addingTimeInterval(interval)
        return before
    }
    
    func dateAfter(days: Int) -> Date {
        let interval = TimeInterval(days * 24 * 60 * 60)
        let after = addingTimeInterval(interval)
        return after
    }
}

extension Date {
    func previousMonthDate() -> Date {
        let calendar = Calendar.current
        var lastMonthComponents = DateComponents()
        lastMonthComponents.month = -1 // 设置前一个月的时间
        let preDate = calendar.date(byAdding: lastMonthComponents, to: self)!
        return preDate
    }
    
    func nextMonthDate() -> Date {
        let calendar = Calendar.current
        var nextMonthComponents = DateComponents()
        nextMonthComponents.month = 1
        let nextDate = calendar.date(byAdding: nextMonthComponents, to: self)!
        return nextDate
    }
}

extension Date {
    
    func isPreviousOneMonth(compareDate: Date) -> Bool {
        let selfYearNumber = yearNumber
        let selfMonthNumber = monthNumber
        let compareYearNumer = compareDate.yearNumber
        let compareMonthNumber = compareDate.monthNumber
        if selfYearNumber == compareYearNumer - 1  {
            return (selfYearNumber == 12 && compareYearNumer == 1)
        }
        
        if selfYearNumber == compareYearNumer {
            return selfMonthNumber == compareMonthNumber - 1
        }
        return false
    }
    
    func isSameYear(compareDate: Date) -> Bool {
        return yearNumber == compareDate.yearNumber
    }
    
    func isSameYearMonth(compareDate: Date) -> Bool {
        return (yearNumber == compareDate.yearNumber && monthNumber == compareDate.monthNumber)
    }
    
    var yearNumber: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: self)
        return components.year!
    }
    
    var monthNumber: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: self)
        return components.month!
    }
    
    var dayNumber: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents(Set<Calendar.Component>([.year, .month, .day]), from: self)
        return components.day!
    }
    
    func isPreviousYear() -> Bool {
        let compareYear = self.yearNumber
        let currentYear = Date().yearNumber
        return compareYear < currentYear
    }
    
    
}

extension Date {
    func isLessNotEqual(compare date: Date) -> Bool {
        let isSameDay = compare(.isSameDay(as: date))
        return self < date && !isSameDay
    }
    
    func isLessOrEqual(compare date: Date) -> Bool {
        let isSameDay = compare(.isSameDay(as: date))
        return self < date || isSameDay
    }
    
    func isLargerOrEqual(compare date: Date) -> Bool {
        let isSameDay = compare(.isSameDay(as: date))
        return self > date || isSameDay
    }
    
    
}
