//
//  Utils.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 07/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class Utils {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let iPhone8ScreenWidth = 375
    static let iPhone8ScreenHeight = 667
    
    static func formatDate (datePattern: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = datePattern
        return dateFormatter.string(from: date)
    }
    
    static func formatDayNumberToOrdinal(date: Date) -> String? {
        let calendar = Calendar.current
        let dateComponents = calendar.component(.day, from: date)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        let day = numberFormatter.string(from: dateComponents as NSNumber)
        return day
    }
    
    static func printLocale() {
        let formatter = DateFormatter()
        print(formatter.locale!)
    }
    
}
