//
//  Utils.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 07/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//  TESTING ACCESS TOKEN
//

import Foundation

class Utils {
    
    static func formatDate (datePattern: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = datePattern
        return dateFormatter.string(from: date)
    }
    
    static func printLocale() {
        let formatter = DateFormatter()
        print(formatter.locale!)
    }
    
}
