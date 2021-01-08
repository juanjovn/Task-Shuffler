//
//  ModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class ModalView: UIView {
    let contentView = UIView()
    let titleLabel = UILabel()
    let cancelButton = UIButton()
    let cancelBackgroundView = UIView() //Crossmark icon. Dismiss the view controller.
    let buttonsContainerView = UIView()
    let okButton = RoundedModalActionButton()
    let reshuffleButton = RoundedModalActionButton()
    let bottomView = UIView()
    var messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContentView()
        setupBlur()
        setupTitleLabel()
        setupCancelButton()
        setupCancelButtonBackground()
        setupButtonsContainerView()
        setupOkButton()
        setupReshuffleButton()
        setupBottomView()
        setupMessageLabel()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupContentView() {
        contentView.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7725490196, blue: 0.7254901961, alpha: 0.85)
        contentView.layer.cornerRadius = 20
        addSubview(contentView)
        //CONSTRAINTS
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Utils.screenHeight / 3).isActive = true
        contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
    }
    
    private func setupBlur() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        addSubview(blurEffectView)
        sendSubviewToBack(blurEffectView)
        //CONSTRAINTS
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Are you happy?"
        //print(self.editedGap.description)
        titleLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(30))
        contentView.addSubview(titleLabel)
        //CONSTRAINTS
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func setupCancelButton() {
        //cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.bone, for: .normal)
        cancelButton.setTitleColor(UIColor.bone.withAlphaComponent(0.35), for: .highlighted)
        guard let closeImage = UIImage(systemName: "xmark") else {
            return print("Not found that image")
        }
        cancelButton.setImage(closeImage, for: .normal)
        cancelButton.tintColor = .bone
        contentView.addSubview(cancelButton)
        //CONSTRAINTS
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        cancelButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
    }
    
    private func setupCancelButtonBackground() {
        cancelBackgroundView.bounds.size = CGSize(width: 28, height: 28)
        cancelBackgroundView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.2)
        cancelBackgroundView.layer.cornerRadius = cancelBackgroundView.bounds.width / 2
        contentView.addSubview(cancelBackgroundView)
        contentView.sendSubviewToBack(cancelBackgroundView)
        //CONSTRAINTS
        cancelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        cancelBackgroundView.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        cancelBackgroundView.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelBackgroundView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        cancelBackgroundView.heightAnchor.constraint(equalTo: cancelBackgroundView.widthAnchor).isActive = true
    }
    
    private func setupButtonsContainerView() {
        buttonsContainerView.backgroundColor = .clear
        contentView.addSubview(buttonsContainerView)
        //CONSTRAINTS
        buttonsContainerView.translatesAutoresizingMaskIntoConstraints = false
        buttonsContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        buttonsContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        buttonsContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        buttonsContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.10).isActive = true
    }
    
    private func setupOkButton() {
        buttonsContainerView.addSubview(okButton)
        okButton.backgroundColor = .powerGreen
        okButton.setTitle("OK", for: .normal)
        okButton.setTitleColor(.pearlWhite, for: .normal)
        //CONSTRAINTS
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.leadingAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor, constant: 15).isActive = true
        okButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor).isActive = true
        okButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor).isActive = true
        okButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor).isActive = true
        
    }
    
    private func setupReshuffleButton() {
        buttonsContainerView.addSubview(reshuffleButton)
        reshuffleButton.backgroundColor = .opalRed
        reshuffleButton.setTitle("RESHUFFLE", for: .normal)
        reshuffleButton.setTitleColor(.pearlWhite, for: .normal)
        //CONSTRAINTS
        reshuffleButton.translatesAutoresizingMaskIntoConstraints = false
        reshuffleButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor).isActive = true
        reshuffleButton.topAnchor.constraint(equalTo: buttonsContainerView.topAnchor).isActive = true
        reshuffleButton.trailingAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor, constant: -15).isActive = true
        reshuffleButton.bottomAnchor.constraint(equalTo: buttonsContainerView.bottomAnchor).isActive = true
    }
    
    //A container view for laying out the elements under the title label
    private func setupBottomView() {
        bottomView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.15)
        bottomView.layer.cornerRadius = 20
        contentView.addSubview(bottomView)
        //CONSTRAINTS
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: -15).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
    }
    
    private func setupMessageLabel() {
        messageLabel.text = "Placeholder text"
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.numberOfLines = 3
        messageLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(30))
        bottomView.addSubview(messageLabel)
        //CONSTRAINTS
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: bottomView.leadingAnchor).isActive = true
        messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: bottomView.trailingAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
