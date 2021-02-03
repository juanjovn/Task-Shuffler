//
//  EasterCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 3/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class EasterCell: UITableViewCell {

    let easterImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        setupView()
        setupEasterImage()
    }

    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupEasterImage() {
        easterImageView.contentMode = .scaleAspectFit
        easterImageView.isUserInteractionEnabled = true
        guard let easterImage = UIImage(named: "easter") else {
            print("Easter image not found")
            return
        }
        let tintableImage = easterImage.withRenderingMode(.alwaysTemplate)
        easterImageView.image = tintableImage
        addSubview(easterImageView)
        
        //LAYOUT
        easterImageView.translatesAutoresizingMaskIntoConstraints = false
        easterImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        easterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        easterImageView.heightAnchor.constraint(equalToConstant: Utils.screenHeight / 12).isActive = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }

}
