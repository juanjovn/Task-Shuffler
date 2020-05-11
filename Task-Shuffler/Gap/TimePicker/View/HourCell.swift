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
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        setupHourLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        self.selectionStyle = .none
    }
    
    private func setupHourLabel() {
        hourLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(20))
        contentView.backgroundColor = .clear
        contentView.addSubview(hourLabel)
        
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        hourLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    
}
