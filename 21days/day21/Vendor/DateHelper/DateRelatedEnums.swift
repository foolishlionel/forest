//
//  DateRelatedEnums.swift
//  day21
//
//  Created by flion on 2019/8/2.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit



/// The string format used for date string conversion.
public enum DateFormatType {
    /// The ISO8601 formatted year "yyyy" i.e. 1997
    case isoYear
    
    /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
    case isoYearMonth
    
    /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-09-07
    case isoDate
    
    /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07016T19:20+01:00
    case isoDateTime
    
    /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07016T19:20:30+01:00
    case isoDateTimeSec
    
    /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
    case isoDateTimeMilliSec
    
    /// The dotNet formatted date "/Date(%d%d)/" i.e. "/(Date(1268123281843)/"
    case dotNet
    
    /// The RSS formatted date "EEE, d MM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
    case rss
    
    /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
    case altRSS
    
    /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
    case httpHeader
    
    /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
    case standard
    
    /// A custom date format string
    case custom(String)
    
    
    var stringFormat: String {
        switch self {
        case .isoYear:
            return "yyyy"
        case .isoYearMonth:
            return "yyyy-MM"
        case .isoDate:
            return "yyyy-MM-dd"
        case .isoDateTime:
            return "yyyy-MM-dd'T'HH:mmZ"
        case .isoDateTimeSec:
            return "yyyy-MM-dd'T'HH:mm:ssZ"
        case .isoDateTimeMilliSec:
            return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        case .dotNet:
            return "/Date(%d%f)/"
        case .rss:
            return "EEE, d MMM yyyy HH:mm:ss ZZZ"
        case .altRSS:
            return "d MMM yyyy HH:mm:ss ZZZ"
        case .httpHeader:
            return "EEE, dd MM yyyy HH:mm:ss ZZZ"
        case .standard:
            return "EEE MMM dd HH:mm:ss Z yyyy"
        case .custom(let customFormat):
            return customFormat
        }
    }
}

/// The time zone to be used for date conversion.
public enum TimeZoneType {
    case local
    case `default`
    case utc
    case custom(Int)
    
    /**
     NOTE:
        UTC时间：通用协调时(Universal Time Coordinated)，
        与格林尼治平均时(GMT, Greenwich Mean Time)一样，
        都是与英国伦敦的本地时相同。
     */
    
    var timeZone: TimeZone {
        switch self {
        case .local:
            return NSTimeZone.local
        case .default:
            return NSTimeZone.default
        case .utc:
            return TimeZone(secondsFromGMT: 0)!
        case .custom(let gmt):
            return TimeZone.init(secondsFromGMT: gmt)!
        }
    }
}

/// The string keys to modify the strings in relative format.
public enum RelativeTimeStringType {
    case nowPast
    case nowFuture
    case secondsPast
    case secondsFuture
    case oneMinutePast
    case oneMinuteFuture
    case minutesPast
    case minutesFuture
    case oneHourPast
    case oneHourFuture
    case hoursPast
    case hoursFuture
    case oneDayPast
    case oneDayFuture
    case daysPast
    case daysFuture
    case oneWeekPast
    case oneWeekFuture
    case weeksPast
    case weeksFuture
    case oneMonthPast
    case oneMonthFuture
    case monthsPast
    case monthsFuture
    case oneYearPast
    case oneYearFuture
    case yearsPast
    case yearsFuture
}

/// The type of comparison to do against today's date or with the supplied date.
public enum DateComparisonType {
    // Days
    
    /// Checks if date today.
    case isToday
    
    /// Checks if date is tomorrow.
    case isTomorrow
    
    /// Checks if date is yesterday.
    case isYesterday
    
    /// Compares date days
    case isSameDay(as: Date)
    
    
    
    /// Weeks
    
    /// Checks if date is in this week.
    case isThisWeek
    
    /// Checks is date is in next week.
    case isNextWeek
    
    /// Checks if date is in last week.
    case isLastWeek
    
    /// Compares date weeks
    case isSameWeek(as: Date)
    
    
    
    /// Months
    
    /// Checks if date is in this month.
    case isThisMonth
    
    /// Checks if date is in next month.
    case isNextMonth
    
    /// Checks if date is in last month.
    case isLastMonth
    
    /// Compares date months
    case isSameMonth(as: Date)
    
    
    
    /// Years
    
    /// Checks if date is in this year.
    case isThisYear
    
    /// Checks if date is in next year.
    case isNextYear
    
    /// Checks if date is in last year.
    case isLastYear
    
    /// Compares date years
    case isSameYear(as: Date)
    
    
    
    /// Relative Time
    
    /// Checks if it's future time
    case isInTheFuture
    
    /// Checks if the date has passed
    case isInThePast
    
    /// Checks if earlier than date
    case isEarlier(than: Date)
    
    /// Checks if later than date
    case isLater(than: Date)
    
    /// Checks if it's a weekday
    case isWeekday
    
    /// Checks if it's a weekend
    case isWeekend
    
}

/// The date components available to be retrieved or modified.
public enum DateComponentType {
    case second
    case minute
    case hour
    case day
    case weekday
    case nthWeekday
    case week
    case month
    case year
}

/// The type of date that can be used for the `dateFor` function.
public enum DateForType {
    case startOfDay
    case endOfDay
    case startOfWeek
    case endOfWeek
    case startOfMonth
    case endOfMonth
    case tomorrow
    case yesterday
    case nearestMinute(minute: Int)
    case nearestHour(hour: Int)
}

/// Convenience types for date to string conversion.
public enum DateStyleType {
    /// Short style: "2/27/17, 1:22 PM"
    case short
    
    /// Medium style: "Feb 27, 2017, 2:22:06 PM"
    case medium
    
    /// Long style: "February 27, 2017 at 2:22:06 PM EST"
    case long
    
    /// Full style: "Monday, February 27, 2017 at 2:22:06 PM Eastern Standard Time"
    case full
    
    /// Ordinal day: "27th"
    case ordinalDay // 顺序的
    
    /// Weekday: "Monday"
    case weekday
    
    /// Short week day: "Mon"
    case shortWeekday
    
    /// Very short weekday: "M"
    case veryShortWeekday
    
    /// Month: "February"
    case month
    
    /// Short month: "Feb"
    case shortMonth
    
    /// Very short month: "F"
    case veryShortMonth
}
