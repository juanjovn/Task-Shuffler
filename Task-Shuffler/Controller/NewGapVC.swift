//
//  NewGapVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 07/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class NewGapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    private func setupView() {
        view.backgroundColor = .clear
        let contentView = UIView()
        contentView.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7725490196, blue: 0.7254901961, alpha: 0.85)
        contentView.layer.cornerRadius = 20
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIScreen.main.bounds.height / 3).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
}
