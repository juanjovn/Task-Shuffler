//
//  MultipleResultsVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 18/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class MultipleResultsVC: ViewController {

    let multipleResultModalView = MultipleResultModalView()
    var shuffleVC: ShuffleVC? = ShuffleVC()
    lazy var cancelButton = multipleResultModalView.cancelButton
    lazy var reshuffleButton = multipleResultModalView.reshuffleButton
    lazy var okButton = multipleResultModalView.okButton
    var task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = multipleResultModalView
        setupCancelButton()
        setupReshuffleButton()
        setupOkButton()
        setupCollectionView()
        //updatePriorityColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Update rounded corners
        multipleResultModalView.buttonsContainerView.layoutIfNeeded()
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
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let resultsCollectionVC = ResultsCollectionVC(collectionViewLayout: layout)
        addChild(resultsCollectionVC)
        multipleResultModalView.collectionViewContainer.addSubview(resultsCollectionVC.view)
        resultsCollectionVC.didMove(toParent: self)
        resultsCollectionVC.view.translatesAutoresizingMaskIntoConstraints = false
        resultsCollectionVC.view.topAnchor.constraint(equalTo: multipleResultModalView.collectionViewContainer.topAnchor).isActive = true
        resultsCollectionVC.view.leadingAnchor.constraint(equalTo: multipleResultModalView.collectionViewContainer.leadingAnchor).isActive = true
        resultsCollectionVC.view.trailingAnchor.constraint(equalTo: multipleResultModalView.collectionViewContainer.trailingAnchor).isActive = true
        resultsCollectionVC.view.bottomAnchor.constraint(equalTo: multipleResultModalView.collectionViewContainer.bottomAnchor).isActive = true
    }
    
//    private func updatePriorityColor() {
//        switch task.priority {
//        case .low:
//            singleResultModalView.singleCard.priorityIcon.tintColor = .powerGreen
//        case .medium:
//            singleResultModalView.singleCard.priorityIcon.tintColor = .darkOrange
//        case .high:
//            singleResultModalView.singleCard.priorityIcon.tintColor = .fireOrange
//        }
//    }
    
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
