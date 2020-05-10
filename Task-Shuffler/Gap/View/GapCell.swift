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
    @IBOutlet weak var monthLabel: UILabel!
    
    let dateFontSize: CGFloat = 21.0
    let monthFontSize: CGFloat = 20
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
               
    }
    
    private func setupFonts() {
        dateLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(dateFontSize))
        monthLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(dateFontSize))
        startTimeLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(timeFontSize))
        endTimeLabel.font = .avenirMedium(ofSize: UIFont.scaleFont(timeFontSize))
    }
    
    private func setupBackgrounds() {
        startTimeBckgLabel.layer.cornerRadius = startTimeBckgLabel.bounds.height / 2
        startTimeBckgLabel.backgroundColor = .turquesa
        endTimeBckgLabel.layer.cornerRadius = endTimeBckgLabel.bounds.height / 2
        endTimeBckgLabel.backgroundColor = .opalRed
    }
   
}
