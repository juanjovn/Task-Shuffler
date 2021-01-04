//
//  TaskRealm.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 29/04/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation
import RealmSwift

class TaskRealm: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    @objc dynamic var duration = 10
    @objc dynamic var priority = 1
    @objc dynamic var state = "Pending"
    @objc dynamic var gapid = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
