//
//  CalendarDayCVC.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import UIKit

class CalendarDayCVC: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var backgroundUIView: UIView!
    @IBOutlet weak private var dayNumberLabel: UILabel!
    
    // MARK: - Functions
    
    func setup(_ calendarDate: CalendarDate, selected: Bool) {
        let blueColor = UIColor(named: "BlueColor") ?? UIColor.blue
        let lightBlueColor = UIColor(named: "LightBlueColor") ?? UIColor.systemBlue
        let today = calendarDate.date.isEqual(Date.now)
        let available = calendarDate.available && calendarDate.calendarMonth == .Current
        backgroundUIView.backgroundColor = selected ? today ? blueColor : lightBlueColor : UIColor.clear
        dayNumberLabel.text = String(calendarDate.date.day())
        let textColor = selected ? today ? UIColor.white : blueColor : today ? blueColor : available ? UIColor.black : UIColor.lightGray
        dayNumberLabel.textColor = textColor
        dayNumberLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
}
