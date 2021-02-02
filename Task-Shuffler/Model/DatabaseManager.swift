//
//  DatabaseManager.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/04/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager{
    
    let realm = try! Realm()
    
    func getData (objectClass: AnyClass) -> Results<Object> {
        return realm.objects(objectClass as! Object.Type)
    }
    
    func sortData (data: Results<Object>, keyPath: String, asc: Bool) -> Results<Object> {
        return data.sorted(byKeyPath: keyPath, ascending: asc)
    }
    
    func addData (object: Object) {
        do {
            try realm.write{
                realm.add(object)
                print("Added object: \(object.description)")
            }
        } catch {
            print("Error writing to database")
        }
    }
    
    func updateData (object: Object) {
        do {
            try realm.write{
                realm.add(object, update: .modified)
                print("Updated object: \(object.description)")
            }
        } catch {
            print("Error writing to database")
        }
    }
    
    func deleteData (object: Object) {
        do {
            try realm.write{
                realm.delete(object)
                print("Deleted object: \(object.description)")
            }
        } catch {
            print("Error writing to database")
        }
    }
    
    func deleteAllByType (object: AnyClass) {
        do {
            let objects = getData(objectClass: object.self)
            try realm.write{
                realm.delete(objects)
            }
        } catch {
            print("Error writing to database")
        }
    }
    
    func deleteByPK (primaryKey: String, objectClass: AnyClass){
        do {
            try realm.write{
                let predicate = "id = '\(primaryKey)'"
                realm.delete(getData(objectClass: objectClass).filter(predicate))
                print("Deleted object with id: \(primaryKey) of type\(objectClass.description()): ")
            }
        } catch {
            print("Error writing to database")
        }
    }
    
    func eraseAll() {
        do {
            try realm.write{
                realm.deleteAll()
                print("Erased all objects")
            }
        } catch {
            print("Error writing to database")
        }
    }
    
    func resetAllAssignments() {
        let tasksResults = getData(objectClass: TaskRealm.self)
        for taskRealm in tasksResults {
            let task = taskRealm as! TaskRealm
            if task.gapid.count != 0 {
                do {
                    try realm.write{
                        task.gapid = ""
                        task.state = State.pending.rawValue
                        realm.add(task, update: .modified)
                        print("Updated object: \(task.description)")
                    }
                } catch {
                    print("Error writing to database")
                }
            }
        }
        
        let gapResults = getData(objectClass: GapRealm.self)
        for gapRealm in gapResults {
            let gap = gapRealm as! GapRealm
            if gap.state == State.assigned.rawValue || gap.state == State.filled.rawValue {
                do {
                    try realm.write{
                        gap.state = State.pending.rawValue
                        gap.duration = gap.intervalDateToMinutes(startDate: gap.startDate, endDate: gap.endDate)
                        realm.add(gap, update: .modified)
                        print("Updated object: \(gap.description)")
                    }
                } catch {
                    print("Error writing to database")
                }
            }
        }
    }
}
