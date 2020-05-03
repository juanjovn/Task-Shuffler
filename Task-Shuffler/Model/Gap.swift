//
//  Gap.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 03/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation
import RealmSwift

class GapRealm: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
    @objc dynamic var duration = 0
    @objc dynamic var state = "Pending"
    @objc dynamic var taskid = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    static func intervalDateToMinutes (startDate: Date, endDate: Date) -> Int {
        let diffSeconds = Int(endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970)
        let minutes = diffSeconds / 60
        
        return minutes
    }
}
