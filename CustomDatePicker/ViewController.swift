//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by Recep Oğuzhan Şenoğlu on 22.09.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var previousMonthButton: UIButton!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak private var monthAndYearButton: UIButton!
    @IBOutlet weak var daysStackView: UIStackView!
    @IBOutlet weak private var calendarCV: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Variables
    
    var dateService = DateService()
    var selectDateMode: Bool = false
    var selectedDate: Date?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCV.setup("CalendarDayCVC", CalendarDayFlowLayout())
        monthAndYearButton.titleLabel?.text = dateService.titleText
    }

    // MARK: - Functions
    
    func reloadValues() {
        monthAndYearButton.titleLabel?.text = dateService.titleText
        calendarCV.reloadData()
    }
    
    func refreshTitle() {
        monthAndYearButton.titleLabel?.text = dateService.titleText
        monthAndYearButton.titleLabel?.textAlignment = .center
    }
    
    // MARK: - Actions
    
    @IBAction private func previousMonthButton_TUI(_ sender: Any) {
        dateService.goLastMonth()
        reloadValues()
    }
    @IBAction private func nextMonthButton_TUI(_ sender: Any) {
        dateService.goNextMonth()
        reloadValues()
    }
    @IBAction private func chooseMonthAndYearButton_TUI(_ sender: Any) {
        refreshTitle()
        selectDateMode = !selectDateMode
        calendarCV.isHidden = selectDateMode
        previousMonthButton.isHidden = selectDateMode
        nextMonthButton.isHidden = selectDateMode
        daysStackView.isHidden = selectDateMode
        datePicker.isHidden = !selectDateMode
        
        if !selectDateMode {
            dateService.updateDate(datePicker.date)
            reloadValues()
        }
    }
    
    @IBAction func datePicker_ValueChanged(_ sender: UIDatePicker) {
        dateService.updateDate(datePicker.date)
        refreshTitle()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { dateService.numberOfSections }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 7 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let calendarDay = dateService.getCalendarDay(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCVC", for: indexPath) as! CalendarDayCVC
        cell.setup(calendarDay.day, inThisMonth: calendarDay.isInThisMonth, selected: false)
        return cell
    }
}
