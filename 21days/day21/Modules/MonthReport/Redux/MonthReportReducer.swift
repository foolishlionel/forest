//
//  MonthReportReducer.swift
//  day21
//
//  Created by flion on 2019/1/23.
//  Copyright © 2019 flion. All rights reserved.
//

import UIKit
import ReSwift

func monthReportReducer(action: MonthReportAction, state: MonthReportState?) -> MonthReportState? {
    var newState: MonthReportState? = nil
    switch action {
    case .clickPrevious:
        newState = clickPrevious(state: state)
    case .clickNext:
        newState = clickNext(state: state)
    case .loadHabits(let habits):
        newState = loadHabits(state: state, habits: habits)
    }
    return newState!
}

fileprivate func clickPrevious(state: MonthReportState?) -> MonthReportState? {
    guard var state = state else { return nil }
    state.isNextButtonClickEnabled = true
    state.selectMonth = state.selectMonth.previousMonthDate()
    return state
}

fileprivate func clickNext(state: MonthReportState?) -> MonthReportState? {
    guard var state = state else { return nil }
    if state.selectMonth.nextMonthDate().compare(.isToday) {
        state.isNextButtonClickEnabled = false
    } else {
        state.selectMonth = state.selectMonth.nextMonthDate()
    }
    return state
}

fileprivate func loadHabits(state: MonthReportState?, habits: [Habit]) -> MonthReportState? {
    var state = state
    let newVMs = habits.map { SecondMenuCellViewModel.init(name: $0.name, icon: $0.mirror.icon, color: $0.mirror.color, selected: false) }
    state?.secondMenuVMs = newVMs
    return state
}
