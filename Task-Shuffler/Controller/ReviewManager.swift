//
//  ReviewManager.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 5/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation

enum ReviewEvent: String {
    case shuffle
    case launchApp
    case easter
}

protocol ReviewManagerProtocol {
    func log(_ event: ReviewEvent) //Write
    func count(of event: ReviewEvent) -> Int //Read
    func reset(_ event: ReviewEvent)
}

final class ReviewManager: ReviewManagerProtocol {

    private let engine: UserDefaults
    
    init(engine: UserDefaults = .standard) {
        self.engine = engine
    }
    
    func log(_ event: ReviewEvent) {
        let current = count(of: event)
        engine.set(current + 1, forKey: event.rawValue)
    }
    
    func count(of event: ReviewEvent) -> Int {
        return engine.integer(forKey: event.rawValue)
    }
    
    func reset(_ event: ReviewEvent) {
        engine.set(0, forKey: event.rawValue)
    }
    
}
