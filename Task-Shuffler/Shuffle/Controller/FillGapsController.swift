//
//  FillGapsController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation

class FillGapsController {
    var pendingTasks = TaskManager.populateTasks(state: .pending)
    var pendingGaps = GapManager.instance.pendingGaps
    var shuffleMode = ShuffleConfiguration.init(how: .Smart, when: .All)
    var shuffleVC: ShuffleVC?
    var randomizedCandidateTasks = [Task]()
    
    init(shuffleMode: ShuffleConfiguration, shuffleVC: ShuffleVC?) {
        self.shuffleMode = shuffleMode
        self.shuffleVC = shuffleVC
    }
    
    
    
    public func shuffleTask() -> Task {
        let task = getAssignedTask(tasks: getCandidateTasks())
        print("You have to do \(task.name) in gap \(task.gapid)")
        return task
    }
    
    
    private func getCandidateTasks() -> [Task] {
        if existFreeTask(pendingTasks: pendingTasks) {
            
            switch shuffleMode.how {
            case .Smart:
                break
            case .Random:
                randomizedCandidateTasks = getRandomizedCandidateTasks(tasks: pendingTasks)
            case .Single:
                break
            }
        } else {
            if let sVC = shuffleVC {
                Alert.errorInformation(title: "Ooops!", message: "There are no task to shuffle", vc: sVC, handler: nil)
                
            }
        }
        
        return randomizedCandidateTasks
    }
    
    private func getAssignedTask(tasks: [Task]) -> Task {
        
        var task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
        
        if  pendingGaps.count > 0{
            
            switch shuffleMode.when {
            
            case .All:
               
                let shuffledGaps = pendingGaps.shuffled()
                for t in tasks {
                    for g in shuffledGaps {
                        if t.duration <= g.duration {
                            task = t
                            task.gapid = g.id
                            return task
                        }
                    }
                }
            case .This:
                return task
            case .Next:
                return task
            case .Now:
                return task
            }
        } else {
            if let sVC = shuffleVC {
                Alert.errorInformation(title: "Ooops!", message: "There are no gaps to shuffle", vc: sVC, handler: nil)
                
            }
        }
        
        return task
    }
    
    private func existFreeTask(pendingTasks: [Task]) -> Bool {
        if pendingTasks.count > 0 {
            return true
        }else {
            return false
            
        }
    }
    
    private func existSuitableGap() -> Bool {
        for t in pendingTasks {
            for g in pendingGaps {
                if t.duration <= g.duration {
                    return true
                }
            }
        }
        return false
    }
    
    private func getRandomizedCandidateTasks(tasks: [Task]) -> [Task] {
        var candidateTasks = [Task]()
        for task in tasks {
            for gap in pendingGaps {
                if task.duration <= gap.duration {
                    candidateTasks.append(task)
                    break
                }
            }
        }
        return candidateTasks.shuffled()
    }
    
}
