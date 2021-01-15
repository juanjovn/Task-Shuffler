//
//  RoundedTimeView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 15/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class RoundedTimeView: UIView {

    let timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTimeLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    private func setupView() {
        backgroundColor = .opalRed
        layer.shadowColor = UIColor.mysticBlue.cgColor
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.35
    }
    
    private func setupTimeLabel() {
        timeLabel.text = "42:42"
        addSubview(timeLabel)
        timeLabel.font = .avenirMedium(ofSize: 18)
        timeLabel.textColor = .pearlWhite
        //CONSTRAINTS
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
