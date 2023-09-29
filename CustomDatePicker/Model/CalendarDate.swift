//
//  CalendarDate.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 23.09.2023.
//

import Foundation

struct CalendarDate {
    var date: Date
    var calendarMonth: CalendarMonth
    var available: Bool
    
    init(date: Date, calendarMonth: CalendarMonth, available: Bool = true) {
        self.date = date
        self.calendarMonth = calendarMonth
        self.available = available
    }
}
