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
    var candidateGaps = [GapRealm]()
    var shuffleMode = ShuffleConfiguration.init(how: .Smart, when: .All)
    var shuffleVC: ShuffleVC?
    var randomizedCandidateTasks = [Task]()
    
    init(shuffleMode: ShuffleConfiguration, shuffleVC: ShuffleVC?) {
        self.shuffleMode = shuffleMode
        self.shuffleVC = shuffleVC
        //If one task per gap option is enabled only take into account pending gaps
        if SettingsValues.taskSettings[2] {
            candidateGaps = GapManager.instance.pendingGaps
        } else {
            candidateGaps = GapManager.instance.pendingGaps + GapManager.instance.assignedGaps
        }
        
        if shuffleMode.when == .This {
            let currentWeekNumber = Calendar.current.component(.weekOfYear, from: Date())
            var thisGaps = [GapRealm]()
            for gap in candidateGaps {
                let gapWeekNumber = Calendar.current.component(.weekOfYear, from: gap.startDate)
                if currentWeekNumber == gapWeekNumber {
                    thisGaps.append(gap)
                }
                
            }
            
            candidateGaps = thisGaps
        } else if shuffleMode.when == .Next {
            let currentWeekNumber = Calendar.current.component(.weekOfYear, from: Date())
            var nextGaps = [GapRealm]()
            for gap in candidateGaps {
                let gapWeekNumber = Calendar.current.component(.weekOfYear, from: gap.startDate)
                if currentWeekNumber != gapWeekNumber {
                    nextGaps.append(gap)
                }
                
            }
            
            candidateGaps = nextGaps
        }
    }
    
    
    
    public func shuffleTask() -> Task {
        let task = getAssignedTask(tasks: getCandidateTasks())
        print("You have to do \(task.name) in gap \(task.gapid)")
        return task
    }
    
    public func shuffleTasks() -> [Task] {
        var tasks = [Task]()
        var numberOfSuitableGaps = candidateGaps.count
        
        if SettingsValues.taskSettings[2] {
            while numberOfSuitableGaps > 0 {
                let task = getAssignedTask(tasks: getCandidateTasks())
                if task.name != "" {
                    for i in 0..<pendingTasks.count {
                        if pendingTasks[i].id == task.id {
                            pendingTasks.remove(at: i)
                            break
                        }
                    }
                    tasks.append(task)
                    for i in 0..<candidateGaps.count {
                        if candidateGaps[i].id == task.gapid {
                            candidateGaps.remove(at: i)
                            break
                        }
                    }
                }
                
                numberOfSuitableGaps -= 1
                if pendingTasks.count == 0 {
                    break
                }
            }
        }
        
        if tasks.count == 0 {
            if let sVC = shuffleVC {
                if candidateGaps.count == 0 {
                    Alert.errorInformation(title: "Ooops!", message: "There are no gaps to shuffle!", vc: sVC, handler: nil)
                } else {
                    Alert.errorInformation(title: "Ooops!", message: "There are no suitable tasks!", vc: sVC, handler: nil)
                }
            }
        }
        
        return tasks
    }
    
    
    private func getCandidateTasks() -> [Task] {
        if existFreeTask(pendingTasks: pendingTasks) {
            
            switch shuffleMode.how {
            case .Smart:
                break
            case .Random:
                randomizedCandidateTasks = getRandomizedCandidateTasks(tasks: pendingTasks)
            case .Single:
                randomizedCandidateTasks = getRandomizedCandidateTasks(tasks: pendingTasks)
                if randomizedCandidateTasks.count == 0 {
                    if let sVC = shuffleVC {
                        if SettingsValues.taskSettings[2] {
                            candidateGaps = GapManager.instance.pendingGaps
                        }
                        if candidateGaps.count > 0 {
                            Alert.errorInformation(title: "Ooops!", message: "There are no task suitable for any gap. Try creating longer gaps or shorter tasks.", vc: sVC, handler: nil)
                        } else if !SettingsValues.taskSettings[2]{
                            Alert.errorInformation(title: "Ooops!", message: "There are no gaps to shuffle!", vc: sVC, handler: nil)
                        }
                        
                    }
                }
            }
        } else {
            if let sVC = shuffleVC {
                Alert.errorInformation(title: "Ooops!", message: "There are no task to shuffle", vc: sVC, handler: nil)
                
            }
        }
        
        return randomizedCandidateTasks
    }
    
    private func getAssignedTask(tasks: [Task]) -> Task {
        
        let task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
        
        if  candidateGaps.count > 0 || shuffleMode.when == .Now{
            
            switch shuffleMode.when {
            
            case .All:
                let shuffledGaps = candidateGaps.shuffled()
                let assignedTask = assignGapToTask(shuffledGaps: shuffledGaps, candidateTasks: tasks)
                if assignedTask.name == "" {
//                    if let sVC = shuffleVC {
//                            Alert.errorInformation(title: "Ooops!", message: "There are no suitable gaps!", vc: sVC, handler: nil)
//
//                    }
                }
                return assignedTask
            case .This:
                let currentWeekNumber = Calendar.current.component(.weekOfYear, from: Date())
                var thisGaps = [GapRealm]()
                for gap in candidateGaps {
                    let gapWeekNumber = Calendar.current.component(.weekOfYear, from: gap.startDate)
                    if currentWeekNumber == gapWeekNumber {
                        thisGaps.append(gap)
                    }
                    
                }
                
                
                if let sVC = shuffleVC {
                    if thisGaps.count == 0 {
                        Alert.errorInformation(title: "Ooops!", message: "There are no gaps created in this week!", vc: sVC, handler: nil)
                    }
                    
                }
                
                let shuffledGaps = thisGaps.shuffled()
                let assignedTask = assignGapToTask(shuffledGaps: shuffledGaps, candidateTasks: tasks)
//                if assignedTask.name == "" {
//                    if let sVC = shuffleVC {
//                            Alert.errorInformation(title: "Ooops!", message: "There are no suitable gaps in this week!", vc: sVC, handler: nil)
//
//                    }
//                }
                return assignedTask
            case .Next:
                let currentWeekNumber = Calendar.current.component(.weekOfYear, from: Date())
                var thisGaps = [GapRealm]()
                for gap in candidateGaps {
                    let gapWeekNumber = Calendar.current.component(.weekOfYear, from: gap.startDate)
                    if currentWeekNumber != gapWeekNumber {
                        thisGaps.append(gap)
                    }
                    
                }
                
                if let sVC = shuffleVC {
                    if thisGaps.count == 0{
                        Alert.errorInformation(title: "Ooops!", message: "There are no gaps created in next week!", vc: sVC, handler: nil)
                    }
                    
                }
                
                let shuffledGaps = thisGaps.shuffled()
                let assignedTask = assignGapToTask(shuffledGaps: shuffledGaps, candidateTasks: tasks)
//                if assignedTask.name == "" {
//                    if let sVC = shuffleVC {
//                            Alert.errorInformation(title: "Ooops!", message: "There are no suitable gaps in next week!", vc: sVC, handler: nil)
//                        
//                    }
//                }
                return assignedTask
            case .Now:
                guard let randomTask = pendingTasks.shuffled().first else { return task }
                return randomTask
            }
        } else {
            if let sVC = shuffleVC {
                Alert.errorInformation(title: "Ooops!", message: "There are no gaps to shuffle!", vc: sVC, handler: nil)
                
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
            for g in candidateGaps {
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
            for gap in candidateGaps {
                if task.duration <= gap.duration {
                    candidateTasks.append(task)
                    break
                }
            }
        }
        return candidateTasks.shuffled()
    }
    
    private func assignGapToTask (shuffledGaps: [GapRealm], candidateTasks: [Task]) -> Task {
        var task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
        
        for t in candidateTasks {
            for g in shuffledGaps {
                if t.duration <= g.duration {
                    task = t
                    task.gapid = g.id
                    return task
                }
            }
        }
        
        return task
    }
    
}
