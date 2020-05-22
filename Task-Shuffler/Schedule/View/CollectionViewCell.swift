//
//  CollectionViewCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 21/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let calendarVC = CalendarVC()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(calendarVC.view)
        
        calendarVC.view.translatesAutoresizingMaskIntoConstraints = false
        calendarVC.view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        calendarVC.view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        calendarVC.view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        calendarVC.view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}
