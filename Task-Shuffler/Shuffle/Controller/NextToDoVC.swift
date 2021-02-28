//
//  NextToDoVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 28/12/20.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView
import SwiftUI

class NextToDoVC: AMTabsViewController {
    let nextToDoView = NextToDoView()
    let contentView = UIHostingController(rootView: NextToDoSwiftUIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNextToDoView()
        setupHostingViewController()
        setupNavigationBar()
    }
    
    private func setupNextToDoView() {
        view.addSubview(nextToDoView)
        
        nextToDoView.translatesAutoresizingMaskIntoConstraints = false
        nextToDoView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nextToDoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        nextToDoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nextToDoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupHostingViewController() {
        addChild(contentView)
        nextToDoView.addSubview(contentView.view)
        contentView.didMove(toParent: self)
        
        contentView.view.backgroundColor = .clear
//        contentView.view.layer.cornerRadius = 20
//        contentView.view.layer.masksToBounds = true
        
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.leadingAnchor.constraint(equalTo: nextToDoView.leadingAnchor, constant: 10).isActive = true
        contentView.view.trailingAnchor.constraint(equalTo: nextToDoView.trailingAnchor, constant: -10).isActive = true
        contentView.view.topAnchor.constraint(equalTo: nextToDoView.topAnchor, constant: 10).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: nextToDoView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Next to do".localized()
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
