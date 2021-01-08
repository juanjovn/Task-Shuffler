//
//  ShuffleConfiguration.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation

struct ShuffleConfiguration {
    var how: HowMode
    var when: WhenMode
    
}

enum HowMode {
    case Smart
    case Random
    case Single
}

enum WhenMode {
    case All
    case This
    case Next
    case Now
}
