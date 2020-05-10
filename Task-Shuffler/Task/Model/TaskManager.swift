//
//  TaskManager.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 30/04/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation
import RealmSwift

class TaskManager {
    static func populateTasks(state: State) -> [Task]{
        let db = DatabaseManager()
        let stateValue = state.rawValue
        let predicate = "state = '\(stateValue)'"
        let tasksResults = db.getData(objectClass: TaskRealm.self).filter(predicate)
        
        return realmToStruct(tasksResults: tasksResults)
    }
    
    static func realmToStruct (tasksResults: Results<Object>) -> [Task] {
        var tasks = [Task]()
        for t in tasksResults {
            let taskRealm = t as! TaskRealm
            let task = Task(id: taskRealm.id, name: taskRealm.name, duration: taskRealm.duration, priority: Priority(rawValue: taskRealm.priority)!, state: State(rawValue: taskRealm.state)!)
            tasks.append(task)
        }
        
        return tasks
    }
    
    static func updateTask (task: Task) {
        let db = DatabaseManager()
        let predicate = "id = '\(task.id)'"
        let taskObj = db.getData(objectClass: TaskRealm.self).filter(predicate).first as! TaskRealm
        
        let realm = try! Realm()
        
        do {
            try realm.write{
                taskObj.name = task.name
                taskObj.duration = task.duration
                taskObj.priority = task.priority.rawValue
                taskObj.state = task.state.rawValue
                print("Updated object: \(taskObj.description)")
            }
        } catch {
            print("Error writing update to database")
        }
        
    }
}
