//
//  ShuffleResultsVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class ShuffleResultsVC: ViewController {
    let modalView = ModalView()
    lazy var cancelButton = modalView.cancelButton
    override func viewDidLoad() {
        super.viewDidLoad()
        view = modalView
        setupCancelButton()
    }
    
    private func setupCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
}
