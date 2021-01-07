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
    var shuffleVC: ShuffleVC? = ShuffleVC()
    lazy var cancelButton = modalView.cancelButton
    lazy var reshuffleButton = modalView.reshuffleButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = modalView
        setupCancelButton()
        setupReshuffleButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Update rounded corners
        modalView.buttonsContainerView.layoutIfNeeded()
    }
    
    private func setupCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    private func setupReshuffleButton() {
        reshuffleButton.addTarget(self, action: #selector(reshuffleButtonAction), for: .touchUpInside)
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func reshuffleButtonAction() {
        if let shuffleVC = shuffleVC {
            let fillGapsController = FillGapsController(shuffleMode: shuffleVC.shuffleConfiguration, shuffleVC: shuffleVC)
            let task = fillGapsController.shuffleTask()
            UIView.animate(withDuration: 0.2, delay: 0, animations: { () -> Void in
                self.modalView.messageLabel.transform = .init(scaleX: 0.75, y: 0.75)
            }, completion: { (finished: Bool) -> Void in
                self.modalView.messageLabel.text = "\(task.name) in gap id: \(task.gapid)"
                self.modalView.messageLabel.transform = .identity
            })
        }
    }
}
