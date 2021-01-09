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
    
    let fillView = UIView() //Hides the very thin line created at the bottom when dismissing the modal view that I cannot solve how to avoid
    let shuffleButton = WCLShineButton(frame: .init(x: 100, y: 100, width: 60, height: 60))
    let shuffleButtonImage = UIImage(systemName: "shuffle")?.tinted(color: .clear)
    let howLabel = UILabel()
    let howSegmentedControl = SJFluidSegmentedControl()
    let whenLabel = UILabel()
    let whenSegmentedControl = SJFluidSegmentedControl()
    let shuffleBackImageView = UIImageView()
    var shuffleBackImage = UIImage(named: "shuffle.circle")
    let detailLabel = UILabel()
    let backgroundImageContainerView = UIView()
    let disableHowView = UIView()
    
    //MARK: Variables
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleSilver
        setupFillView()
        //setupShuffleButton()
        setupHowLabel()
        setupHowSegmentedControl()
        setupWhenLabel()
        setupWhenSegmentedControl()
        setupBackgroundImageContainerView()
        setupShuffleBackImageView()
        setupDetailLabel()
        setupDisableHowView()
    }
    
    private func setupFillView() {
        fillView.backgroundColor = .mysticBlue
        self.addSubview(fillView)
        self.sendSubviewToBack(fillView)
        fillView.translatesAutoresizingMaskIntoConstraints = false
        fillView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor).isActive = true
        fillView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        fillView.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
        whenLabel.topAnchor.constraint(equalTo: howSegmentedControl.bottomAnchor, constant: Utils.screenHeight / 50).isActive = true
        
    }
    
    private func setupHowSegmentedControl() {
        //howSegmentedControl.selectorViewColor = .fireOrange // if gradientColorsForSelectedSegmentAtIndex this should be commented
        howSegmentedControl.textColor = .mysticBlue
        howSegmentedControl.selectedSegmentTextColor = .pearlWhite
        howSegmentedControl.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.3)
        
        self.addSubview(howSegmentedControl)
        howSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        howSegmentedControl.topAnchor.constraint(equalTo: howLabel.bottomAnchor, constant: 10).isActive = true
        howSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        howSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        howSegmentedControl.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    private func setupWhenSegmentedControl() {
        //whenSegmentedControl.selectorViewColor = .fireOrange
        whenSegmentedControl.textColor = .mysticBlue
        whenSegmentedControl.selectedSegmentTextColor = .pearlWhite
        whenSegmentedControl.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.3)
        
        self.addSubview(whenSegmentedControl)
        whenSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        whenSegmentedControl.topAnchor.constraint(equalTo: whenLabel.bottomAnchor, constant: 10).isActive = true
        whenSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        whenSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        whenSegmentedControl.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.07).isActive = true
    }
    
    private func setupShuffleBackImageView() {
        shuffleBackImageView.image = shuffleBackImage
        //shuffleBackImageView.backgroundColor = .clear
        shuffleBackImageView.contentMode = .scaleAspectFit
        shuffleBackImageView.tintColor = UIColor.mysticBlue.withAlphaComponent(0.07)
        backgroundImageContainerView.addSubview(shuffleBackImageView)
        //self.sendSubviewToBack(shuffleBackImageView)
        shuffleBackImageView.translatesAutoresizingMaskIntoConstraints = false
        shuffleBackImageView.topAnchor.constraint(equalTo: backgroundImageContainerView.topAnchor).isActive = true
        shuffleBackImageView.bottomAnchor.constraint(equalTo: backgroundImageContainerView.bottomAnchor).isActive = true
        shuffleBackImageView.leadingAnchor.constraint(equalTo: backgroundImageContainerView.leadingAnchor).isActive = true
        shuffleBackImageView.trailingAnchor.constraint(equalTo: backgroundImageContainerView.trailingAnchor).isActive = true
//        shuffleBackImageView.heightAnchor.constraint(equalTo: backgroundImageContainerView.heightAnchor).isActive = true
//        shuffleBackImageView.widthAnchor.constraint(equalTo: shuffleBackImageView.heightAnchor).isActive = true
//        shuffleBackImageView.centerXAnchor.constraint(equalTo: backgroundImageContainerView.centerXAnchor).isActive = true
//        shuffleBackImageView.centerYAnchor.constraint(equalTo: backgroundImageContainerView.centerYAnchor).isActive = true
        
    }
    
    private func setupBackgroundImageContainerView() {
        backgroundImageContainerView.backgroundColor = .clear
        addSubview(backgroundImageContainerView)
        backgroundImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageContainerView.topAnchor.constraint(equalTo: whenSegmentedControl.bottomAnchor, constant: 15).isActive = true
        backgroundImageContainerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        backgroundImageContainerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        backgroundImageContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: Utils.screenHeight / -4.5).isActive = true
    }
    
    private func setupDetailLabel() {
        detailLabel.text = "12 tasks will be shuffled in 15 gaps"
        detailLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(20))
        detailLabel.textColor = .mysticBlue
        detailLabel.shadowOffset = CGSize(width: 0, height: 1)
        detailLabel.shadowColor = UIColor.darkGray.withAlphaComponent(0.2)
        backgroundImageContainerView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailLabel.centerXAnchor.constraint(equalTo: shuffleBackImageView.centerXAnchor).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: shuffleBackImageView.centerYAnchor).isActive = true
    }
    
    private func setupDisableHowView() {
        howSegmentedControl.addSubview(disableHowView)
        disableHowView.isUserInteractionEnabled = false
        disableHowView.backgroundColor = .clear
        self.bringSubviewToFront(disableHowView)
        //CONSTRAINTS
        disableHowView.translatesAutoresizingMaskIntoConstraints = false
        disableHowView.leadingAnchor.constraint(equalTo: howSegmentedControl.leadingAnchor).isActive = true
        disableHowView.trailingAnchor.constraint(equalTo: howSegmentedControl.trailingAnchor).isActive = true
        disableHowView.topAnchor.constraint(equalTo: howSegmentedControl.topAnchor).isActive = true
        disableHowView.bottomAnchor.constraint(equalTo: howSegmentedControl.bottomAnchor).isActive = true
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
