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
    
    func populateGaps(state: State) -> [GapRealm]{
        let db = DatabaseManager()
        let stateValue = state.rawValue
        let predicate = "state = '\(stateValue)'"
        let gapResults = db.getData(objectClass: GapRealm.self).filter(predicate)
        
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
    
    init() {
        fillGaps()
    }
}
