//
//  NextToDoVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/12/20.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView

class NextToDoVC: AMTabsViewController {
    let nextToDoView = NextToDoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextToDoView()
        setupNavigationBar()
    }
    
    private func setupNextToDoView() {
        view.addSubview(nextToDoView)
        
        nextToDoView.translatesAutoresizingMaskIntoConstraints = false
        nextToDoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nextToDoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nextToDoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nextToDoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Next to do"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func settingsButtonAction() {
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }
}

extension NextToDoVC: TabItem{
    
    var tabImage: UIImage? {
        let symbolConfiguration = UIImage.SymbolConfiguration(weight: .regular)
        return UIImage(systemName: "line.horizontal.3.decrease.circle", withConfiguration: symbolConfiguration)
    }
    
}
