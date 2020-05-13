//
//  HourCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 10/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class HourCell: UITableViewCell {
    let hourLabel = UILabel()
    let dotLabel = UILabel()
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        setupHourLabel()
        setupDotLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        self.selectionStyle = .none
    }
    
    private func setupHourLabel() {
        hourLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(20))
        hourLabel.textColor = UIColor.mysticBlue.withAlphaComponent(0.85)
        contentView.backgroundColor = .clear
        contentView.addSubview(hourLabel)
        
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        hourLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func setupDotLabel() {
        dotLabel.text = "·"
        dotLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(30))
        dotLabel.textColor = UIColor.mysticBlue.withAlphaComponent(0.85)
        
        contentView.addSubview(dotLabel)
        dotLabel.translatesAutoresizingMaskIntoConstraints = false
        dotLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        dotLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -9).isActive = true
    }
}
