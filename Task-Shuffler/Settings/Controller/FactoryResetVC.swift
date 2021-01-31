//
//  FactoryResetVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 31/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class FactoryResetVC: UIViewController {

    let modalView = FactoryResetModalView()
    lazy var cancelButton = modalView.cancelButton
    lazy var reshuffleButton = modalView.reshuffleButton
    lazy var okButton = modalView.okButton
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = modalView
        setupCancelButton()
        setupOkButton()
        setupReshuffleButton()
        setupTitleLabel()
    }
    
    private func setupCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    private func setupReshuffleButton() {
        reshuffleButton.addTarget(self, action: #selector(reshuffleButtonAction), for: .touchUpInside)
        reshuffleButton.setTitle("Clear All", for: .normal)
    }
    
    private func setupOkButton() {
        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
    }
    
    
    private func setupTitleLabel() {
        modalView.titleLabel.text = "Factory reset"
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func reshuffleButtonAction() {
        
    }
    
    @objc private func okButtonAction() {
        //TODO: Store assigned tasks
        dismiss(animated: true, completion: nil)
    }

}
