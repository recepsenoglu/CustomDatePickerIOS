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
    
    func setup(_ day: Int, inThisMonth: Bool, selected: Bool) {
        backgroundUIView.backgroundColor = selected ? UIColor.blue : UIColor.clear
        dayNumberLabel.text = String(day)
        let textColor = selected ? UIColor.white : inThisMonth ? UIColor.black : UIColor.gray
        dayNumberLabel.textColor = textColor
        dayNumberLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}
