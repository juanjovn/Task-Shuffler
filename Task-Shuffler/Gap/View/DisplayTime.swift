//
//  DisplayTime.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 13/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class DisplayTime: UIView {
    let fromContainerView = UIView()
    let fromLabel = UILabel()
    let fromHourLabel = UILabel()
    let fromColonLabel = UILabel()
    let fromTimeContainerView = UILabel()
    let fromMinuteLabel = UILabel()
    let screenWidth = UIScreen.main.bounds.size.width
    
    required init?(text: String) {
        super.init(frame: .zero)
        self.fromLabel.text = text
        setupFromContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupFromContainerView() {
        fromContainerView.backgroundColor = .clear
        fromContainerView.clipsToBounds = true
        self.addSubview(fromContainerView)
        
        fromContainerView.translatesAutoresizingMaskIntoConstraints = false
        fromContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        fromContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        fromContainerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        fromContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        setupFromColonLabel()
        setupFromTimeContainerView()
        setupFromHourLabel()
        setupFromMinuteLabel()
        setupFromLabel()
    }
    
    private func setupFromLabel() {
        fromLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(15))
        fromContainerView.addSubview(fromLabel)
        
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.trailingAnchor.constraint(equalTo: fromHourLabel.leadingAnchor, constant: -15).isActive = true
        fromLabel.centerYAnchor.constraint(equalTo: fromContainerView.centerYAnchor).isActive = true
    }
    
    private func setupFromColonLabel() {
        fromColonLabel.text = ":"
        fromColonLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(15))
        fromContainerView.addSubview(fromColonLabel)
        
        fromColonLabel.translatesAutoresizingMaskIntoConstraints = false
        fromColonLabel.centerYAnchor.constraint(equalTo: fromContainerView.centerYAnchor).isActive = true
        fromColonLabel.leadingAnchor.constraint(equalTo: fromContainerView.centerXAnchor, constant: screenWidth / 23).isActive = true
    }
    
    private func setupFromTimeContainerView() {
        
        fromTimeContainerView.backgroundColor = UIColor.bone.withAlphaComponent(0.80)
        fromTimeContainerView.clipsToBounds = true
        fromContainerView.addSubview(fromTimeContainerView)
        
        fromTimeContainerView.translatesAutoresizingMaskIntoConstraints = false
        fromTimeContainerView.centerXAnchor.constraint(equalTo: fromColonLabel.centerXAnchor).isActive = true
        fromTimeContainerView.centerYAnchor.constraint(equalTo: fromColonLabel.centerYAnchor).isActive = true
        fromTimeContainerView.heightAnchor.constraint(equalTo: fromContainerView.heightAnchor).isActive = true
        fromTimeContainerView.widthAnchor.constraint(equalTo: fromContainerView.widthAnchor, multiplier: 0.40).isActive = true
        
        fromContainerView.sendSubviewToBack(fromTimeContainerView)
    }
    
    private func setupFromHourLabel() {
        fromHourLabel.text = "01"
        fromHourLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(18))
        fromContainerView.addSubview(fromHourLabel)
        
        fromHourLabel.translatesAutoresizingMaskIntoConstraints = false
        fromHourLabel.centerYAnchor.constraint(equalTo: fromColonLabel.centerYAnchor).isActive = true
        fromHourLabel.trailingAnchor.constraint(equalTo: fromColonLabel.leadingAnchor, constant: -2).isActive = true
    }
    
    private func setupFromMinuteLabel() {
        fromMinuteLabel.text = "00"
        fromMinuteLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(18))
        fromContainerView.addSubview(fromMinuteLabel)
        
        fromMinuteLabel.translatesAutoresizingMaskIntoConstraints = false
        fromMinuteLabel.centerYAnchor.constraint(equalTo: fromColonLabel.centerYAnchor).isActive = true
        fromMinuteLabel.leadingAnchor.constraint(equalTo: fromColonLabel.trailingAnchor, constant: 2).isActive = true    }
}
