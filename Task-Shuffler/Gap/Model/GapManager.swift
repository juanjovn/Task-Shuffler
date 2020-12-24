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
}
