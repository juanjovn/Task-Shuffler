//
//  CalendarVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 21/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import Elliotable

class CalendarVC: UIViewController {
    let timeTable = Elliotable()
    private let daySymbol = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    private var courseList = [ElliottEvent]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupElliottEvents()
        setupTimetable()
    }
    
    private func setupElliottEvents() {
        let course_1 = ElliottEvent(courseId: "1", courseName: "Poner la lavadora", roomName: "", professor: "", courseDay: .tuesday, startTime: "10:00", endTime: "13:00", backgroundColor: .fireOrange)

        let course_2 = ElliottEvent(courseId: "2", courseName: "Renovar el DNI", roomName: "", professor: "", courseDay: .thursday, startTime: "20:00", endTime: "23:30", textColor: UIColor.white, backgroundColor: .turquesa)
        
        let course_3 = ElliottEvent(courseId: "3", courseName: "Lavar el coche", roomName: "", professor: "", courseDay: .saturday, startTime: "18:00", endTime: "22:30", textColor: UIColor.white, backgroundColor: .turquesa)
        let course_4 = ElliottEvent(courseId: "4", courseName: "Vacunarme del COVID-19 bla bla bla", roomName: "", professor: "", courseDay: .sunday, startTime: "16:00", endTime: "18:00", textColor: UIColor.white, backgroundColor: .turquesa)
        
        courseList.append(course_1)
        courseList.append(course_2)
        courseList.append(course_3)
        courseList.append(course_4)
        
        
    }
    
    
    private func setupTimetable() {
        timeTable.delegate = self
        timeTable.dataSource = self
        timeTable.roundCorner = .all
        timeTable.heightOfDaySection = 30
        timeTable.courseItemHeight = UIScreen.main.bounds.size.height / 15
        timeTable.textEdgeInsets = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        timeTable.borderCornerRadius = 10
        timeTable.courseTextAlignment = .center
        timeTable.borderWidth = 1
        timeTable.borderColor = UIColor.pearlWhite.withAlphaComponent(0.40)
        timeTable.symbolBackgroundColor = UIColor.pearlWhite.withAlphaComponent(0.20)
        timeTable.symbolTimeFontSize = 15
        timeTable.symbolFontSize = 14
        
        view.addSubview(timeTable)
        
        timeTable.translatesAutoresizingMaskIntoConstraints = false
        timeTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        timeTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        timeTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        timeTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        timeTable.reloadData()
    }

}

extension CalendarVC: ElliotableDelegate, ElliotableDataSource {
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        Alert.errorInformation(title: "Celda tocada", message: selectedCourse.courseName
            , vc: self, handler: nil)
    }
    
    func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
        Alert.errorInformation(title: "Celda long touch", message: "\(longSelectedCourse.startTime) - \(longSelectedCourse.endTime)"
        , vc: self, handler: nil)
    }
    
    func elliotable(elliotable: Elliotable, at dayPerIndex: Int) -> String {
        return self.daySymbol[dayPerIndex]
    }
    
    func numberOfDays(in elliotable: Elliotable) -> Int {
         return self.daySymbol.count
    }
    
    func courseItems(in elliotable: Elliotable) -> [ElliottEvent] {
        courseList
    }
    
    
}
