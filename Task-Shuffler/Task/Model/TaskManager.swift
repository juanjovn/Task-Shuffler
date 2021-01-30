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
            let task = Task(id: taskRealm.id, name: taskRealm.name, duration: taskRealm.duration, priority: Priority(rawValue: taskRealm.priority)!, state: State(rawValue: taskRealm.state)!, gapid: taskRealm.gapid)
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
                taskObj.gapid = task.gapid
                print("Updated object: \(taskObj.description)")
            }
        } catch {
            print("Error writing update to database")
        }
        
    }
    
    static func getTasksByGapId (gapid: String) -> [Task] {
        let db = DatabaseManager()
        let predicate = "gapid = '\(gapid)'"
        let tasksResults = db.getData(objectClass: TaskRealm.self).filter(predicate)
        
        return realmToStruct(tasksResults: tasksResults)
    }
    
    static func persistAssignments(task: Task) {
        updateTask(task: task)
        if let gap = GapManager.instance.getGapById(id: task.gapid) {
            let db = DatabaseManager()
            do {
                try db.realm.write{
                    gap.duration = gap.duration - task.duration
                    if gap.duration < 10 {
                        gap.state = "Filled"
                    } else {
                        gap.state = "Assigned"
                    }
                    
                }
            } catch {
                print("Error updating to database")
            }
            GapManager.instance.fillGaps()
        }
    }
    
}
