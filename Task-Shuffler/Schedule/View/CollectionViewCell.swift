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
    let labelView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        setupLabel()
        setupLabelView()
        setupBlurView()
        
        bringSubviewToFront(weekLabel)
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
        weekLabel.text = "Current week"
        weekLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(20))
        addSubview(weekLabel)
        
        weekLabel.translatesAutoresizingMaskIntoConstraints = false
        weekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        weekLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    private func setupLabelView() {
        labelView.backgroundColor = .clear
        addSubview(labelView)
        layoutIfNeeded()
        labelView.layer.cornerRadius = labelView.layer.bounds.size.height / 2
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.centerYAnchor.constraint(equalTo: weekLabel.centerYAnchor).isActive = true
        labelView.centerXAnchor.constraint(equalTo: weekLabel.centerXAnchor).isActive = true
        labelView.widthAnchor.constraint(equalTo: weekLabel.widthAnchor, constant: 18).isActive = true
        labelView.heightAnchor.constraint(equalTo: weekLabel.heightAnchor, constant: 7).isActive = true
        
    }
    
    private func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        labelView.addSubview(blurEffectView)
        labelView.layoutIfNeeded()
        blurEffectView.layer.cornerRadius = labelView.layer.bounds.size.height / 2
        blurEffectView.clipsToBounds = true
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: labelView.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: labelView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: labelView.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: labelView.bottomAnchor).isActive = true
        
    }
    
}
