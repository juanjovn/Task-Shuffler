//
//  File.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/04/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import Foundation
import RealmSwift

class DummyModel: Object{
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
