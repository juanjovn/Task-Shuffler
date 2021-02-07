//
//  CreditsCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 6/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class CreditsCell: UITableViewCell {
    
    let twitterButton = UIButton()
    let twitterView = UIView()
    let instagramButton = UIButton()
    let instagramView = UIView()
    let mailButton = UIButton()
    let mailView = UIView()
    let stackView = UIStackView()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9529411765, alpha: 0.85)
        setupStackView()
        selectionStyle = .none
    }
    
    private func setupStackView(){
        addSubview(stackView)
        //stackView.backgroundColor = .systemTeal
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(twitterView)
        stackView.addArrangedSubview(instagramView)
        stackView.addArrangedSubview(mailView)
        
        //LAYOUT
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        setupTwitterView()
        setupInstagramView()
        setupMailView()
    }
    
    private func setupTwitterView() {
        twitterView.translatesAutoresizingMaskIntoConstraints = false
        //twitterView.backgroundColor = .systemTeal
        setupTwitterButton()
    }
    
    private func setupInstagramView() {
        instagramView.translatesAutoresizingMaskIntoConstraints = false
        //instagramView.backgroundColor = .systemPink
        setupInstagramButton()
    }
    
    private func setupMailView() {
        mailView.translatesAutoresizingMaskIntoConstraints = false
        //mailView.backgroundColor = .systemYellow
        setupMailButton()
    }
    
    
    
    private func setupTwitterButton() {
        twitterView.addSubview(twitterButton)
        //twitterButton.setTitle("twitter", for: .normal)
        //LAYOUT
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.heightAnchor.constraint(equalTo: twitterView.heightAnchor, multiplier: 0.75).isActive = true
        twitterButton.widthAnchor.constraint(equalTo: twitterButton.heightAnchor).isActive = true
        twitterButton.centerYAnchor.constraint(equalTo: twitterView.centerYAnchor).isActive = true
        twitterButton.centerXAnchor.constraint(equalTo: twitterView.centerXAnchor).isActive = true
    }
    
    private func setupInstagramButton() {
        instagramView.addSubview(instagramButton)
        //instagramButton.setTitle("instagram", for: .normal)
        //LAYOUT
        instagramButton.translatesAutoresizingMaskIntoConstraints = false
        instagramButton.heightAnchor.constraint(equalTo: instagramView.heightAnchor, multiplier: 0.75).isActive = true
        instagramButton.widthAnchor.constraint(equalTo: instagramButton.heightAnchor).isActive = true
        instagramButton.centerYAnchor.constraint(equalTo: instagramView.centerYAnchor).isActive = true
        instagramButton.centerXAnchor.constraint(equalTo: instagramView.centerXAnchor).isActive = true
    }
    
    private func setupMailButton() {
        mailView.addSubview(mailButton)
        //mailButton.setTitle("mail", for: .normal)
        //LAYOUT
        mailButton.translatesAutoresizingMaskIntoConstraints = false
        mailButton.heightAnchor.constraint(equalTo: mailView.heightAnchor, multiplier: 0.9).isActive = true
        mailButton.widthAnchor.constraint(equalTo: mailButton.heightAnchor).isActive = true
        mailButton.centerYAnchor.constraint(equalTo: mailView.centerYAnchor).isActive = true
        mailButton.centerXAnchor.constraint(equalTo: mailView.centerXAnchor).isActive = true
    }
    
}
