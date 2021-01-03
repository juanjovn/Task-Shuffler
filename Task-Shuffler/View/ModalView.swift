//
//  ModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class ModalView: UIView {
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let contentView = UIView()
    let titleLabel = UILabel()
    let cancelButton = UIButton()
    let cancelBackgroundView = UIView()
    let okButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupContentView()
        setupBlur()
        setupTitleLabel()
        setupCancelButton()
        setupCancelButtonBackground()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupContentView() {
        contentView.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7725490196, blue: 0.7254901961, alpha: 0.85)
        contentView.layer.cornerRadius = 20
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: screenHeight / 3).isActive = true
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
        cancelButton.tintColor = .red
        contentView.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        cancelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        cancelButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
    }
    
    private func setupCancelButtonBackground() {
        cancelBackgroundView.bounds.size = CGSize(width: screenWidth * 0.06, height: screenWidth * 0.06)
        cancelBackgroundView.backgroundColor = UIColor.green.withAlphaComponent(0.8)
        cancelBackgroundView.layer.cornerRadius = cancelBackgroundView.bounds.width / 2
        contentView.addSubview(cancelBackgroundView)
        contentView.sendSubviewToBack(cancelBackgroundView)
        
        cancelBackgroundView.translatesAutoresizingMaskIntoConstraints = false
//        cancelBackgroundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
//        cancelBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//        cancelBackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.06).isActive = true
//        cancelBackgroundView.heightAnchor.constraint(equalTo: cancelBackgroundView.widthAnchor).isActive = true
        cancelBackgroundView.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor).isActive = true
        cancelBackgroundView.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor).isActive = true
        cancelBackgroundView.widthAnchor.constraint(equalToConstant: screenWidth * 0.06).isActive = true
        cancelBackgroundView.heightAnchor.constraint(equalTo: cancelBackgroundView.widthAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
