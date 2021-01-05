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
    var prunedTasks = [String: Task]()
    
    init(shuffleMode: ShuffleConfiguration, shuffleVC: ShuffleVC?) {
        self.shuffleMode = shuffleMode
        self.shuffleVC = shuffleVC
        
        for t in pendingTasks {
            prunedTasks.updateValue(t, forKey: t.id)
        }
    }
    
    
    
    public func shuffleTask() -> Task {
        let task = getAssignedTask()
        print("You have to do \(task.name) in gap \(task.gapid)")
        return task
    }
    
    
    private func getSomeTask(triedTasks: [Task]) -> Task {
        let task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
        
        if existFreeTask(pendingTasks: pendingTasks) && existSuitableGap(){
            if triedTasks.count > 0 {
                for triedTask in triedTasks {
                    prunedTasks.removeValue(forKey: triedTask.id)
                    getSomeTask(triedTasks: triedTasks)
                }
            }
            
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
        } else {
            if let sVC = shuffleVC {
                Alert.errorInformation(title: "Ooops!", message: "There are no task to shuffle", vc: sVC, handler: nil)
                
            }
        }
        
        return task
    }
    
    private func getAssignedTask() -> Task {
        var triedTasks = [Task]()
        var task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
        var foundTask = false
        
        if existFreeGap(pendingGaps: pendingGaps) {
            
            task = getSomeTask(triedTasks: triedTasks)
            
            for gap in pendingGaps {
                if gap.duration >= task.duration {
                    foundTask = true
                    break
                } else {
                    triedTasks.append(task)
                    task = getSomeTask(triedTasks: triedTasks)
                }
            }
            
            switch shuffleMode.when {
            case .All:
                var validGaps = [GapRealm]()
                for gap in pendingGaps {
                    if gap.duration >= task.duration {
                        validGaps.append(gap)
                    }
                }
                
                if validGaps
                guard let gap = validGaps.randomElement() else {
                    break
                }
                task.gapid = gap.id
                return task
            case .This:
                return task
            case .Next:
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
    
    private func existFreeGap(pendingGaps: [GapRealm]) -> Bool {
        if pendingGaps.count > 0{
            return true
        } else {
            return false
        }
    }
    
    private func existSuitableGap() -> Bool {
        for t in pendingTasks {
            for g in pendingGaps {
                if t.duration <= g.duration {
                    return true
                    break
                }
            }
        }
        return false
    }
    
}
