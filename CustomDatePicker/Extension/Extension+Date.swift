//
//  Extension+Date.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import Foundation

extension Date {
    func toString(_ dateFormat: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    private func components() -> DateComponents {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.locale = Locale(identifier: "en_US_POSIX")
        let components = calendar.dateComponents([.day, .month, .year, .weekday, .weekOfMonth], from: self)
        return components
    }
    
    func day() -> Int {components().day ?? 1 }
    
    func month() -> Int? { components().month }
    
    func year() -> Int { components().year ?? 0 }
    
    func monthName() -> String {
        guard let month = month() else { return "" }
        return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][month - 1]
    }
    
    func dayCountOfMonth(_ date: Date? = nil) -> Int {
        let date = date ?? self
        if let range = Calendar.current.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 30
    }
    
    func addMonth(_ value: Int) -> Date {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: value, to: self) {
            return newDate
        }
        return self
    }
    
    func dayCountOfLastMonth() -> Int {
        return dayCountOfMonth(addMonth(-1))
    }
    
    func weekday() -> Int {
        let weekday = components().weekday ?? 1
        return weekday == 1 ? 7 : weekday - 1
    }
    
    func updateDay(_ value: Int = 1) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = -(self.day()) + value
        return calendar.date(byAdding: dateComponents, to: self) ?? self
    }
    
    func isEqual(_ date: Date?) -> Bool {
        return self.toString() == date?.toString()
    }
}
