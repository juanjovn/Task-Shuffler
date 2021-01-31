//
//  FactoryResetModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 31/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class FactoryResetModalView: ModalView {
    
    let resetStackView = UIStackView()
    let clearTasksView = UIView()
    let clearGapsView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupBottomView()
        setupNameLabel()
        setupStackView()
        setupClearGapsView()
        setupClearTasksView()
    }
    
    private func setupContentView() {
        contentViewTopConstraint.constant = Utils.screenHeight / 2
    }
    
    private func setupBottomView() {
        bottomView.backgroundColor = .clear
    }
    
    private func setupNameLabel() {
        messageLabel.removeFromSuperview()
    }
    
    private func setupStackView() {
        bottomView.addSubview(resetStackView)
        resetStackView.addArrangedSubview(clearTasksView)
        resetStackView.addArrangedSubview(clearGapsView)
        resetStackView.axis = .horizontal
        resetStackView.distribution = .fillProportionally
        resetStackView.spacing = 20
        
        resetStackView.translatesAutoresizingMaskIntoConstraints = false
        resetStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        resetStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        resetStackView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        resetStackView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.50).isActive = true
        
    }
    
    private func setupClearTasksView() {
        clearTasksView.backgroundColor = .systemPink
        clearTasksView.layer.cornerRadius = 20
    }
    
    private func setupClearGapsView() {
        clearGapsView.backgroundColor = .systemTeal
        clearGapsView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
