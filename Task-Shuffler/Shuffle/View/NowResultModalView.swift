//
//  NowResultModalView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 8/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class NowResultModalView: ModalView {
    
    let nowCardView = NowCardView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomView.backgroundColor = .clear
        messageLabel.removeFromSuperview()
        
        setupNowCardView()
        
    }
    
    private func setupNowCardView() {
        contentView.addSubview(nowCardView)
        //CONSTRAINTS
        nowCardView.translatesAutoresizingMaskIntoConstraints = false
        nowCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        nowCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        nowCardView.bottomAnchor.constraint(equalTo: buttonsContainerView.topAnchor, constant: -30).isActive = true
        nowCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
