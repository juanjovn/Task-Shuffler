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
        
        setupFakeEvent()
        setupTimetable()
        setupNotificationCenter()
        //insertDummyTask()
        
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
    
    override func viewDidDisappear(_ animated: Bool) {
        deleteAllEvents()
        //deleteFakeEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupFakeEvent()
        //insertDummyTask()
    }
    
    //MARK: Public
    
    public func insertEvent(eventName: String, startDate: Date, endDate: Date, type: EventType) {
        let startTime = Utils.formatDate(datePattern: "HH:mm", date: startDate)
        let endTime = Utils.formatDate(datePattern: "HH:mm", date: endDate)
        //print(startTime)
        //print(endTime)
        let day = Calendar.current.component(.weekday, from: startDate)
        
        switch type {
        //courseId == 1 for gap events. courseId == 2 for task events
        case .Gap:
            let event = ElliottEvent(courseId: "1", courseName: eventName, roomName: "", professor: "", courseDay: ElliotDay(rawValue: day)!, startTime: startTime, endTime: endTime, backgroundColor: UIColor.darkGray.withAlphaComponent(0.15))
            
            courseList.append(event)
        case .Task:
            let event = ElliottEvent(courseId: "2", courseName: eventName, roomName: "", professor: "", courseDay: ElliotDay(rawValue: day)!, startTime: startTime, endTime: endTime, backgroundColor: UIColor.fireOrange.withAlphaComponent(0.7))
            courseList.append(event)
        case .Fake:
            //Insert a short fake event at the end of a day and at the very final to  allow showing entirely the schedule because the library shrink it to the used hours only
            var event = ElliottEvent(courseId: "-1", courseName: eventName, roomName: "", professor: "", courseDay: ElliotDay(rawValue: day)!, startTime: "00:00", endTime: "00:01", backgroundColor: .clear)
            courseList.append(event)
            event = ElliottEvent(courseId: "-1", courseName: eventName, roomName: "", professor: "", courseDay: ElliotDay(rawValue: day)!, startTime: "23:58", endTime: "23:59", backgroundColor: .clear)
            courseList.append(event)
        }
        
        timeTable.reloadData()
        
        
    }
    
    public func deleteAllEvents () {
        courseList.removeAll()
        //print("All events deleted 🗑")
    }
    
    // Create a event that fills the whole day to cheat ElliotTable and show all day hours in the schedule
    public func setupFakeEvent() {
        //.Fake create two events: one at midnight and another one at the and of the day. It is a hardcode solution, not very proud of it.
        //TODO: Consider switch to another library o take a deep thought into this one.
        insertEvent(eventName: "", startDate: Date() , endDate: Date(), type: .Fake)
    }
    
    public func insertDummyTask() {
        let minute:TimeInterval = 60.0
        let hour:TimeInterval = 60.0 * minute
     
        insertEvent(eventName: "Dummy Task for testing purposes", startDate: Date(), endDate: Date(timeInterval: hour * 2, since: Date()), type: .Task)
    }
    
    //MARK: Private
    private func setupElliottEvents() {
//        let course_1 = ElliottEvent(courseId: "1", courseName: "", roomName: "", professor: "", courseDay: .tuesday, startTime: "10:00", endTime: "13:00", backgroundColor: UIColor.pearlWhite.withAlphaComponent(0.40))
//        let course_1_1 = ElliottEvent(courseId: "1", courseName: "Poner la lavadora bla bla bla", roomName: "", professor: "", courseDay: .tuesday, startTime: "10:00", endTime: "11:00", backgroundColor: .fireOrange)
//
//        let course_2 = ElliottEvent(courseId: "2", courseName: "Renovar el DNI", roomName: "", professor: "", courseDay: .thursday, startTime: "20:00", endTime: "23:30", textColor: UIColor.white, backgroundColor: .turquesa)
//
//        let course_3 = ElliottEvent(courseId: "3", courseName: "Lavar el coche", roomName: "", professor: "", courseDay: .saturday, startTime: "18:00", endTime: "22:30", textColor: UIColor.white, backgroundColor: .turquesa)
//        let course_4 = ElliottEvent(courseId: "4", courseName: "Vacunarme del COVID-19 bla bla bla", roomName: "", professor: "", courseDay: .sunday, startTime: "16:00", endTime: "18:00", textColor: UIColor.white, backgroundColor: .turquesa)
//
//        courseList.append(course_1)
//        courseList.append(course_1_1)
//        courseList.append(course_2)
//        courseList.append(course_3)
//        courseList.append(course_4)
        
        
        
    }
    
    private func setupTimetable() {
        if Calendar.current.firstWeekday == 1 {timeTable.startDay = .sunday}
        timeTable.delegate = self
        timeTable.dataSource = self
        timeTable.roundCorner = .all
        timeTable.heightOfDaySection = 30
        timeTable.courseItemHeight = UIScreen.main.bounds.size.height / 15
        timeTable.textEdgeInsets = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        timeTable.borderCornerRadius = 5
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
    
    private func deleteFakeEvent() {
        var fakeIndex = 0
        for i in 0..<courseList.count {
            if Int(courseList[i].courseId) == -1 {
                fakeIndex = i
            }
        }
        
        courseList.remove(at: fakeIndex)
    }
    
    private func setupNotificationCenter() {
//        NotificationCenter.default.addObserver(self, selector: #selector(onDataModified), name: .didModifiedData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                                   object: nil)
    }
    
    @objc func didEnterBackground () {
        deleteAllEvents()
        setupFakeEvent()
    }

}

extension CalendarVC: ElliotableDelegate, ElliotableDataSource {
    func elliotable(elliotable: Elliotable, didSelectCourse selectedCourse: ElliottEvent) {
        switch Int(selectedCourse.courseId) {
        //courseId == 1 for gap events. courseId == 2 for task events
        case 1:
            if Int(selectedCourse.courseId) != -1 { //-1 is the id of Fake events
                Alert.errorInformation(title: "Gap of time", message: "\nStarting at: \(selectedCourse.startTime) \nFinishing at: \(selectedCourse.endTime)"
                                       , vc: self, handler: nil)
            }
        case 2:
            if Int(selectedCourse.courseId) != -1 { //-1 is the id of Fake events
                Alert.errorInformation(title: selectedCourse.courseName, message: "\nStarting at: \(selectedCourse.startTime) \nFinishing at: \(selectedCourse.endTime)"
                                       , vc: self, handler: nil)
            }
        default:
            break
        }
        
    }
    
    func elliotable(elliotable: Elliotable, didLongSelectCourse longSelectedCourse: ElliottEvent) {
//        if Int(longSelectedCourse.courseId) != -1 { //-1 is the id of Fake events
//            Alert.errorInformation(title: "Celda long touch", message: "\(longSelectedCourse.startTime) - \(longSelectedCourse.endTime)"
//                                   , vc: self, handler: nil)
//        }
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
