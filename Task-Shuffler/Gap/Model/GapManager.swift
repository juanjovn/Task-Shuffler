//
//  GapManager.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 05/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation
import RealmSwift

class GapManager {
    static let instance = GapManager() //Singleton
    
    var pendingGaps = [GapRealm]()
    var assignedGaps = [GapRealm]()
    var filledGaps = [GapRealm]()
    var completedGaps = [GapRealm]()
    var outdatedGaps = [GapRealm]()
    
    func populateGaps(state: State) -> [GapRealm]{
        let db = DatabaseManager()
        let stateValue = state.rawValue
        let predicate = "state = '\(stateValue)'"
        let gapResults = db.getData(objectClass: GapRealm.self).filter(predicate)
        
        return self.populateArray(results: gapResults)
    }
    
    func populateCurrentGaps() -> [GapRealm] {
        let db = DatabaseManager()
        let startOfWeekDate = Date().startOfWeek()
        let gapResults = db.getData(objectClass: GapRealm.self).filter("startDate >= %@", startOfWeekDate)
        return self.populateArray(results: gapResults)
    }
    
    func populateArray (results: Results<Object>) -> ([GapRealm]) {
        var gaps = [GapRealm]()
        for g in results{
            gaps.append(g as! GapRealm)
        }
        
        return gaps
    }
    
    func fillGaps () {
        pendingGaps = populateGaps(state: .pending)
        assignedGaps = populateGaps(state: .assigned)
        filledGaps = populateGaps(state: .filled)
        completedGaps = populateGaps(state: .completed)
        outdatedGaps = populateGaps(state: .outdated)
    }
    
    func existPendingGaps() -> Bool {
        return pendingGaps.count > 0
    }
    
    func getGapById(id:String) -> GapRealm? {
        let db = DatabaseManager()
        let predicate = "id = '\(id)'"
        if let queryResults = db.getData(objectClass: GapRealm.self).filter(predicate).first as? GapRealm {
            return queryResults
        } else {
            print("Failed to obtain a query result")
            return nil
        }
    }
    
    func resetGapAssignments() {
        let db = DatabaseManager()
        let gapResults = db.getData(objectClass: GapRealm.self)
        
        for gap in gapResults {
            if let gap = gap as? GapRealm {
                if gap.state == State.assigned.rawValue || gap.state == State.filled.rawValue {
                    
                    let updatedGap = GapRealm()
                    updatedGap.id = gap.id
                    updatedGap.startDate = gap.startDate
                    updatedGap.endDate = gap.endDate
                    updatedGap.duration = gap.intervalDateToMinutes(startDate: gap.startDate, endDate: gap.endDate)
                    updatedGap.state = State.pending.rawValue
                    
                    db.updateData(object: updatedGap)
                }
            }
        }
    }
    
    func refreshOutdated() {
        let db = DatabaseManager()
        
        var isChanged = false
        
        if pendingGaps.count > 0 {
            for gap in pendingGaps {
                if checkOutdated(currentGap: gap) {
                    isChanged = true
                    do {
                        try db.realm.write{
                            gap.state = State.outdated.rawValue
                        }
                    } catch {
                        print("Error updating to database")
                    }
                }
            }
        }
        
        var gaps = [GapRealm]()
        let usedGaps = assignedGaps + filledGaps
        if usedGaps.count > 0 {
            for gap in usedGaps {
                if checkOutdated(currentGap: gap) {
                    isChanged = true
                    gaps.append(gap)
                    do {
                        try db.realm.write{
                            if SettingsValues.taskSettings[0] {
                                gap.state = State.completed.rawValue
                            } else {
                                gap.state = State.outdated.rawValue
                            }
                        }
                    } catch {
                        print("Error updating to database")
                    }
                }
            }
            
            for gap in gaps {
                var assignedTasks = db.getData(objectClass: TaskRealm.self)
                assignedTasks = assignedTasks.filter("gapid = '\(gap.id)'")
                for taskRealm in assignedTasks {
                    let task = taskRealm as! TaskRealm
                    do {
                        try db.realm.write{
                            if SettingsValues.taskSettings[0] {
                                task.state = State.completed.rawValue
                            }
                        }
                    } catch {
                        print("Error writing update to database")
                    }
                }
            }
        }
        
        if isChanged {
            fillGaps()
        }
        
    }
    
    private func checkOutdated(currentGap: GapRealm) -> Bool{
        return Date() > currentGap.endDate
    }
    
    init() {
        fillGaps()
    }
}
