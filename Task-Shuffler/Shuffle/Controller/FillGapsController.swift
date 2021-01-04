//
//  FillGapsController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation

class FillGapsController {
    static let instance = FillGapsController()
    var pendingTasks = TaskManager.populateTasks(state: .pending)
    var pendingGaps = GapManager.instance.pendingGaps
    var shuffleMode = ShuffleConfiguration.init(how: .Smart, when: .All)
    
    
    
    public func shuffleTask(mode shufflemode: ShuffleConfiguration) -> Task {
        let task = getAssignedTask(shuffleMode: shufflemode, task: getSomeTask(shuffleMode: shufflemode))
        print("You have to do \(task.name) in gap \(task.gapid)")
        return task
    }
    
    
    private func getSomeTask(shuffleMode: ShuffleConfiguration) -> Task {
        let task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
        
        switch shuffleMode.how {
        case .Smart:
            break
        case .Random:
            guard let newTask = pendingTasks.randomElement() else {
                print("Cannot obtain a random Task")
                return task
            }
            return newTask
        case .Single:
            break
        }
        
        return task
    }
    
    private func getAssignedTask(shuffleMode: ShuffleConfiguration, task: Task) -> Task {
        var task = task
        switch shuffleMode.when {
        case .All:
            guard let gap = pendingGaps.randomElement() else {
                break
            }
            if task.duration <= gap.duration {
                task.gapid = gap.id
            }
            return task
        case .This:
            return task
        case .Next:
            return task
        }
        
        return task
    }
}
