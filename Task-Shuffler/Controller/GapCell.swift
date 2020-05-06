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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationBackground: UIView!
    @IBOutlet weak var startTimeBckgLabel: UIView!
    @IBOutlet weak var endTimeBckgLabel: UIView!
    
    let dateFontSize: CGFloat = 21.0
    let durationFontSize: CGFloat = 22.0
    let timeFontSize: CGFloat = 18.0
    
    
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
        setupFonts()
        setupBackgrounds()
        
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
        
//        durationBackground.layer.cornerRadius = durationBackground.bounds.height / 2
//        durationBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
//        durationBackground.layer.shadowColor = UIColor.black.cgColor
//        durationBackground.layer.shadowOpacity = 0.2
//        durationBackground.layer.shadowRadius = 3
//        
//        durationBackground.layer.shadowPath = UIBezierPath(roundedRect: durationBackground.bounds, cornerRadius: radius).cgPath
//        durationBackground.layer.shouldRasterize = true
//        durationBackground.layer.rasterizationScale = UIScreen.main.scale
//        durationBackground.backgroundColor = .gray
//        
    }
    
    private func setupFonts() {
        dateLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(dateFontSize))
        startTimeLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(timeFontSize))
        endTimeLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(timeFontSize))
        //durationLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(durationFontSize))
    }
    
    private func setupBackgrounds() {
        startTimeBckgLabel.layer.cornerRadius = startTimeBckgLabel.bounds.height / 2
        startTimeBckgLabel.backgroundColor = .naturGreen
        endTimeBckgLabel.layer.cornerRadius = endTimeBckgLabel.bounds.height / 2
        endTimeBckgLabel.backgroundColor = .opalRed
    }
   
}
