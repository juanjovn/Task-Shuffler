//
//  MultipleResultModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 18/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class MultipleResultModalView: ModalView {

    var collectionViewContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomView.backgroundColor = .clear
        messageLabel.removeFromSuperview()
        
        setupCollectionViewPlaceHolder()
        
    }
    
    private func setupCollectionViewPlaceHolder() {
        contentView.addSubview(collectionViewContainer)
        //CONSTRAINTS
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        collectionViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        collectionViewContainer.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: -30).isActive = true
        collectionViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
