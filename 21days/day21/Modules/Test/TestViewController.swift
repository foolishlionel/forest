//
//  TestViewController.swift
//  day21
//
//  Created by flion on 2018/10/13.
//  Copyright © 2018年 flion. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testDateHelper()
    }
}

extension TestViewController {
    fileprivate func testDateHelper() {
        let now = Date.current()
        let thirtySecondsForward = now.adjust(.second, offset: 30)
        let thirtySecondsBack = now.adjust(.second, offset: -30)
        ompLog("now is \(now)")
        ompLog("30 seconds forward is \(thirtySecondsForward)")
        ompLog("30 seconds back is \(thirtySecondsBack)")
        
        let lastHour = now.adjust(.hour, offset: -1)
        let nextHour = now.adjust(.hour, offset: 1)
        ompLog("last hour is \(lastHour)")
        ompLog("next hour is \(nextHour)")
        
        let twoHoursForward = now.adjust(.hour, offset: 2)
        let twoHoursBack = now.adjust(.hour, offset: -2)
        ompLog("two hours forward \(twoHoursForward)")
        ompLog("two hours back \(twoHoursBack)")
        
        let tomorrow = now.dateFor(.tomorrow)
        let yesterday = now.dateFor(.yesterday)
        ompLog("tomorrow \(tomorrow)")
        ompLog("yesterday \(yesterday)")
        
        let twoDaysForward = now.adjust(.day, offset: 2)
        let twoDaysBack = now.adjust(.day, offset: -2)
        ompLog("two days forward \(twoDaysForward)")
        ompLog("two days back \(twoDaysBack)")
        
        let nextWeek = now.adjust(.week, offset: 1)
        let lastWeek = now.adjust(.week, offset: -1)
        ompLog("next week \(nextWeek)")
        ompLog("last week \(lastWeek)")
        
        let twoWeeksForward = now.adjust(.week, offset: 2)
        let twoWeeksBack = now.adjust(.week, offset: -2)
        ompLog("two weeks forward \(twoWeeksForward)")
        ompLog("two weeks back \(twoWeeksBack)")
        
        let nextMonth = now.adjust(.month, offset: 1)
        let lastMonth = now.adjust(.month, offset: -1)
        ompLog("next month \(nextMonth)")
        ompLog("last month \(lastMonth)")
        
        let twoMonthsForward = now.adjust(.month, offset: 2)
        let twoMonthsBack = now.adjust(.month, offset: -2)
        ompLog("two months forward \(twoMonthsForward)")
        ompLog("two months back \(twoMonthsBack)")
        
        let nextYear = now.adjust(.year, offset: 1)
        let lastyear = now.adjust(.year, offset: -1)
        ompLog("next year \(nextYear)")
        ompLog("last year \(lastyear)")
        
        let twoYearsForward = now.adjust(.year, offset: 2)
        let twoYearsBack = now.adjust(.year, offset: -2)
        ompLog("two years forward \(twoYearsForward)")
        ompLog("two years back \(twoYearsBack)")
        
        
        /// Date To String
        ompLog("short style \(now.toString(style: .short))")
        ompLog("medium style \(now.toString(style: .medium))")
        ompLog("long style \(now.toString(style: .long))")
        ompLog("full style \(now.toString(style: .full))")
        ompLog("ordinal style \(now.toString(style: .ordinalDay))")
        ompLog("weekday style \(now.toString(style: .weekday))")
        ompLog("shortWeek day style \(now.toString(style: .shortWeekday))")
        ompLog("very short week day style \(now.toString(style: .veryShortWeekday))")
        ompLog("month style \(now.toString(style: .month))")
        ompLog("short month style \(now.toString(style: .shortMonth))")
        ompLog("very short month style \(now.toString(style: .veryShortMonth))")
        
        ompLog("iso year format \(now.toString(formart: .isoYear))")
        ompLog("iso year month format \(now.toString(formart: .isoYearMonth))")
        ompLog("iso date format \(now.toString(formart: .isoDate))")
        ompLog("iso date time style \(now.toString(formart: .isoDateTime))")
        ompLog("iso date time sec time \(now.toString(formart: .isoDateTimeSec))")
        ompLog("iso date time milli sec \(now.toString(formart: .isoDateTimeMilliSec))")
        ompLog("dot net format \(now.toString(formart: .dotNet))")
        ompLog("rss format \(now.toString(formart: .rss))")
        ompLog("alt rss format \(now.toString(formart: .altRSS))")
        ompLog("http header format \(now.toString(formart: .httpHeader))")
        ompLog("standard format \(now.toString(formart: .standard))")
        ompLog("custom format \(now.toString(formart: .custom("dd MM yyyy HH:mm:ss")))")
        
        ompLog("short date style, no time style, is relative \(now.toString(dateStyle: .short, timeStyle: .none, isRelative: true))")
        ompLog("no date style, short time style \(now.toString(dateStyle: .none, timeStyle: .short))")
        ompLog("short date style, no time style \(now.toString(dateStyle: .short, timeStyle: .none))")
        ompLog("short date style, short time style \(now.toString(dateStyle: .short, timeStyle: .short))")
        ompLog("medium date style, medium time style \(now.toString(dateStyle: .medium, timeStyle: .medium))")
        ompLog("long date style, long time style \(now.toString(dateStyle: .long, timeStyle: .long))")
        ompLog("full date style, full date style \(now.toString(dateStyle: .full, timeStyle: .full))")
        
        ompLog("relative time \(now.toStringWithRelativeTime())")
    }
}
