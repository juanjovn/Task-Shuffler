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
    
    private let realm = try! Realm()
    
    func getData (objectClass: AnyClass) -> Results<Object> {
        return realm.objects(objectClass as! Object.Type)
    }
    
    func addData (object: Object) {
        do {
            try realm.write{
                realm.add(object)
                print("Added object: \(object.description)")
                print(try! Realm().configuration.fileURL!)
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
}
