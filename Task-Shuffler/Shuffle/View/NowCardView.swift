//
//  NowCardView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 8/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class NowCardView: UIView {
    let nameLabel = UILabel()
    let priorityIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupName()
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
    
    private func setupName() {
        addSubview(nameLabel)
        nameLabel.text = "New Task"
        nameLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(48))
        nameLabel.textColor = .mysticBlue
        nameLabel.textAlignment = .center
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.numberOfLines = 3
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }

    private func setupPriorityIcon() {
        
    }
}
