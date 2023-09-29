//
//  Extension+Date.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import Foundation

extension Date {
    static var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    func toString(_ dateFormat: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    private func components() -> DateComponents {
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.locale = Locale(identifier: "en_US_POSIX")
        let components = calendar.dateComponents([.minute, .hour, .day, .month, .year, .weekday, .weekOfMonth], from: self)
        return components
    }
    
    func minute() -> Int { components().minute ?? 0}
    
    func hour() -> Int { components().hour ?? 0}
    
    func day() -> Int {components().day ?? 1 }
    
    func month() -> Int { components().month ?? 1 }
    
    func year() -> Int { components().year ?? 0 }
    
    func isEqual(_ date: Date?) -> Bool {
        return self.toString() == date?.toString()
    }
    
    func isBefore(_ date: Date) -> Bool {
        return self.updateComponent(.hour, 23) < date.updateComponent(.hour, 0)
    }
    
    func isBeforeOrEqual(_ date: Date) -> Bool {
        return self.updateComponent(.hour, 0) <= date.updateComponent(.hour, 23)
    }
    
    func isAfter(_ date: Date) -> Bool {
        return self.updateComponent(.hour, 0) > date.updateComponent(.hour, 23)
    }
    
    func isAfterOrEqual(_ date: Date) -> Bool {
        return self >= date
    }
    
    func weekday() -> Int {
        let weekday = components().weekday ?? 1
        return weekday == 1 ? 7 : weekday - 1
    }
    
    func firstWeekday() -> Int {
        return self.updateComponent(.day, 1).weekday()
    }
    
    func monthName() -> String { Date.months[month() - 1] }
    
    func dayCountOfMonth(_ date: Date? = nil) -> Int {
        let date = date ?? self
        if let range = Calendar.current.range(of: .day, in: .month, for: date) {
            return range.count
        }
        return 30
    }
    
    func dayCountOfLastMonth() -> Int { dayCountOfMonth(decreaseMonth()) }
    
    func increaseMonth() -> Date {
        return self.updateComponent(.month, self.month() + 1)
    }
    
    func decreaseMonth() -> Date {
        return self.updateComponent(.month, self.month() - 1)
    }
    
    func updateComponent(_ component:Calendar.Component, _ value: Int) -> Date {
        let calendar = Calendar.current
        let oldValue: Int
        switch component {
        case .hour:
            oldValue = self.hour()
        case .minute:
            oldValue = self.minute()
        case .day:
            oldValue = self.day()
        case .month:
            oldValue = self.month()
        case .year:
            oldValue = self.year()
        default:
            return self
        }
        if let newDate = calendar.date(byAdding: component, value: value - oldValue, to: self) {
            return newDate
        }
        return self
    }
}
