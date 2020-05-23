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
    let weekLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupViews()
        setupLabel()
        
        
        
    }
    
    private func setupViews() {
        addSubview(calendarVC.view)
        
        calendarVC.view.translatesAutoresizingMaskIntoConstraints = false
        calendarVC.view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        calendarVC.view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        calendarVC.view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        calendarVC.view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func setupLabel() {
        weekLabel.text = " Current week "
        weekLabel.backgroundColor = .systemPink
        weekLabel.layer.cornerRadius = weekLabel.layer.bounds.height / 2
        weekLabel.clipsToBounds = true
        weekLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(25))
        addSubview(weekLabel)
        
        weekLabel.layer.layoutIfNeeded()
        weekLabel.layer.cornerRadius = weekLabel.layer.bounds.height / 2
        
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        weekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        weekLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
    }
    
}
