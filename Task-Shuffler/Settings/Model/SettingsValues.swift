//
//  SettingsValues.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 01/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation

class SettingsValues {
    static var taskSettings = [true, true, true] //[markCompletedWhenTimeEnds, confirmDelete, oneTaskPerGap]
    static var notificationsSettings = [true, true] //[notifyTaskStarts, notifyTaskEnds]
    static var otherSettings = [true] //[hapticFeedback]
    static var easterEgg = false
    static var firstTime = ["app":true, "taskList":true, "newTask":true, "gapsList":true, "newGap":true, "shuffleHow":true, "shuffleWhen":true, "nextToDo":true, "schedule":true]
    static var is24HFormat = true //timeFormat(true -> 24h, false -> 12h)
    
    static func storeSettings(){
        let userDefault = UserDefaults.standard
        
        userDefault.set(taskSettings, forKey: "taskSettings")
        userDefault.set(notificationsSettings, forKey: "notificationsSettings")
        userDefault.set(otherSettings, forKey: "otherSettings")
        userDefault.set(easterEgg, forKey: "easterEgg")
        userDefault.set(firstTime, forKey: "firstTime")
        userDefault.set(is24HFormat, forKey: "is24HFormat")
    }
    
    static func loadSettings(){
        let userDefault = UserDefaults.standard
        taskSettings = userDefault.array(forKey: "taskSettings") as! [Bool]
        notificationsSettings = userDefault.array(forKey: "notificationsSettings") as! [Bool]
        otherSettings = userDefault.array(forKey: "otherSettings") as! [Bool]
        easterEgg = userDefault.bool(forKey: "easterEgg")
        firstTime = userDefault.dictionary(forKey: "firstTime") as? [String:Bool] ?? firstTime
        is24HFormat = userDefault.bool(forKey: "is24HFormat")
    }
    
    static func resetEasterEgg() {
        let userDefault = UserDefaults.standard
        userDefault.set(false, forKey: "easterEgg")
    }
    
    
    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
