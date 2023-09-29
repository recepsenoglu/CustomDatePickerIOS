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
    @IBOutlet weak var datePickerView: UIPickerView!
    @IBOutlet weak var minimumDatePicker: UIDatePicker!
    @IBOutlet weak var maximumDatePicker: UIDatePicker!
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    // MARK: - Variables
    
    var dateService = DateService()
    var selectDateMode: Bool = false
    var selectedDate: Date?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCV.setup("CalendarDayCVC", CalendarDayFlowLayout())
        minimumDatePicker.setDate(dateService.minDate, animated: true)
        maximumDatePicker.setDate(dateService.maxDate, animated: true)
        refreshTitle()
        refreshButtons()
    }

    // MARK: - Functions
    
    func reloadValues() {
        refreshTitle()
        refreshButtons()
        calendarCV.reloadData()
    }
    
    func refreshTitle() {
        monthAndYearButton.setAttributedTitle(NSAttributedString(string: dateService.titleText,attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]), for: .normal)
    }
    
    func refreshButtons() {
        previousMonthButton.isHidden = dateService.isInMinDate()
        nextMonthButton.isHidden = dateService.isInMaxDate()
    }
    
    func checkSelectedDate() {
        if selectedDate?.isBefore(dateService.minDate) == true || selectedDate?.isAfter(dateService.maxDate) == true {
            selectedDate = nil
            selectedDateLabel.text = "Selected date: "
        }
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
        if selectDateMode {
            if let monthIndex = dateService.monthsForPicker.firstIndex(of: dateService.date.monthName()) {
                datePickerView.selectRow(monthIndex, inComponent: 0, animated: false)
            }
            if let yearIndex = dateService.yearsForPicker.firstIndex(of: String(dateService.date.year())) {
                datePickerView.selectRow(yearIndex, inComponent: 1, animated: false)
            }
        }
        calendarCV.isHidden = selectDateMode
        previousMonthButton.isHidden = selectDateMode
        nextMonthButton.isHidden = selectDateMode
        daysStackView.isHidden = selectDateMode
        datePickerView.isHidden = !selectDateMode
        if !selectDateMode { reloadValues() }
    }
    
    @IBAction func minimumDatePicker_ValueChanged(_ sender: Any) {
        dateService.setMinDate(minimumDatePicker.date)
        checkSelectedDate()
        reloadValues()
    }
    
    @IBAction func maximumDatePicker_ValueChanged(_ sender: Any) {
        dateService.setMaxDate(maximumDatePicker.date)
        checkSelectedDate()
        reloadValues()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { dateService.numberOfSections }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { 7 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let calendarDate = dateService.getCalendarDate(indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarDayCVC", for: indexPath) as! CalendarDayCVC
        cell.setup(calendarDate, selected: calendarDate.date.isEqual(selectedDate))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedDate = dateService.daySelected(indexPath) else { return }
        self.selectedDate = selectedDate
        selectedDateLabel.text = "Selected date: \(selectedDate.toString())"
        reloadValues()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 2 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? dateService.monthsForPicker.count : dateService.yearsForPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 { return dateService.monthsForPicker[row] }
        return dateService.yearsForPicker[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dateService.pickerValueChanged(row, component)
        refreshTitle()
        datePickerView.reloadAllComponents()
    }
}
