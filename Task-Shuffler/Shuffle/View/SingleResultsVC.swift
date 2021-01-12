//
//  SingleResultsVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 9/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class SingleResultsVC: ViewController, ShuffleResult {

    let singleResultModalView = SingleResultModalView()
    var shuffleVC: ShuffleVC? = ShuffleVC()
    lazy var cancelButton = singleResultModalView.cancelButton
    lazy var reshuffleButton = singleResultModalView.reshuffleButton
    lazy var okButton = singleResultModalView.okButton
    var task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = singleResultModalView
        setupCancelButton()
        setupReshuffleButton()
        setupOkButton()
        setupNameLabel()
        updatePriorityColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Update rounded corners
        singleResultModalView.buttonsContainerView.layoutIfNeeded()
    }
    
    private func setupCancelButton() {
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
    }
    
    private func setupReshuffleButton() {
        reshuffleButton.addTarget(self, action: #selector(reshuffleButtonAction), for: .touchUpInside)
    }
    
    private func setupOkButton() {
        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
    }
    
    private func setupNameLabel() {
        singleResultModalView.singleCard.nameLabel.text = "Tarea de prueba placeholder"
    }
    
    private func updatePriorityColor() {
        switch task.priority {
        case .low:
            singleResultModalView.singleCard.priorityIcon.tintColor = .powerGreen
        case .medium:
            singleResultModalView.singleCard.priorityIcon.tintColor = .darkOrange
        case .high:
            singleResultModalView.singleCard.priorityIcon.tintColor = .fireOrange
        }
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func reshuffleButtonAction() {
//        if let shuffleVC = shuffleVC {
//            let fillGapsController = FillGapsController(shuffleMode: shuffleVC.shuffleConfiguration, shuffleVC: shuffleVC)
//            nowTask = fillGapsController.shuffleTask()
//
//            UIView.animate(withDuration: 0.2, delay: 0, animations: { () -> Void in
//                self.nowResultModalView.nowCardView.nameLabel.transform = .init(scaleX: 0.75, y: 0.75)
//                self.updatePriorityColor()
//            }, completion: { (finished: Bool) -> Void in
//                self.nowResultModalView.nowCardView.nameLabel.text = "\(self.nowTask.name)"
//                self.nowResultModalView.nowCardView.nameLabel.transform = .identity
//            })
//        }
    }
    
    @objc private func okButtonAction() {
        //TODO: Store assigned tasks
        dismiss(animated: true, completion: nil)
    }

}
