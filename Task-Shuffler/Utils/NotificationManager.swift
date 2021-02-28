//
//  NotificationManager.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 5/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    //Singleton
    static let instance = NotificationManager()
    
    enum NotificationType: String {
        case start
        case end
    }
    
    func notificationPermissionRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleTaskNotification(at time: Date, with title: String, message: String, type: NotificationType) {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        content.badge = 1
        let identifier = UUID().uuidString
        
        //Receive with date
        var dateComponents = DateComponents()
        dateComponents = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: time)
        
        //specify if repeats or no
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()

        center.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }else{
                print("send!!")
            }
        }
    }
    
    func removeNotifications(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func removeAllTypeNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func scheduleMultipleTasksNotifications(for tasks: [Task]) {
        if tasks.count > 0 {
            
            var gapIdsCount = [String:Int]()
            for task in tasks {
                if let gap = GapManager.instance.getGapById(id: task.gapid) {
                    if let currentCount = gapIdsCount[gap.id] {
                        gapIdsCount[gap.id] = currentCount + 1
                    } else {
                        gapIdsCount[gap.id] = 1
                    }
                }
            }
            
            for (gapId, taskCount) in gapIdsCount {
                if taskCount == 1 {
                    guard let task = TaskManager.getTasksByGapId(gapid: gapId).first else {
                        print("Couldn't obtain task by gap id")
                        return }
                    guard let gap = GapManager.instance.getGapById(id: gapId) else {
                        print("Couldn't obtain task by gap id")
                        return }
                    
                    if SettingsValues.notificationsSettings[0] {
                        scheduleTaskNotification(at: gap.startDate, with: "Start the task! 💪".localized(), message: task.name, type: .start)
                    }
                    if SettingsValues.notificationsSettings[1] {
                        scheduleTaskNotification(at: gap.endDate, with: "Tasks ended! 🏁".localized(), message: "Have you completed".localized() + " \(task.name)?", type: .end)
                    }
                    
                } else {
                    let tasksList = TaskManager.getTasksByGapId(gapid: gapId)
                    var taskNamesSentence = ""
                    for task in tasksList {
                        taskNamesSentence += "\(task.name), "
                    }
                    //Remove last blank space and comma
                    taskNamesSentence = String(taskNamesSentence.dropLast(2))
                    guard let gap = GapManager.instance.getGapById(id: gapId) else {
                        print("Couldn't obtain task by gap id")
                        return }
                    
                    if SettingsValues.notificationsSettings[0] {
                        scheduleTaskNotification(at: gap.startDate, with: "Start to do the tasks! 💪".localized(), message: taskNamesSentence, type: .start)
                    }
                    if SettingsValues.notificationsSettings[1] {
                        scheduleTaskNotification(at: gap.endDate, with: "Tasks ended! 🏁".localized(), message: "Have you completed".localized() + " \(taskNamesSentence)?", type: .end)
                    }
                }
            }
            
        }
        
    }
    
    
}
