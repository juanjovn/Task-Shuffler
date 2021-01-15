//
//  SingleCardView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 9/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class SingleCardView: UIView {

    let nameIcon = UIImageView(image: UIImage(systemName: "largecircle.fill.circle"))
    let dateIcon = UIImageView(image: UIImage(systemName: "calendar.badge.clock"))
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let bottomContentView = UIView()
    let priorityIcon = UIImageView()
    let startTime = RoundedTimeView()
    let endTime = RoundedTimeView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNameIcon()
        setupView()
        setupName()
        setupDateLabel()
        setupDateIcon()
        setupBottomContentView()
        setupStartTime()
        setupEndTime()
        setupPriorityIcon()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
    }
    
    private func setupView() {
        backgroundColor = .pearlWhite
        layer.shadowColor = UIColor.mysticBlue.cgColor
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7
    }
    
    private func setupNameIcon() {
        addSubview(nameIcon)
        nameIcon.tintColor = .mysticBlue
        //CONSTRAINTS
        nameIcon.translatesAutoresizingMaskIntoConstraints = false
        nameIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        nameIcon.topAnchor.constraint(equalTo: topAnchor, constant: 27).isActive = true
        nameIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08).isActive = true
        nameIcon.heightAnchor.constraint(equalTo: nameIcon.widthAnchor).isActive = true
        
    }
    
    private func setupName() {
        addSubview(nameLabel)
        nameLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(45))
        nameLabel.textColor = .mysticBlue
        nameLabel.sizeToFit()
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        //CONSTRAINTS
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: nameIcon.trailingAnchor, constant: 7).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        //nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.5).isActive = true
        //nameLabel.backgroundColor = .red
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(25))
        dateLabel.textColor = .mysticBlue
        //CONSTRAINTS
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15).isActive = true
        //dateLabel.backgroundColor = .red
    }
    
    private func setupDateIcon() {
        addSubview(dateIcon)
        dateIcon.tintColor = .mysticBlue
        //CONSTRAINTS
        dateIcon.translatesAutoresizingMaskIntoConstraints = false
        dateIcon.leadingAnchor.constraint(equalTo: nameIcon.leadingAnchor).isActive = true
        dateIcon.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor).isActive = true
        dateIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08).isActive = true
        dateIcon.heightAnchor.constraint(equalTo: nameIcon.widthAnchor).isActive = true
    }
    
    private func setupBottomContentView() {
        addSubview(bottomContentView)
        bottomContentView.backgroundColor = .clear
        //CONSTRAINTS
        bottomContentView.translatesAutoresizingMaskIntoConstraints = false
        bottomContentView.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        bottomContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        bottomContentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        bottomContentView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2).isActive = true
    }
    
    private func setupStartTime() {
        bottomContentView.addSubview(startTime)
        startTime.backgroundColor = .turquesa
        //CONSTRAINTS
        startTime.translatesAutoresizingMaskIntoConstraints = false
        startTime.leadingAnchor.constraint(equalTo: bottomContentView.leadingAnchor).isActive = true
        startTime.centerYAnchor.constraint(equalTo: bottomContentView.centerYAnchor).isActive = true
        startTime.heightAnchor.constraint(equalTo: bottomContentView.heightAnchor, multiplier: 0.6).isActive = true
        startTime.widthAnchor.constraint(equalTo: bottomContentView.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupEndTime() {
        bottomContentView.addSubview(endTime)
        endTime.backgroundColor = .opalRed
        //CONSTRAINTS
        endTime.translatesAutoresizingMaskIntoConstraints = false
        endTime.leadingAnchor.constraint(equalTo: startTime.trailingAnchor, constant: 17).isActive = true
        endTime.centerYAnchor.constraint(equalTo: startTime.centerYAnchor).isActive = true
        endTime.heightAnchor.constraint(equalTo: startTime.heightAnchor).isActive = true
        endTime.widthAnchor.constraint(equalTo: startTime.widthAnchor).isActive = true
    }
    
    private func setupPriorityIcon() {
        priorityIcon.image = UIImage(systemName: "exclamationmark.circle")
        priorityIcon.layer.shadowColor = UIColor.mysticBlue.cgColor
        priorityIcon.layer.shadowOffset = .init(width: 0, height: 2)
        priorityIcon.layer.shadowRadius = 5
        priorityIcon.layer.shadowOpacity = 0.35
        bottomContentView.addSubview(priorityIcon)
        //CONSTRAINTS
        priorityIcon.translatesAutoresizingMaskIntoConstraints = false
        priorityIcon.centerYAnchor.constraint(equalTo: endTime.centerYAnchor).isActive = true
        priorityIcon.trailingAnchor.constraint(equalTo: bottomContentView.trailingAnchor, constant: -10).isActive = true
        priorityIcon.heightAnchor.constraint(equalTo: bottomContentView.heightAnchor).isActive = true
        priorityIcon.widthAnchor.constraint(equalTo: priorityIcon.heightAnchor).isActive = true
        
    }

}
