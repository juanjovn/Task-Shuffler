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
    static func populateGaps(state: State) -> [GapRealm]{
        let db = DatabaseManager()
        let stateValue = state.rawValue
        let predicate = "state = '\(stateValue)'"
        let gapResults = db.getData(objectClass: GapRealm.self).filter(predicate)
        
        var gaps = [GapRealm]()
        
        for g in gapResults{
            gaps.append(g as! GapRealm)
        }
        
        return gaps
    }
}
