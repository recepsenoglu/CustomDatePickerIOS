//
//  DateService.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import Foundation

enum CalendarMonth {
    case Last
    case Current
    case Next
}

class DateService {
    var date: Date
    var titleText: String { get { "\(date.monthName()) \(date.year())" } }
    var numberOfSections: Int { get {
        let value = Double(date.dayCountOfMonth() + date.weekday() - 1) / 7
        let roundedValue = ceil(value)
        return Int(roundedValue)
    } }
    
    func goLastMonth() { date = date.addMonth(-1) }
    
    func goNextMonth() { date = date.addMonth(1) }
    
    func updateDate(_ date: Date) {
        self.date = date.updateDay()
    }
    
    func getCalendarDate(_ indexPath: IndexPath) -> (date: Date, calendarMonth: CalendarMonth) {
        let weekday = date.weekday()
        let index = indexPath.section * 7 + indexPath.row
        let dayCountOfMonth = date.dayCountOfMonth()
        var day = index - (weekday - 2)
        var calendarMonth: CalendarMonth = .Current
        var dateOfIndex = date
        if index < weekday - 1 {
            calendarMonth = .Last
            day = date.dayCountOfLastMonth() - (weekday - index - 2)
            dateOfIndex = dateOfIndex.addMonth(-1)
        } else if index > dayCountOfMonth + weekday - 2 {
            calendarMonth = .Next
            day = index - (dayCountOfMonth + weekday - 2)
            dateOfIndex = dateOfIndex.addMonth(1)
        }
        dateOfIndex = dateOfIndex.updateDay(day)
        return (date: dateOfIndex, calendarMonth: calendarMonth)
    }
    
    func daySelected(_ indexPath: IndexPath) -> Date {
        let calendarDate = getCalendarDate(indexPath)
        var selectedDate = date
        if calendarDate.calendarMonth == .Last {
            selectedDate = selectedDate.addMonth(-1)
        } else if calendarDate.calendarMonth == .Next {
            selectedDate = selectedDate.addMonth(1)
        }
        date = selectedDate
        return selectedDate.updateDay(calendarDate.date.day())
    }
    
    init(initialDate date: Date = Date()) {
        self.date = date.updateDay()
    }
}
