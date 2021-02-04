//
//  EasterEggModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 4/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class EasterEggModalView: ModalView {
    
    var gifImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTitle()
        
        buttonsContainerView.removeFromSuperview()
        messageLabel.removeFromSuperview()
        
        setupBottomView()
        //setupGifImageView()
    }
    
    
    private func setupTitle() {
        titleLabel.text = "Meooow! \nYou found me! 🙀"
        titleLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(23))
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func setupBottomView() {
        bottomView.removeConstraints(bottomView.constraints)
        
        //CONSTRAINTS
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
    }
    
    private func setupGifImageView() {
        bottomView.addSubview(gifImageView)
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        gifImageView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        gifImageView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        gifImageView.heightAnchor.constraint(lessThanOrEqualTo: bottomView.heightAnchor, multiplier: 0.8).isActive = true
        gifImageView.widthAnchor.constraint(lessThanOrEqualTo: bottomView.widthAnchor, multiplier: 0.8).isActive = true
        gifImageView.contentMode = .scaleAspectFit
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
