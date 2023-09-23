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
    
    init(date: Date, calendarMonth: CalendarMonth) {
        self.date = date
        self.calendarMonth = calendarMonth
    }
}
