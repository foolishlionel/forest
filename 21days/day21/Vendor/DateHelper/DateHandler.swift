//
//  DateHandler.swift
//  day21
//
//  Created by flion on 2019/8/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit

public extension Date {
    /// Convert from String.
    /// Initializes a new Data() object based on a date string, format, optional
    ///  timezone and optional locale.
    /// - Returns: A Date() Object if successfully converted from string or nil.
    init?(
        fromString string: String,
        format: DateFormatType,
        timeZone: TimeZoneType = .local,
        locale: Locale = Foundation.Locale.current,
        isLenient: Bool = true
        ) {
        guard !string.isEmpty else { return nil }
        var string = string
        switch format {
        case .dotNet:
            let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
            let regex = try! NSRegularExpression(pattern: pattern)
            guard let match = regex.firstMatch(in: string, range: NSRange(location: 0, length: string.utf16.count)) else {
                return nil
            }
            #if swift(>=4.0)
            let dateString = (string as NSString).substring(with: match.range(at: 1))
            #else
            let dateString = (string as NSString).substring(with: match.rangeAt(1))
            #endif
            let interval = Double(dateString)! / 1000.0
            self.init(timeIntervalSince1970: interval)
            return
        case .rss, .altRSS:
            if string.hasSuffix("Z") {
                string = string[..<string.index(string.endIndex, offsetBy: -1)].appending("GMT")
            }
        default:
            break
        }
        let formatter = Date.cachedDateFormatters.cachedDateFormatter(format.stringFormat, timeZone: timeZone.timeZone, locale: locale, isLenient: isLenient)
        guard let date = formatter.date(from: string) else {
            return nil
        }
        self.init(timeInterval: 0, since: date)
    }
    
    /// Converts the date to string using the short date and time style.
    func toString(style: DateStyleType = .short) -> String {
        switch style {
        case .short:
            return toString(dateStyle: .short, timeStyle: .short, isRelative: false)
        case .medium:
            return toString(dateStyle: .medium, timeStyle: .medium, isRelative: false)
        case .long:
            return toString(dateStyle: .long, timeStyle: .long, isRelative: false)
        case .full:
            return toString(dateStyle: .full, timeStyle: .full, isRelative: false)
        case .ordinalDay:
            let numberFormatter = Date.cachedDateFormatters.cachedNumberFormatter()
            if #available(iOSApplicationExtension 9.0, *) {
                numberFormatter.numberStyle = .ordinal
            }
            return numberFormatter.string(from: component(.day)! as NSNumber)!
        case .weekday:
            let weekdaySymbols = Date.cachedDateFormatters.cachedDateFormatter().weekdaySymbols!
            let string = weekdaySymbols[component(.weekday)! - 1] as String
            return string
        case .shortWeekday:
            let shortWeekdaySymbols = Date.cachedDateFormatters.cachedDateFormatter().shortWeekdaySymbols!
            return shortWeekdaySymbols[component(.weekday)! - 1]
        case .veryShortWeekday:
            let veryShortWeekdaySymbols = Date.cachedDateFormatters.cachedDateFormatter().veryShortWeekdaySymbols!
            return veryShortWeekdaySymbols[component(.weekday)! - 1] as String
        case .month:
            let monthSymbols = Date.cachedDateFormatters.cachedDateFormatter().monthSymbols!
            return monthSymbols[component(.month)! - 1] as String
        case .shortMonth:
            let shortMonthSymbols = Date.cachedDateFormatters.cachedDateFormatter().shortMonthSymbols!
            return shortMonthSymbols[component(.month)! - 1] as String
        case .veryShortMonth:
            let veryShortMonthSymbols = Date.cachedDateFormatters.cachedDateFormatter().veryShortMonthSymbols!
            return veryShortMonthSymbols[component(.month)! - 1] as String
        }
    }
    
    /// Converts the date to string based on a date format,
    /// optional timezone and optional locale.
    func toString(
        formart: DateFormatType,
        timeZone: TimeZoneType = .local,
        locale: Locale = Locale.current
        ) -> String {
        switch formart {
        case .dotNet:
            let offset = Foundation.NSTimeZone.default.secondsFromGMT() / 3600
            let nowMillis = 1000 * timeIntervalSince1970
            return String(format: formart.stringFormat, nowMillis, offset)
        default:
            let formatter = Date.cachedDateFormatters.cachedDateFormatter(formart.stringFormat, timeZone: timeZone.timeZone, locale: locale)
            return formatter.string(from: self)
        }
    }
    
    /// Converts the date to string based on DateFormatter's date style and
    /// time style with optional relative date formatting, optional time zone
    /// and option locale
    func toString(
        dateStyle: DateFormatter.Style,
        timeStyle: DateFormatter.Style,
        isRelative: Bool = false,
        timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local,
        locale: Locale = Locale.current
        ) -> String {
        
        let formatter = Date.cachedDateFormatters.cachedDateFormatter(
            dateStyle,
            timeStyle: timeStyle,
            doesRelativeDateFormatting:
            isRelative, timeZone: timeZone,
                        locale: locale
        )
        return formatter.string(from: self)
    }
    
    
    /// Converts the date to string based on a
    /// relative time language. i.e. just now,
    /// 1 minute ago etc...
    func toStringWithRelativeTime(strings: [RelativeTimeStringType: String]? = nil) -> String {
        let time = timeIntervalSince1970
        let now = Date.current().timeIntervalSince1970
        let isPast = (now - time > 0)
        
        let sec: Double = abs(now - time)
        let min: Double = round(sec / 60)
        let hour: Double = round(min / 60)
        let day: Double = round(hour / 24)
        
        if sec < 60 {
            if sec < 10 {
                if isPast {
                    return strings?[.nowPast] ?? NSLocalizedString("just now", comment: "Date format")
                } else {
                    return strings?[.nowFuture] ?? NSLocalizedString("in a few seconds", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.secondsPast] ?? NSLocalizedString("%.f seconds ago", comment: "Date format")
                } else {
                    string = strings?[.secondsFuture] ?? NSLocalizedString("in %.f seconds", comment: "Date format")
                }
                return String(format: string, sec)
            }
        }
        
        if (min < 60) {
            if min == 1 {
                if isPast {
                    return strings?[.oneMinutePast] ?? NSLocalizedString("1 minute ago", comment: "Date format")
                } else {
                    return strings?[.oneMinuteFuture] ?? NSLocalizedString("in 1 minute", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.minutesPast] ?? NSLocalizedString("%.f minutes ago", comment: "Date format")
                } else {
                    string = strings?[.minutesFuture] ?? NSLocalizedString("in %.f minutes", comment: "Date format")
                }
                return String(format: string, min)
            }
            
        }
        
        if hour < 24 {
            if hour == 1 {
                if isPast {
                    return strings?[.oneHourPast] ?? NSLocalizedString("last hour", comment: "Date format")
                } else {
                    return strings?[.oneHourFuture] ?? NSLocalizedString("next hour", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.hoursPast] ?? NSLocalizedString("%.f hours ago", comment: "Date format")
                } else {
                    string = strings?[.hoursFuture] ?? NSLocalizedString("in %.f hours", comment: "Date format")
                }
                return String(format: string, hour)
            }
        }
        
        if day < 7 {
            if day == 1 {
                if isPast {
                    return strings?[.oneDayPast] ?? NSLocalizedString("yesterday", comment: "Date format")
                } else {
                    return strings?[.oneDayFuture] ?? NSLocalizedString("tomorrow", comment: "Date format")
                }
            } else {
                let string: String
                if isPast {
                    string = strings?[.daysPast] ?? NSLocalizedString("%.f days ago", comment: "Date format")
                } else {
                    string = strings?[.daysFuture] ?? NSLocalizedString("in %.f days", comment: "Date format")
                }
                return String(format: string, day)
            }
        }
        
        if day < 28 {
            if isPast {
                if compare(.isLastWeek) {
                    return strings?[.oneWeekPast] ?? NSLocalizedString("last week", comment: "Date format")
                } else {
                    let string = strings?[.weeksPast] ?? NSLocalizedString("%.f weeks ago", comment: "Date format")
                    return String(format: string, Double(abs(since(Date.current(), in: .week))))
                }
            } else {
                if compare(.isNextWeek) {
                    return strings?[.oneWeekFuture] ?? NSLocalizedString("next week", comment: "Date format")
                } else {
                    let string = strings?[.weeksFuture] ?? NSLocalizedString("in %.f weeks", comment: "Date format")
                    return String(format: string, Double(abs(since(Date.current(), in: .week))))
                }
            }
        }
        
        if compare(.isThisYear) {
            if isPast {
                if compare(.isLastMonth) {
                    return strings?[.oneMonthPast] ?? NSLocalizedString("last month", comment: "Date format")
                } else {
                    let string = strings?[.monthsPast] ?? NSLocalizedString("%.f months ago", comment: "Date format")
                    return String(format: string, Double(abs(since(Date.current(), in: .month))))
                }
            } else {
                if compare(.isNextMonth) {
                    return strings?[.oneMonthFuture] ?? NSLocalizedString("next month", comment: "Date format")
                } else {
                    let string = strings?[.monthsFuture] ?? NSLocalizedString("in %.f months", comment: "Date format")
                    return String(format: string, Double(abs(since(Date.current(), in: .month))))
                }
            }
        }
        
        if isPast {
            if compare(.isLastYear) {
                return strings?[.oneYearPast] ?? NSLocalizedString("last year", comment: "Date format")
            } else {
                let string = strings?[.yearsPast] ?? NSLocalizedString("%.f years ago", comment: "Date format")
                return String(format: string, Double(abs(since(Date.current(), in: .year))))
            }
        } else {
            if compare(.isNextYear) {
                return strings?[.oneYearFuture] ?? NSLocalizedString("next year", comment: "Date format")
            } else {
                let string = strings?[.yearsFuture] ?? NSLocalizedString("in %.f years", comment: "Date format")
                return String(format: string, Double(abs(since(Date.current(), in: .year))))
            }
        }
    }
    
    
    
    /// MARK: Compare Dates
    
    /// Compares dates to see if
    // they are equal while ignoring time.
    func compare(_ comparison: DateComparisonType) -> Bool {
        switch comparison {
        case .isToday:
            return compare(.isSameDay(as: Date.current()))
        case .isTomorrow:
            let comparison = Date.current().adjust(.day, offset: 1)
            return compare(.isSameDay(as: comparison))
        case .isYesterday:
            let comparison = Date.current().adjust(.day, offset: -1)
            return compare(.isSameDay(as: comparison))
        case .isSameDay(let date):
            return component(.year) == date.component(.year)
            && component(.month) == date.component(.month)
            && component(.day) == date.component(.day)
        case .isThisWeek:
            return compare(.isSameWeek(as: Date.current()))
        case .isNextWeek:
            let comparison = Date.current().adjust(.week, offset: 1)
            return compare(.isSameWeek(as: comparison))
        case .isLastWeek:
            let comparison = Date.current().adjust(.week, offset: -1)
            return compare(.isSameWeek(as: comparison))
        case .isSameWeek(let date):
            if component(.week) != date.component(.week) {
                return false
            }
            // Ensure time interval is under 1 week
            return abs(timeIntervalSince(date)) < Date.weekInSeconds
        case .isThisMonth:
            return compare(.isSameMonth(as: Date.current()))
        case .isNextMonth:
            let comparison = Date.current().adjust(.month, offset: 1)
            return compare(.isSameMonth(as: comparison))
        case .isLastMonth:
            let comparison = Date.current().adjust(.month, offset: -1)
            return compare(.isSameMonth(as: comparison))
        case .isSameMonth(let date):
            return component(.year) == date.component(.year)
            && component(.month) == date.component(.month)
        case .isThisYear:
            return compare(.isSameYear(as: Date.current()))
        case .isNextYear:
            let comparison = Date.current().adjust(.year, offset: 1)
            return compare(.isSameYear(as: comparison))
        case .isLastYear:
            let comparison = Date.current().adjust(.year, offset: -1)
            return compare(.isSameYear(as: comparison))
        case .isSameYear(let date):
            return component(.year) == date.component(.year)
        case .isInTheFuture:
            return compare(.isLater(than: Date.current()))
        case .isInThePast:
            return compare(.isEarlier(than: Date.current()))
        case .isEarlier(let date):
            return (self as NSDate).earlierDate(date) == self
        case .isLater(let date):
            return (self as NSDate).laterDate(date) == self
        case .isWeekday:
            return !compare(.isWeekend)
        case .isWeekend:
            let range = Calendar.current.maximumRange(of: Calendar.Component.weekday)!
            return (component(.weekday) == range.lowerBound || component(.weekday) == range.upperBound - range.lowerBound)
        }
    }
    
    /// MARK: Adjust date
    
    /// Creates a new date with adjusted components.
    func adjust(_ component: DateComponentType, offset: Int) -> Date {
        var dateComp = DateComponents()
        switch component {
        case .second:
            dateComp.second = offset
        case .minute:
            dateComp.minute = offset
        case .hour:
            dateComp.hour = offset
        case .day:
            dateComp.day = offset
        case .weekday:
            dateComp.weekday = offset
        case .nthWeekday:
            dateComp.weekdayOrdinal = offset
        case .week:
            dateComp.weekOfYear = offset
        case .month:
            dateComp.month = offset
        case .year:
            dateComp.year = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)!
    }
    
    // MAKR: Date for...
    func dateFor(_ type: DateForType, calendar: Calendar = Calendar.current) -> Date {
        switch type {
        case .startOfDay:
            return adjust(hour: 0, minute: 0, second: 0)
        case .endOfDay:
            return adjust(hour: 23, minute: 59, second: 59)
        case .startOfWeek:
        let tempComp = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: tempComp)!
        case .endOfWeek:
            let offset = 7 - component(.weekday)!
            return adjust(.day, offset: offset)
        case .startOfMonth:
            return adjust(hour: 0, minute: 0, second: 0, day: 1)
        case .endOfMonth:
            return adjust(hour: 0, minute: 0, second: 0, day: 0, month: month)
        case .tomorrow:
            return adjust(.day, offset: 1)
        case .yesterday:
            return adjust(.day, offset: -1)
        case .nearestMinute(let nearest):
            let minutes = (component(.minute)! + nearest / 2) / nearest * nearest
            return adjust(hour: nil, minute: minutes, second: nil)
        case .nearestHour(let nearest):
            let hours = (component(.hour)! + nearest / 2) / nearest * nearest
            return adjust(hour: hours, minute: 0, second: nil)
        }
    }
    
    /// Returns a new Date object with
    /// the new hour, minute and secodes values.
    func adjust(
        hour: Int?,
        minute: Int?,
        second: Int?,
        day: Int? = nil,
        month: Int? = nil
        ) -> Date {
        
        var comp = Date.components(self)
        comp.month = month ?? comp.month
        comp.day = day ?? comp.day
        comp.hour = hour ?? comp.hour
        comp.minute = minute ?? comp.minute
        comp.second = second ?? comp.second
        return Calendar.current.date(from: comp)!
    }
    
    /// MARK: Time since...
    func since(_ date: Date, in component: DateComponentType) -> Int64 {
        
        switch component {
        case .second:
            return Int64(timeIntervalSince(date))
        case .minute:
            let timeInterval = timeIntervalSince(date)
            return Int64(timeInterval / Date.minuteInSeconds)
        case .hour:
            let timeInterval = timeIntervalSince(date)
            return Int64(timeInterval / Date.hourInSeconds)
        case .day:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .day, in: .era, for: self)!
            let start = calendar.ordinality(of: .day, in: .era, for: date)!
            return Int64(end - start)
        case .weekday:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekday, in: .era, for: self)
            let start = calendar.ordinality(of: .weekday, in: .era, for: date)
            return Int64(end! - start!)
        case .nthWeekday:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: self)!
            let start = calendar.ordinality(of: .weekdayOrdinal, in: .era, for: date)!
            return Int64(end - start)
        case .week:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .weekOfYear, in: .era, for: self)
            let start = calendar.ordinality(of: .weekOfYear, in: .era, for: date)
            return Int64(end! - start!)
        case .month:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .month, in: .era, for: self)!
            let start = calendar.ordinality(of: .month, in: .era, for: date)!
            return Int64(end - start)
        case .year:
            let calendar = Calendar.current
            let end = calendar.ordinality(of: .year, in: .era, for: self)!
            let start = calendar.ordinality(of: .year, in: .era, for: date)!
            return Int64(end - start)
        }
    }
    
    /// MARK: Extracting components
    func component(_ component: DateComponentType) -> Int? {
        let components = Date.components(self)
        switch component {
        case .second:
            return components.second
        case .minute:
            return components.minute
        case .hour:
            return components.hour
        case .day:
            return components.day
        case .weekday:
            return components.weekday
        case .nthWeekday:
            return components.weekdayOrdinal
        case .week:
            return components.weekOfYear
        case .month:
            return components.month
        case .year:
            return components.year
        }
    }
    
    func numberOfDaysInMonth() -> Int {
        let range = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self)!
        return range.upperBound - range.lowerBound
    }
    
    func firstDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    
    func lastDayOfWeek() -> Int {
        let distanceToStartOfWeek = Date.dayInSeconds * Double(self.component(.weekday)! - 1)
        let distanceToEndOfWeek = Date.dayInSeconds * Double(7)
        let interval: TimeInterval = self.timeIntervalSinceReferenceDate - distanceToStartOfWeek + distanceToEndOfWeek
        return Date(timeIntervalSinceReferenceDate: interval).component(.day)!
    }
    
    /// MARK: Internal Components
    internal static func componentFlags() -> Set<Calendar.Component> {
        return [.year, .month, .day, .weekOfYear, .hour, .minute, .second, .weekday, .weekdayOrdinal, .weekOfYear]
    }
    internal static func components(_ fromDate: Date) -> DateComponents {
        return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
    }
    
    internal class concurrentFormatterCache {
        private static let cachedDateFormatterQueue = DispatchQueue(
            label: "date-formatter-queue", attributes: .concurrent
        )
        
        private static let cachedNumberFormatterQueue = DispatchQueue(
            label: "number-formatter-queue", attributes: .concurrent
        )
        
        private static var cachedDateFormatters = [String: DateFormatter]()
        private static var cachedNumberFormatter = NumberFormatter()
        
        private func register(hashKey: String, formatter: DateFormatter) -> Void {
            // Concurrent Queue and Async Work
            concurrentFormatterCache.cachedDateFormatterQueue.async(flags: .barrier) {
                concurrentFormatterCache.cachedDateFormatters.updateValue(formatter, forKey: hashKey)
            }
        }
        
        private func retrieveDateFormatter(hashKey: String) -> DateFormatter? {
            let dateFormatter = concurrentFormatterCache.cachedDateFormatterQueue.sync { () -> DateFormatter? in
                guard let result = concurrentFormatterCache.cachedDateFormatters[hashKey] else {
                    return nil
                }
                return result.copy() as? DateFormatter
            }
            return dateFormatter
        }
        
        private func retrieveNumberFormatter() -> NumberFormatter {
            let numberFormatter = concurrentFormatterCache.cachedNumberFormatterQueue.sync { () -> NumberFormatter in
                // Should always be NumberFormatter
                return concurrentFormatterCache.cachedNumberFormatter.copy() as! NumberFormatter
            }
            return numberFormatter
        }
        
        public func cachedDateFormatter(
            _ format: String = DateFormatType.standard.stringFormat,
            timeZone: Foundation.TimeZone = Foundation.TimeZone.current,
            locale: Locale = Locale.current,
            isLenient: Bool = true
            ) -> DateFormatter {
            
            let hashKey = "\(format.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
            if Date.cachedDateFormatters.retrieveDateFormatter(hashKey: hashKey) == nil {
                let tempFormatter = DateFormatter()
                tempFormatter.dateFormat = format
                tempFormatter.timeZone = timeZone
                tempFormatter.locale = locale
                tempFormatter.isLenient = isLenient
                
                Date.cachedDateFormatters.register(hashKey: hashKey, formatter: tempFormatter)
            }
            
            return Date.cachedDateFormatters.retrieveDateFormatter(hashKey: hashKey)!
        }
        
        public func cachedDateFormatter(
            _ dateStyle: DateFormatter.Style,
            timeStyle: DateFormatter.Style,
            doesRelativeDateFormatting: Bool,
            timeZone: Foundation.TimeZone = Foundation.NSTimeZone.local,
            locale: Locale = Locale.current,
            isLenient: Bool = true
            ) -> DateFormatter {
            
            let hashKey = "\(dateStyle.hashValue)\(timeStyle.hashValue)\(doesRelativeDateFormatting.hashValue)\(timeZone.hashValue)\(locale.hashValue)"
            if Date.cachedDateFormatters.retrieveDateFormatter(hashKey: hashKey) == nil {
                let tempFormatter = DateFormatter()
                tempFormatter.dateStyle = dateStyle
                tempFormatter.timeStyle = timeStyle
                tempFormatter.doesRelativeDateFormatting = doesRelativeDateFormatting
                tempFormatter.timeZone = timeZone
                tempFormatter.locale = locale
                tempFormatter.isLenient = isLenient
                
                Date.cachedDateFormatters.register(hashKey: hashKey, formatter: tempFormatter)
            }
            
            return Date.cachedDateFormatters.retrieveDateFormatter(hashKey: hashKey)!
        }
        
        public func cachedNumberFormatter() -> NumberFormatter {
            return Date.cachedDateFormatters.retrieveNumberFormatter()
        }
    }
    
    /// A cached static array of DateFormatters so the they are only created once.
    private static var cachedDateFormatters = concurrentFormatterCache()
    
    /// MARK: Intervals In Seconds.
    internal static let minuteInSeconds: Double = 60
    internal static let hourInSeconds: Double = 3600 // 60 * 60
    internal static let dayInSeconds: Double = 86400 // 60 * 60 * 24
    internal static let weekInSeconds: Double = 604800 // 60 * 60 * 24 * 7
    internal static let yearInSeconds: Double = 31556926 // 60 * 60 * 24 * 365
}
