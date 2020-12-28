//
//  ShuffleVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/12/20.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView

class ShuffleVC: AMTabsViewController {
    let shuffleView = ShuffleView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShuffleView()
        setupNavigationBar()
    }
    
    private func setupShuffleView() {
        view.addSubview(shuffleView)
        
        shuffleView.translatesAutoresizingMaskIntoConstraints = false
        shuffleView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shuffleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        shuffleView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        shuffleView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Shuffle"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func settingsButtonAction() {
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }
}

extension ShuffleVC: TabItem{
    
    var tabImage: UIImage? {
        let symbolConfiguration = UIImage.SymbolConfiguration(weight: .regular)
        return UIImage(systemName: "shuffle.circle", withConfiguration: symbolConfiguration)
    }
    
}
