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
    var name: String
    var duration: Int
    var priority: Priority
}

// Enumeration of priority levels

enum Priority: String{
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}
