//
//  NowShuffleResultsVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 2/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class NowShuffleResultsVC: ViewController {
    let nowResultModalView = NowResultModalView()
    var shuffleVC: ShuffleVC? = ShuffleVC()
    lazy var cancelButton = nowResultModalView.cancelButton
    lazy var reshuffleButton = nowResultModalView.reshuffleButton
    lazy var okButton = nowResultModalView.okButton
    var nowTask = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = nowResultModalView
        setupCancelButton()
        setupReshuffleButton()
        setupOkButton()
        setupNameLabel()
        updatePriorityColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Update rounded corners
        nowResultModalView.buttonsContainerView.layoutIfNeeded()
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
        nowResultModalView.nowCardView.nameLabel.text = nowTask.name
    }
    
    private func updatePriorityColor() {
        switch nowTask.priority {
        case .low:
            nowResultModalView.nowCardView.priorityIcon.tintColor = .powerGreen
        case .medium:
            nowResultModalView.nowCardView.priorityIcon.tintColor = .darkOrange
        case .high:
            nowResultModalView.nowCardView.priorityIcon.tintColor = .fireOrange
        }
    }
    
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func reshuffleButtonAction() {
        if let shuffleVC = shuffleVC {
            let fillGapsController = FillGapsController(shuffleMode: shuffleVC.shuffleConfiguration, shuffleVC: shuffleVC)
            nowTask = fillGapsController.shuffleTask()
            
            UIView.animate(withDuration: 0.2, delay: 0, animations: { () -> Void in
                self.nowResultModalView.nowCardView.nameLabel.transform = .init(scaleX: 0.75, y: 0.75)
                self.updatePriorityColor()
            }, completion: { (finished: Bool) -> Void in
                self.nowResultModalView.nowCardView.nameLabel.text = "\(self.nowTask.name)"
                self.nowResultModalView.nowCardView.nameLabel.transform = .identity
            })
        }
    }
    
    @objc private func okButtonAction() {
        //TODO: Store assigned tasks
        dismiss(animated: true, completion: nil)
    }
}
