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
        refreshTitle()
    }

    // MARK: - Functions
    
    func reloadValues() {
        refreshTitle()
        calendarCV.reloadData()
    }
    
    func refreshTitle() {
        monthAndYearButton.setTitle(dateService.titleText, for: .normal)
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
        if selectDateMode { datePicker.date = dateService.date }
        calendarCV.isHidden = selectDateMode
        previousMonthButton.isHidden = selectDateMode
        nextMonthButton.isHidden = selectDateMode
        daysStackView.isHidden = selectDateMode
        datePicker.isHidden = !selectDateMode
        if !selectDateMode { reloadValues() }
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
        let calendarDate = dateService.getCalendarDate(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCVC", for: indexPath) as! CalendarDayCVC
        cell.setup(calendarDate.date.day(), inThisMonth: calendarDate.calendarMonth == .Current, selected: calendarDate.date.isEqual(selectedDate))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = dateService.daySelected(indexPath)
        reloadValues()
    }
}
