//
//  ElliotDayOption.swift
//  Elliotable
//
//  Created by TaeinKim on 2019/11/03.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation

public enum ElliotDay: Int {
    case monday    = 2
    case tuesday   = 3
    case wednesday = 4
    case thursday  = 5
    case friday    = 6
    case saturday  = 7
    case sunday    = 1
}

public enum ElliotDayType: Int {
    case normalType
    case shortType
    case shortestType
}
