//
//  ShuffleResult.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 9/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import Foundation

protocol ShuffleResult {
    var shuffleVC: ShuffleVC? { get set }
    var task: Task {get set}
}
