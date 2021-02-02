//
//  NextToDoTask.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation
import UIKit

struct NextToDoTask: Identifiable {
    var id: String
    var name: String
    var startTime: Date
    var endTime: Date
    var duration: Int
    var priority: Priority
    
    static func calculateNextToDoTask() -> [NextToDoTask] {
        var nextToDoTasks = [NextToDoTask]()
        
        let pendingTasks = TaskManager.populateTasks(state: .assigned)
        
        for t in pendingTasks {
            if let assignedGap = GapManager.instance.getGapById(id: t.gapid) {
                let nextToDoTask = NextToDoTask(id: t.id, name: t.name, startTime: assignedGap.startDate, endTime: assignedGap.endDate, duration: t.duration, priority: t.priority)
                nextToDoTasks.append(nextToDoTask)
            }
            
        }
        
        
        return nextToDoTasks.sorted(by: {($0.startTime,  $0.priority.rawValue) < ($1.startTime, $1.priority.rawValue)})
    }
}
