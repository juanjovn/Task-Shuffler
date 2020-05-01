//
//  SettingsVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 01/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeModalView))
    }

    @objc func closeModalView(){
        SettingsValues.testBool = !SettingsValues.testBool
        dismiss(animated: true)
    }

}
