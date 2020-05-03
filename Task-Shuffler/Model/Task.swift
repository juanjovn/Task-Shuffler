//
//  Task.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 26/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation

// Definition of a task element

struct Task {
    var id: String
    var name: String
    var duration: Int
    var priority: Priority
    var state: State
}

// Enumeration of priority levels

enum Priority: Int {
    case low = 1
    case medium = 2
    case high = 3
}

// Enumeration of task state

enum State: String {
    case pending = "Pending"
    case assigned = "Assigned"
    case completed = "Completed"
    case outdated = "Outdated"
}

// Extension for compare if two task are the same

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.name == rhs.name && lhs.duration == rhs.duration && lhs.priority == rhs.priority
    }
}
