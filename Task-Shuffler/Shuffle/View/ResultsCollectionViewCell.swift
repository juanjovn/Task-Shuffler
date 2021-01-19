//
//  ResultsCollectionViewCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 16/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var startTime = RoundedTimeView()
    var endTime = RoundedTimeView()
    var priorityIcon = UIImageView()
    let topContainerView = UIView()
    let bottomContainerView = UIView()
    let timeStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerViews()
        setupNameLabel()
        setupDateLabel()
        setupTimeStackView()
        setupPriorityIcon()
    }
    
    private func setupContainerViews() {
        contentView.addSubview(topContainerView)
        contentView.addSubview(bottomContainerView)
        topContainerView.backgroundColor = .clear
        bottomContainerView.backgroundColor = .clear
        
        let padding:CGFloat = 10.0
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        topContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        topContainerView.bottomAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        bottomContainerView.topAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        bottomContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
    }
    
    private func setupNameLabel() {
        topContainerView.addSubview(nameLabel)
        //nameLabel.text = "Estou na lavadora, estou na lavadora ah ah sacaime pronto daquí"
        nameLabel.text = "Ejercicio"
        nameLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(45))
        nameLabel.textColor = .mysticBlue
        nameLabel.sizeToFit()
        nameLabel.textAlignment = .left
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 0
        //CONSTRAINTS
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topContainerView.topAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -10).isActive = true
        //nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: centerYAnchor).isActive = true
        nameLabel.heightAnchor.constraint(lessThanOrEqualTo: topContainerView.heightAnchor, multiplier: 0.60).isActive = true
        //nameLabel.backgroundColor = .red
        
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(20))
        dateLabel.textColor = .mysticBlue
        dateLabel.text = "Wednesday 30th"
        dateLabel.adjustsFontSizeToFitWidth = true
        //CONSTRAINTS
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 5).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.4).isActive = true
        //dateLabel.backgroundColor = .red
    }
    
    private func setupTimeStackView() {
        bottomContainerView.addSubview(timeStackView)
        timeStackView.axis = .horizontal
        timeStackView.distribution = .fillProportionally
        timeStackView.alignment = .fill
        timeStackView.spacing = 15
        timeStackView.layoutMargins = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        timeStackView.isLayoutMarginsRelativeArrangement = true
        //CONSTRAINTS
        timeStackView.translatesAutoresizingMaskIntoConstraints = false
        timeStackView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor).isActive = true
        timeStackView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor).isActive = true
        timeStackView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor).isActive = true
        timeStackView.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.33).isActive = true
        
        setupTimeViews()
    }
    
    private func setupPriorityIcon() {
        priorityIcon.image = UIImage(systemName: "exclamationmark.circle")
        priorityIcon.layer.shadowColor = UIColor.mysticBlue.cgColor
        priorityIcon.layer.shadowOffset = .init(width: 0, height: 2)
        priorityIcon.layer.shadowRadius = 5
        priorityIcon.layer.shadowOpacity = 0.35
        bottomContainerView.addSubview(priorityIcon)
        //CONSTRAINTS
        priorityIcon.translatesAutoresizingMaskIntoConstraints = false
        priorityIcon.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor).isActive = true
        priorityIcon.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor).isActive = true
        priorityIcon.heightAnchor.constraint(equalTo: bottomContainerView.heightAnchor, multiplier: 0.66).isActive = true
        priorityIcon.widthAnchor.constraint(equalTo: priorityIcon.heightAnchor).isActive = true
        
    }
    
    private func setupTimeViews() {
        timeStackView.addArrangedSubview(startTime)
        timeStackView.addArrangedSubview(endTime)
        startTime.backgroundColor = .turquesa
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // cell rounded section
        self.layer.cornerRadius = 20.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        backgroundColor = .pearlWhite
        
        // cell shadow section
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.mysticBlue.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}
