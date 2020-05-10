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
    }
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
    }
    
    func setupView(){
        view.backgroundColor = .paleSilver
    }
    
    @objc func settingsButtonAction(){
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }


}

extension ScheduleViewController: TabItem{
    
    var tabImage: UIImage? {
        return UIImage(named: "calendar")
    }
    
}
