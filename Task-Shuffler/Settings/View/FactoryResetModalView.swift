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
    let tasksTrashIcon = TrashIconView(frame: CGRect.zero)
    let gapsTrashIcon = TrashIconView(frame: CGRect.zero)
    let tasksLabel = UILabel()
    let gapsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
        setupBottomView()
        setupNameLabel()
        setupStackView()
        setupClearTasksView()
        setupClearGapsView()
        setupTasksLabel()
        setupGapsLabel()
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
        resetStackView.distribution = .fillEqually
        resetStackView.spacing = 20
        //resetStackView.backgroundColor = .systemGreen
        
        resetStackView.translatesAutoresizingMaskIntoConstraints = false
        resetStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        resetStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        resetStackView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: -30).isActive = true
        resetStackView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.50).isActive = true
        
    }
    
    private func setupClearTasksView() {
        clearTasksView.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.15)
        clearTasksView.layer.cornerRadius = 20
        clearTasksView.layer.shadowColor = UIColor.mysticBlue.cgColor
        clearTasksView.layer.shadowOffset = .init(width: 0, height: 2)
        clearTasksView.layer.shadowRadius = 5
        clearTasksView.layer.shadowOpacity = 0
        setupTasksTrashIcon()
    }
    
    private func setupTasksTrashIcon() {
        clearTasksView.addSubview(tasksTrashIcon)
        
        tasksTrashIcon.translatesAutoresizingMaskIntoConstraints = false
        tasksTrashIcon.centerXAnchor.constraint(equalTo: clearTasksView.centerXAnchor).isActive = true
        tasksTrashIcon.centerYAnchor.constraint(equalTo: clearTasksView.centerYAnchor).isActive = true
        tasksTrashIcon.heightAnchor.constraint(equalTo: clearTasksView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func setupClearGapsView() {
        clearGapsView.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.15)
        clearGapsView.layer.cornerRadius = 20
        clearGapsView.layer.cornerRadius = 20
        clearGapsView.layer.shadowColor = UIColor.mysticBlue.cgColor
        clearGapsView.layer.shadowOffset = .init(width: 0, height: 2)
        clearGapsView.layer.shadowRadius = 5
        clearGapsView.layer.shadowOpacity = 0
        setupGapsTrashIcon()
    }
    
    private func setupGapsTrashIcon() {
        clearGapsView.addSubview(gapsTrashIcon)
        
        gapsTrashIcon.translatesAutoresizingMaskIntoConstraints = false
        gapsTrashIcon.centerXAnchor.constraint(equalTo: clearGapsView.centerXAnchor).isActive = true
        gapsTrashIcon.centerYAnchor.constraint(equalTo: clearGapsView.centerYAnchor).isActive = true
        gapsTrashIcon.heightAnchor.constraint(equalTo: clearGapsView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func setupTasksLabel() {
        bottomView.addSubview(tasksLabel)
        tasksLabel.text = "Tasks".localized()
        tasksLabel.font = .avenirRegular(ofSize: 20)
        
        tasksLabel.translatesAutoresizingMaskIntoConstraints = false
        tasksLabel.centerXAnchor.constraint(equalTo: clearTasksView.centerXAnchor).isActive = true
        tasksLabel.topAnchor.constraint(equalTo: resetStackView.bottomAnchor, constant: 15).isActive = true
    }
    
    private func setupGapsLabel() {
        bottomView.addSubview(gapsLabel)
        gapsLabel.text = "Time slots".localized()
        gapsLabel.font = .avenirRegular(ofSize: 20)
        
        gapsLabel.translatesAutoresizingMaskIntoConstraints = false
        gapsLabel.centerXAnchor.constraint(equalTo: clearGapsView.centerXAnchor).isActive = true
        gapsLabel.topAnchor.constraint(equalTo: resetStackView.bottomAnchor, constant: 15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
