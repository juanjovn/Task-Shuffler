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
    let nextButton = UIButton(type: .system)
    let nextView = UIView()
    let backButton = UIButton(type: .system)
    let backView = UIView()
    var labelText: String = "" {
        didSet {
            weekLabel.text = labelText
        }
    }
    
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
        setupNextButton()
        setupNextView()
        setupNextBlurView()
        setupBackButton()
        setupBackView()
        setupBackBlurView()
        
        bringSubviewToFront(weekLabel)
        bringSubviewToFront(nextButton)
        bringSubviewToFront(backButton)
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
    
    private func setupNextButton() {
        nextButton.setTitle(">", for: .normal)
        nextButton.titleLabel?.font = .avenirMedium(ofSize: UIFont.scaleFont(25))
        nextButton.setTitleColor(UIColor.black, for: .normal)
        addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerYAnchor.constraint(equalTo: weekLabel.centerYAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
    }
    
    private func setupNextView() {
        nextView.backgroundColor = .clear
        addSubview(nextView)
        nextView.layer.cornerRadius = labelView.layer.bounds.size.height / 2
        
        nextView.translatesAutoresizingMaskIntoConstraints = false
        nextView.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        nextView.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        nextView.widthAnchor.constraint(equalTo: nextButton.widthAnchor, constant: 18).isActive = true
        nextView.heightAnchor.constraint(equalTo: labelView.heightAnchor).isActive = true
        
    }
    
    
    private func setupNextBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        nextView.addSubview(blurEffectView)
        nextView.layoutIfNeeded()
        blurEffectView.layer.cornerRadius = nextView.layer.bounds.size.height / 2
        blurEffectView.clipsToBounds = true
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: nextView.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: nextView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: nextView.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: nextView.bottomAnchor).isActive = true
        
    }
    
    private func setupBackButton() {
        backButton.setTitle("<", for: .normal)
        backButton.titleLabel?.font = .avenirMedium(ofSize: UIFont.scaleFont(25))
        backButton.setTitleColor(UIColor.black, for: .normal)
        addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerYAnchor.constraint(equalTo: weekLabel.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
    }
    
    private func setupBackView() {
        backView.backgroundColor = .clear
        addSubview(backView)
        backView.layer.cornerRadius = labelView.layer.bounds.size.height / 2
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        backView.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        backView.centerXAnchor.constraint(equalTo: backButton.centerXAnchor).isActive = true
        backView.widthAnchor.constraint(equalTo: backButton.widthAnchor, constant: 18).isActive = true
        backView.heightAnchor.constraint(equalTo: labelView.heightAnchor).isActive = true
        
    }
    
    
    private func setupBackBlurView() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        backView.addSubview(blurEffectView)
        backView.layoutIfNeeded()
        blurEffectView.layer.cornerRadius = backView.layer.bounds.size.height / 2
        blurEffectView.clipsToBounds = true
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: backView.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: backView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: backView.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: backView.bottomAnchor).isActive = true
        
    }
    
}
