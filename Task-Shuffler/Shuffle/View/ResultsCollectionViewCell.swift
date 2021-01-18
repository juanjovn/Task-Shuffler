//
//  ResultsCollectionViewCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 16/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {
    override func layoutSubviews() {
            // cell rounded section
            self.layer.cornerRadius = 15.0
            self.layer.borderWidth = 5.0
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.masksToBounds = true
        backgroundColor = .systemPink
            
            // cell shadow section
            self.contentView.layer.cornerRadius = 15.0
            self.contentView.layer.borderWidth = 5.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            self.contentView.layer.masksToBounds = true
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
            self.layer.shadowRadius = 6.0
            self.layer.shadowOpacity = 0.6
            self.layer.cornerRadius = 15.0
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        }
}
