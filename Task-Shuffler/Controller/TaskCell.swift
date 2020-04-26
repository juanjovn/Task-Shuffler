//
//  TaskCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 20/04/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var clockImage: UIImageView!
    
    let nameFontSize: Float = 20.0
    let durationFontSize: Float = 21.0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.backgroundColor = UIColor.clear.cgColor
        contentView.layoutSublayers(of: contentView.layer)
        setupNameLabel()
        setupDurationLabel()
        setupCellContainerView()
        
    }
    
    private func setupCellContainerView() {
        let height = containerView.bounds.height
        let radius = height/2
        containerView.layer.cornerRadius = radius
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 3
        
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: radius).cgPath
        containerView.layer.shouldRasterize = true
        containerView.layer.rasterizationScale = UIScreen.main.scale
        
        containerView.backgroundColor = .aliceBlue
        
    }
    
    private func setupNameLabel() {
        if (UIScreen.main.bounds.width != 375){
            let scaleFactor: Float = Float(UIScreen.main.bounds.width) / 375
            let fontSize = CGFloat(nameFontSize * scaleFactor)
            nameLabel.font = nameLabel.font.withSize(fontSize)
        }
    }
    
    private func setupDurationLabel() {
        if (UIScreen.main.bounds.width != 375){
            let scaleFactor: Float = Float(UIScreen.main.bounds.width) / 375
            let fontSize = CGFloat(durationFontSize * scaleFactor)
            durationLabel.font = durationLabel.font.withSize(fontSize)
        }
    }
    
    
    
    
}
