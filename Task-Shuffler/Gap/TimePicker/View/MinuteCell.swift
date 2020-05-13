//
//  HourCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 10/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class MinuteCell: UITableViewCell {
    let minuteLabel = UILabel()
    let dotLabel = UILabel()
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        setupMinuteLabel()
        setupDotLabel()
    }
    
    private func setupMinuteLabel() {
        minuteLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(20))
        minuteLabel.textColor = UIColor.mysticBlue.withAlphaComponent(0.85)
        contentView.backgroundColor = .clear
        contentView.addSubview(minuteLabel)
        
        minuteLabel.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        minuteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func setupDotLabel() {
        dotLabel.text = "·"
        dotLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(30))
        dotLabel.textColor = UIColor.mysticBlue.withAlphaComponent(0.85)
        
        contentView.addSubview(dotLabel)
        dotLabel.translatesAutoresizingMaskIntoConstraints = false
        dotLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        dotLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 9).isActive = true
    }
}
