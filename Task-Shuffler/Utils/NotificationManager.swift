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
        let identifier = type.rawValue
        
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
    
    func removeNotifications(of type: NotificationType) {
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [type.rawValue])
    }
    
    
}
