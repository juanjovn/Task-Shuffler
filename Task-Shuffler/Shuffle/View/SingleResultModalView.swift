//
//  SingleResultModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 9/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class SingleResultModalView: ModalView {

    let singleCard = SingleCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomView.backgroundColor = .clear
        messageLabel.removeFromSuperview()
        
        setupSingleCardView()
        
    }
    
    private func setupSingleCardView() {
        contentView.addSubview(singleCard)
        //CONSTRAINTS
        singleCard.translatesAutoresizingMaskIntoConstraints = false
        singleCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        singleCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        singleCard.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: -30).isActive = true
        singleCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
