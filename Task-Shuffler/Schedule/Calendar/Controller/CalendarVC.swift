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
    
    //Constants
    let timeTable = Elliotable()
    private let daySymbol = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    //Variables
    var courseList = [ElliottEvent]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupElliottEvents()
        
        setupTimetable()
        
//        let minute:TimeInterval = 60.0
//        let hour:TimeInterval = 60.0 * minute
//        insertEvent(stardDate: Date(), endDate: Date(timeInterval: hour, since: Date()), type: EventType.Gap)
//        insertEvent(stardDate: Date(), endDate: Date(timeInterval: hour * 2, since: Date()), type: EventType.Task)
//        insertEvent(stardDate: Date(timeInterval: hour * 15, since: Date()), endDate: Date(timeInterval: hour * 26, since: Date()), type: EventType.Gap)
//        insertEvent(stardDate: Date(timeInterval: hour * 15, since: Date()), endDate: Date(timeInterval: hour * 17, since: Date()), type: EventType.Task)
//        insertEvent(stardDate: Date(timeInterval: hour * 18, since: Date()), endDate: Date(timeInterval: hour * 19, since: Date()), type: EventType.Task)
//        insertEvent(stardDate: Date(timeInterval: hour * 65, since: Date()), endDate: Date(timeInterval: hour * 68, since: Date()), type: EventType.Gap)
//        insertEvent(stardDate: Date(timeInterval: hour * 65, since: Date()), endDate: Date(timeInterval: hour * 67, since: Date()), type: EventType.Task)
//        insertEvent(stardDate: Date(timeInterval: hour * 110, since: Date()), endDate: Date(timeInterval: hour * 115, since: Date()), type: EventType.Gap)
//        insertEvent(stardDate: Date(timeInterval: hour * 110, since: Date()), endDate: Date(timeInterval: hour * 114, since: Date()), type: EventType.Task)
        
//        print(Date())
//        print(Date(timeInterval: hour * 6, since: Date()))
    }
    
    //MARK: Public
    
    public func insertEvent(eventName: String, startDate: Date, endDate: Date, type: EventType) {
        let startTime = Utils.formatDate(datePattern: "HH:mm", date: startDate)
        let endTime = Utils.formatDate(datePattern: "HH:mm", date: endDate)
        //print(startTime)
        //print(endTime)
        let day = Calendar.current.component(.weekday, from: startDate)
        
        switch type {
        case .Gap:
            let event = ElliottEvent(courseId: "1", courseName: eventName, roomName: "", professor: "", courseDay: ElliotDay(rawValue: day)!, startTime: startTime, endTime: endTime, backgroundColor: UIColor.darkGray.withAlphaComponent(0.15))
            
            courseList.append(event)
        case .Task:
            let event = ElliottEvent(courseId: "1", courseName: eventName, roomName: "", professor: "", courseDay: ElliotDay(rawValue: day)!, startTime: startTime, endTime: endTime, backgroundColor: UIColor.fireOrange)
            courseList.append(event)
        }
        
        timeTable.reloadData()
        
        
    }
    
    //MARK: Private
    private func setupElliottEvents() {
        let course_1 = ElliottEvent(courseId: "1", courseName: "", roomName: "", professor: "", courseDay: .tuesday, startTime: "10:00", endTime: "13:00", backgroundColor: UIColor.pearlWhite.withAlphaComponent(0.40))
        let course_1_1 = ElliottEvent(courseId: "1", courseName: "Poner la lavadora bla bla bla", roomName: "", professor: "", courseDay: .tuesday, startTime: "10:00", endTime: "11:00", backgroundColor: .fireOrange)

        let course_2 = ElliottEvent(courseId: "2", courseName: "Renovar el DNI", roomName: "", professor: "", courseDay: .thursday, startTime: "20:00", endTime: "23:30", textColor: UIColor.white, backgroundColor: .turquesa)
        
        let course_3 = ElliottEvent(courseId: "3", courseName: "Lavar el coche", roomName: "", professor: "", courseDay: .saturday, startTime: "18:00", endTime: "22:30", textColor: UIColor.white, backgroundColor: .turquesa)
        let course_4 = ElliottEvent(courseId: "4", courseName: "Vacunarme del COVID-19 bla bla bla", roomName: "", professor: "", courseDay: .sunday, startTime: "16:00", endTime: "18:00", textColor: UIColor.white, backgroundColor: .turquesa)
        
        courseList.append(course_1)
        courseList.append(course_1_1)
        courseList.append(course_2)
        courseList.append(course_3)
        courseList.append(course_4)
        
        
    }
    
    
    private func setupTimetable() {
        if Calendar.current.firstWeekday == 1 {timeTable.startDay = .sunday}
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
        timeTable.isFullBorder = true
        timeTable.widthOfTimeAxis = 30
        
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
