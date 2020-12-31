//
//  ShuffleView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/12/20.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import WCLShineButton
import SJFluidSegmentedControl

class ShuffleView: UIView {
    
    //MARK: Constants
    
    let shuffleButton = WCLShineButton(frame: .init(x: 100, y: 100, width: 60, height: 60))
    let shuffleButtonImage = UIImage(systemName: "shuffle")?.tinted(color: .clear)
    let howLabel = UILabel()
    let howSegmentedControl = SJFluidSegmentedControl()
    let whenLabel = UILabel()
    let whenSegmentedControl = SJFluidSegmentedControl()
    let shuffleBackImageView = UIImageView()
    var shuffleBackImage = UIImage(systemName: "shuffle.circle")
    let detailLabel = UILabel()
    
    //MARK: Variables
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleSilver
        setupShuffleButton()
        setupHowLabel()
        setupHowSegmentedControl()
        setupWhenLabel()
        setupWhenSegmentedControl()
        setupShuffleBackImageView()
        setupDetailLabel()
    }
    
    //Shuffle button is only necessary for creating the particles exploding animation when slider is actioned
    private func setupShuffleButton() {
        shuffleButton.isEnabled = false
        var shuffleButtonParams = WCLShineParams()
        shuffleButtonParams.animDuration = 0.5
        shuffleButtonParams.allowRandomColor = true
        shuffleButton.image = .defaultAndSelect(shuffleButtonImage!, shuffleButtonImage!)
        shuffleButton.color = .clear
        shuffleButton.backgroundColor = .clear
        shuffleButton.params = shuffleButtonParams
        self.addSubview(shuffleButton)
        
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        shuffleButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setupHowLabel() {
        howLabel.text = "How"
        howLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(35))
        self.addSubview(howLabel)
        
        howLabel.translatesAutoresizingMaskIntoConstraints = false
        howLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        howLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        howLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
    }
    
    private func setupWhenLabel() {
        whenLabel.text = "When"
        whenLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(35))
        self.addSubview(whenLabel)
        
        whenLabel.translatesAutoresizingMaskIntoConstraints = false
        whenLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        whenLabel.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -20).isActive = true
        whenLabel.topAnchor.constraint(equalTo: howSegmentedControl.bottomAnchor, constant: 30).isActive = true
        
    }
    
    private func setupHowSegmentedControl() {
        howSegmentedControl.selectorViewColor = .fireOrange
        howSegmentedControl.textColor = .mysticBlue
        howSegmentedControl.selectedSegmentTextColor = .pearlWhite
        howSegmentedControl.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.3)
        
        self.addSubview(howSegmentedControl)
        howSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        howSegmentedControl.topAnchor.constraint(equalTo: howLabel.bottomAnchor, constant: 10).isActive = true
        howSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        howSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        howSegmentedControl.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setupWhenSegmentedControl() {
        whenSegmentedControl.selectorViewColor = .fireOrange
        whenSegmentedControl.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.3)
        
        self.addSubview(whenSegmentedControl)
        whenSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        whenSegmentedControl.topAnchor.constraint(equalTo: whenLabel.bottomAnchor, constant: 10).isActive = true
        whenSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        whenSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        whenSegmentedControl.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setupShuffleBackImageView() {
        shuffleBackImageView.image = shuffleBackImage
        shuffleBackImageView.tintColor = UIColor.mysticBlue.withAlphaComponent(0.07)
        self.addSubview(shuffleBackImageView)
        self.sendSubviewToBack(shuffleBackImageView)
        shuffleBackImageView.translatesAutoresizingMaskIntoConstraints = false
        shuffleBackImageView.topAnchor.constraint(equalTo: whenSegmentedControl.bottomAnchor, constant: 10).isActive = true
        shuffleBackImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55).isActive = true
        shuffleBackImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55).isActive = true
        shuffleBackImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
    }
    
    private func setupDetailLabel() {
        detailLabel.text = "12 tasks will be shuffled in 15 gaps"
        detailLabel.font = .avenirDemiBold(ofSize: 20)
        detailLabel.textColor = .mysticBlue
        detailLabel.shadowOffset = CGSize(width: 0, height: 1)
        detailLabel.shadowColor = UIColor.darkGray.withAlphaComponent(0.2)
        self.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailLabel.centerXAnchor.constraint(equalTo: shuffleBackImageView.centerXAnchor).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: shuffleBackImageView.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
