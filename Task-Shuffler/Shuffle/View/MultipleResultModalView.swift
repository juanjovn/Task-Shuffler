//
//  MultipleResultModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 18/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class MultipleResultModalView: ModalView {

    var collectionView = UICollectionView(frame:CGRect.zero , collectionViewLayout: UICollectionViewLayout.init())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomView.backgroundColor = .clear
        messageLabel.removeFromSuperview()
        
        setupCollectionViewPlaceHolder()
        
    }
    
    private func setupCollectionViewPlaceHolder() {
        contentView.addSubview(collectionView)
        //CONSTRAINTS
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: -30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
