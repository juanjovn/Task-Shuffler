//
//  DatePickerVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 08/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation
import DateScrollPicker

class DatePickerVC: UIViewController{
    
    let dateScrollPicker = DateScrollPicker()
    var delegate: DatePickerVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDateScrollPicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //dateScrollPicker.selectToday()
    }
    
    private func setupView() {
        //view.backgroundColor = .systemPink
    }
    
    private func setupDateScrollPicker() {
        dateScrollPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateScrollPicker)
        
        dateScrollPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        dateScrollPicker.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        dateScrollPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        dateScrollPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        var format = DateScrollPickerFormat()
        format.days = 3
        format.topDateFormat = "E"
        format.mediumDateFormat = "dd"
        format.bottomDateFormat = "MMMM"
        format.topTextColor = UIColor.pearlWhite.withAlphaComponent(1)
        format.mediumTextColor = UIColor.pearlWhite.withAlphaComponent(0.5)
        format.bottomTextColor = UIColor.pearlWhite.withAlphaComponent(0.8)
        format.topFont = .avenirRegular(ofSize: UIFont.scaleFont(20))
        format.mediumFont = .avenirDemiBold(ofSize: UIFont.scaleFont(40))
        format.bottomFont = .avenirRegular(ofSize: UIFont.scaleFont(17))
        format.dayBackgroundColor = UIColor.mysticBlue.withAlphaComponent(0.3)
        format.dayBackgroundSelectedColor = .mysticBlue
        format.separatorTopTextColor = UIColor.mysticBlue.withAlphaComponent(0.85)
        format.separatorBottomTextColor = UIColor.mysticBlue.withAlphaComponent(0.85)
        format.separatorBackgroundColor = UIColor.pearlWhite.withAlphaComponent(0.25)
        format.separatorTopFont = .avenirRegular(ofSize: UIFont.scaleFont(22))
        format.separatorTopFont = .avenirRegular(ofSize: UIFont.scaleFont(20))
        format.dayRadius = 15
        format.animatedSelection = true
        format.animationScaleFactor = 1.1
        format.dotWidth = 10
        dateScrollPicker.format = format
        dateScrollPicker.delegate = self
        dateScrollPicker.dataSource = self
    }
}

// MARK: DELEGATES

extension DatePickerVC: DateScrollPickerDelegate {
    
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, didSelectDate date: Date) {
        let text = Utils.formatDate(datePattern: "EEEE dd MMMM", date: date)
        delegate?.updateDateLabel(textDate: text)
        delegate?.selectedDate(selectedDate: date)
        //detailDateLabel.text = date.format(dateFormat: "EEEE, dd MMMM yyyy")
    }
}

extension DatePickerVC: DateScrollPickerDataSource {
        
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, dataAttributedStringByDate date: Date) -> NSAttributedString? {
            let attributes = [NSAttributedString.Key.font: UIFont.avenirRegular(ofSize: UIFont.scaleFont(12)), NSAttributedString.Key.foregroundColor: UIColor.white]
            return Date.today() == date ? NSAttributedString(string: "Today", attributes: attributes) : nil
    }
    
    func dateScrollPicker(_ dateScrollPicker: DateScrollPicker, dotColorByDate date: Date) -> UIColor? {
        if Date.today() == date { return .powerGreen }
        let weekDay = Calendar.current.component(.weekday, from: date)
        if weekDay == Calendar.current.firstWeekday {
            return .yellow
        }
        return UIColor.clear
    }
}



protocol DatePickerVCDelegate {
    func updateDateLabel(textDate: String)
    func selectedDate(selectedDate: Date)
}
