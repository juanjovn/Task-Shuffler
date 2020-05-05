//
//  GapCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 05/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class GapCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    let nameFontSize: Float = 20.0
    let durationFontSize: Float = 21.0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.backgroundColor = UIColor.clear.cgColor
        contentView.layoutSublayers(of: contentView.layer)
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
   
}
