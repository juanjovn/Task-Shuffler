//
//  EasterCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 3/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class EasterCell: UITableViewCell {

    let eggContainerView = UIView()
    let easterImageView = UIImageView()
    let easterImage = UIImage(named: "easter")
    let testImage = UIImageView(image: UIImage(systemName: "trash"))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        easterImageView.isUserInteractionEnabled = true
    }
    
    override func layoutSubviews() {
        setupView()
        setupEggContainerView()
        setupEasterImage()
        //setupTestImage()
        
    }

    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupEggContainerView() {
        eggContainerView.backgroundColor = .clear
        addSubview(eggContainerView)
        
        //LAYOUT
        eggContainerView.translatesAutoresizingMaskIntoConstraints = false
        eggContainerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        eggContainerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        eggContainerView.heightAnchor.constraint(equalToConstant: Utils.screenHeight / 11).isActive = true
        eggContainerView.widthAnchor.constraint(equalTo: eggContainerView.heightAnchor).isActive = true
    }
    
    private func setupEasterImage() {
        easterImageView.image = easterImage?.withRenderingMode(.alwaysTemplate)
        easterImageView.contentMode = .scaleAspectFit
        eggContainerView.addSubview(easterImageView)
        
        //LAYOUT
        easterImageView.translatesAutoresizingMaskIntoConstraints = false
        easterImageView.centerXAnchor.constraint(equalTo: eggContainerView.centerXAnchor).isActive = true
        easterImageView.centerYAnchor.constraint(equalTo: eggContainerView.centerYAnchor).isActive = true
        easterImageView.heightAnchor.constraint(equalTo: eggContainerView.heightAnchor, multiplier: 0.8).isActive = true
    }
    
    private func setupTestImage() {
        testImage.contentMode = .scaleAspectFill
        //testImage.isUserInteractionEnabled = true
//        guard let easterImage = UIImage(named: "easter") else {
//            print("Easter image not found")
//            return
//        }
//        let tintableImage = easterImage.withRenderingMode(.alwaysTemplate)
//        easterImageView.image = tintableImage
        testImage.tintColor = UIColor.red.withAlphaComponent(0.2)
        eggContainerView.addSubview(testImage)
        
        //LAYOUT
        testImage.translatesAutoresizingMaskIntoConstraints = false
        testImage.centerXAnchor.constraint(equalTo: eggContainerView.centerXAnchor).isActive = true
        testImage.centerYAnchor.constraint(equalTo: eggContainerView.centerYAnchor).isActive = true
        testImage.heightAnchor.constraint(equalTo: eggContainerView.heightAnchor, multiplier: 0.8).isActive = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }

}
