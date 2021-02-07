//
//  MultipleResultsVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 18/1/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit
import StoreKit

class MultipleResultsVC: ViewController {

    let multipleResultModalView = MultipleResultModalView()
    var shuffleVC: ShuffleVC? = ShuffleVC()
    lazy var cancelButton = multipleResultModalView.cancelButton
    lazy var reshuffleButton = multipleResultModalView.reshuffleButton
    lazy var okButton = multipleResultModalView.okButton
    var task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending, gapid: "")
    var tasks = [Task]()
    lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }()
    lazy var resultsCollectionVC = ResultsCollectionVC(collectionViewLayout: layout)
    let reviewManager = ReviewManager()
    
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
        addChild(resultsCollectionVC)
        multipleResultModalView.collectionViewContainer.addSubview(resultsCollectionVC.view)
        resultsCollectionVC.tasks = self.tasks
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
        if let shuffleVC = shuffleVC {
            let fillGapsController = FillGapsController(shuffleMode: shuffleVC.shuffleConfiguration, shuffleVC: shuffleVC)
            tasks = fillGapsController.shuffleTasks()
            resultsCollectionVC.tasks = tasks

            //Haptic
            let generator = UIImpactFeedbackGenerator(style: .light)
            if SettingsValues.otherSettings[0] {
                generator.impactOccurred()
            }
            
            UIView.animate(withDuration: 0.15, delay: 0, animations: { () -> Void in
                self.resultsCollectionVC.collectionView.transform = .init(scaleX: 0.75, y: 0.75)
                self.resultsCollectionVC.collectionView.reloadData()
            }, completion: { (finished: Bool) -> Void in
                self.resultsCollectionVC.collectionView.transform = .identity
            })
        }
    }
    
    @objc private func okButtonAction() {
        //TODO: Store assigned tasks
        for i in 0..<tasks.count {
            tasks[i].state = .assigned
            TaskManager.persistAssignments(task: tasks[i])
        }
        
        //Set notifications
        if SettingsValues.notificationsSettings[0] || SettingsValues.notificationsSettings[1] {
            NotificationManager.instance.removeAllTypeNotifications()
            NotificationManager.instance.scheduleMultipleTasksNotifications(for: TaskManager.populateTasks(state: .assigned))
        }
        
        if let shuffleVC = shuffleVC {
            shuffleVC.shuffleSegmentedControllersDelegate.updateShuffleMessageLabel(shuffleConf: shuffleVC.shuffleConfiguration)
        }
        NotificationCenter.default.post(name: .didModifiedData, object: nil)
        reviewManager.log(.shuffle)
        checkLaunchReviewRequest()
        dismiss(animated: true, completion: nil)
    }
    
    private func checkLaunchReviewRequest() {
        if reviewManager.count(of: .shuffle) > 50 || reviewManager.count(of: .launchApp) > 200 {
            SKStoreReviewController.requestReview()
            reviewManager.reset(.shuffle)
            reviewManager.reset(.launchApp)
        }
    }

}
