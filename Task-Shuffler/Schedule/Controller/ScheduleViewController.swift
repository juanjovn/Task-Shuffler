//
//  ScheduleViewController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 29/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView

class ScheduleViewController: AMTabsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationItems()
        setupCollectionView()
    }
    
    private func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
    }
    
    private func setupView() {
        view.backgroundColor = .paleSilver
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionViewVC = HorizontalCollectionVC(collectionViewLayout: layout)
        self.addChild(collectionViewVC)
        let collectionView = collectionViewVC.view!
        collectionViewVC.collectionView.backgroundColor = .paleSilver
        view.addSubview(collectionView)
        
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        collectionViewVC.didMove(toParent: self)
        
        
    }
    
    
    @objc func settingsButtonAction() {
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }

}

extension ScheduleViewController: TabItem{
    
    var tabImage: UIImage? {
        return UIImage(named: "calendar")
    }
    
}
