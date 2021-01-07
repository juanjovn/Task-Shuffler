//
//  RoundedModalActionButton.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 7/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class RoundedModalActionButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    private func setupView() {
        setTitleColor(UIColor.bone, for: .normal)
        layer.shadowColor = UIColor.mysticBlue.cgColor
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.7
        backgroundColor = .bone
        setTitleColor(UIColor.mysticBlue, for: .normal)
        setTitleColor(UIColor.pearlWhite.withAlphaComponent(0.2), for: .highlighted)
        titleLabel?.font = .avenirDemiBold(ofSize: UIFont.scaleFont(20))
    }

}
