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
    var minDate: Date
    var maxDate: Date
    var monthsForPicker: [String] = []
    var yearsForPicker: [String] = []
    var titleText: String { get { "\(date.monthName()) \(date.year())" } }
    var numberOfSections: Int { get {
        let value = Double(date.dayCountOfMonth() + date.firstWeekday() - 1) / 7
        let roundedValue = ceil(value)
        return Int(roundedValue)
    } }
    
    
    init(initialDate date: Date = Date()) {
        maxDate = date.updateComponent(.day, date.day() + 4)
        minDate = date.updateComponent(.year, date.year() - 4)
        self.date = date
        updatePickerValues()
    }
        
    private func setMonthsForPicker() {
        let minMonth = date.year() == minDate.year() ? minDate.month() : 1
        let maxMonth = date.year() == maxDate.year() ? maxDate.month() : 12
        monthsForPicker.removeAll()
        monthsForPicker.append(contentsOf: Date.months[(minMonth-1)...(maxMonth-1)])
    }
    
    private func setYearsForPicker() {
        yearsForPicker.removeAll()
        print(minDate.toString())
        print(maxDate.toString())
        for year in minDate.year()...maxDate.year() {
            yearsForPicker.append(String(year))
        }
    }
    
    private func updatePickerValues() {
        setMonthsForPicker()
        setYearsForPicker()
    }

    func setMinDate(_ date: Date) {
        minDate = date
        updatePickerValues()
    }
    
    func setMaxDate(_ date: Date) {
        print(maxDate.toString("dd.MM.yyyy hh:mm"))
        maxDate = date
        print(maxDate.toString("dd.MM.yyyy hh:mm"))
        updatePickerValues()
    }
    
    func isInMinDate() -> Bool { date.year() == minDate.year() && date.month() == minDate.month() }
    func isInMaxDate() -> Bool { date.year() == maxDate.year() && date.month() == maxDate.month() }
    
    func updateDate(_ date: Date) -> Bool? {
        guard date.isAfterOrEqual(minDate) && date.isBeforeOrEqual(maxDate) else { return false }
        self.date = date
        return true
    }

    func goLastMonth() {
        if isInMinDate() == false { date = date.decreaseMonth() }
    }
    
    func goNextMonth() {
        if isInMaxDate() == false { date = date.increaseMonth() }
    }

    func getCalendarDate(_ indexPath: IndexPath) -> CalendarDate {
        let weekday = date.firstWeekday()
        let index = indexPath.section * 7 + indexPath.row
        let dayCountOfMonth = date.dayCountOfMonth()
        var day = index - (weekday - 2)
        var calendarMonth: CalendarMonth = .Current
        var dateOfIndex = date
        if index < weekday - 1 {
            calendarMonth = .Last
            day = date.dayCountOfLastMonth() - (weekday - index - 2)
            dateOfIndex = dateOfIndex.decreaseMonth()
        } else if index > dayCountOfMonth + weekday - 2 {
            calendarMonth = .Next
            day = index - (dayCountOfMonth + weekday - 2)
            dateOfIndex = dateOfIndex.increaseMonth()
        }
        dateOfIndex = dateOfIndex.updateComponent(.day, day)
        let available = dateOfIndex.isAfterOrEqual(minDate) && dateOfIndex.isBeforeOrEqual(maxDate)
        return CalendarDate(date: dateOfIndex, calendarMonth: calendarMonth, available: available)
    }
    
    func daySelected(_ indexPath: IndexPath) -> Date? {
        let calendarDate = getCalendarDate(indexPath)
        var selectedDate = date
        if calendarDate.calendarMonth == .Last {
            selectedDate = selectedDate.decreaseMonth()
        } else if calendarDate.calendarMonth == .Next {
            selectedDate = selectedDate.increaseMonth()
        }
        selectedDate = selectedDate.updateComponent(.day, calendarDate.date.day())
        if updateDate(selectedDate) ?? false {
            return selectedDate
        }
        return nil
    }
    
    func pickerValueChanged(_ row: Int, _ component: Int) {
        if component == 0 {
            guard let month = Date.months.firstIndex(of: monthsForPicker[row]) else { return }
            date = date.updateComponent(.month, month + 1)
            updatePickerValues()
        } else {
            guard let year = Int(yearsForPicker[row]) else { return }
            date = date.updateComponent(.year, year)
            updatePickerValues()
            if date.isAfter(maxDate) {
                date = date.updateComponent(.month, (Date.months.firstIndex(of: monthsForPicker.last!) ?? 0) + 1)
            }
            if date.isBefore(minDate) {
                date = date.updateComponent(.month, (Date.months.firstIndex(of: monthsForPicker.first!) ?? 0) + 1)
            }
        }
    }
}
