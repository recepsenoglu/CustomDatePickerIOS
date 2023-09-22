//
//  DateService.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import Foundation

class DateService {
    private var date: Date
    var titleText: String { get { "\(date.monthName()) \(date.year())" } }
    var numberOfSections: Int { get {
        let value = Double(date.dayCountOfMonth() + date.weekday() - 1) / 7
        let roundedValue = ceil(value)
        return Int(roundedValue)
    } }
    
    func goLastMonth() { date = date.addMonth(-1) }
    
    func goNextMonth() { date = date.addMonth(1) }
    
    func updateDate(_ date: Date) {
        self.date = date.resetMonth()
    }
    
    func getCalendarDay(_ indexPath: IndexPath) -> (day: Int, isInThisMonth: Bool) {
        let weekday = date.weekday()
        let index = indexPath.section * 7 + indexPath.row
        let dayCountOfMonth = date.dayCountOfMonth()
        var day: Int = index - (weekday - 2)
        var isInThisMonth: Bool = true
        
        if index < weekday - 1 {
            isInThisMonth = false
            day = date.dayCountOfLastMonth() - (weekday - index - 2)
        } else if index > dayCountOfMonth + weekday - 2 {
            isInThisMonth = false
            day = index - (dayCountOfMonth + weekday - 2)
        }
        return (day: day, isInThisMonth: isInThisMonth)
    }
    
    init(initialDate date: Date = Date()) {
        self.date = date.resetMonth()
        print(self.date.weekday())
    }
}
