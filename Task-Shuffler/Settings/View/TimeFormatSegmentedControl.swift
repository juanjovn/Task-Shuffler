//
//  TimeFormatSegmentedControl.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 7/3/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class TimeFormatSegmentedControl: UISegmentedControl {

    override init(items: [Any]?) {
        super.init(items: items)
        backgroundColor = .pearlWhite
        tintColor = .pearlWhite
        selectedSegmentTintColor = .mysticBlue
        var attributes = self.titleTextAttributes(for: .selected) ?? [:]
        attributes[.foregroundColor] = UIColor.pearlWhite
        setTitleTextAttributes(attributes, for: .selected)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
}
