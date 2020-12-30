//
//  ShuffleView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/12/20.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import WCLShineButton

class ShuffleView: UIView {
    
    //MARK: Constants
    
    let shuffleButton = WCLShineButton(frame: .init(x: 100, y: 100, width: 60, height: 60))
    let shuffleButtonImage = UIImage(systemName: "shuffle")?.tinted(color: .clear)
    
    //MARK: Variables
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .paleSilver
        setupShuffleButton()
    }
    
    
    private func setupShuffleButton() {
        shuffleButton.isEnabled = false
        var shuffleButtonParams = WCLShineParams()
        shuffleButtonParams.animDuration = 1
        shuffleButtonParams.allowRandomColor = true
        shuffleButton.image = .defaultAndSelect(shuffleButtonImage!, shuffleButtonImage!)
        shuffleButton.color = .clear
        shuffleButton.backgroundColor = .clear
        shuffleButton.params = shuffleButtonParams
        self.addSubview(shuffleButton)
        
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        shuffleButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
