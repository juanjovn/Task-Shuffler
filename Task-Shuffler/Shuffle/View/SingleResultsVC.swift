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
    let gapManager = GapManager.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = singleResultModalView
        setupCancelButton()
        setupReshuffleButton()
        setupOkButton()
        setupNameLabel()
        setupDateLabel()
        updatePriorityColor()
        setupTimeLabels()
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
        singleResultModalView.singleCard.nameLabel.text = task.name
    }
    
    private func setupDateLabel() {
        if let gap = gapManager.getGapById(id: task.gapid) {
            singleResultModalView.singleCard.dateLabel.text = Utils.formatDate(datePattern: "EEEE ", date: gap.startDate)
            let ordinalDate = Utils.formatDayNumberToOrdinal(date: gap.startDate)!
            singleResultModalView.singleCard.dateLabel.text! += ordinalDate
        } else {
            singleResultModalView.singleCard.dateLabel.text = "Date"
        }
        
    }
    
    private func setupTimeLabels() {
        if let gap = gapManager.getGapById(id: task.gapid) {
            singleResultModalView.singleCard.startTime.timeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.startDate)
            singleResultModalView.singleCard.endTime.timeLabel.text = Utils.formatDate(datePattern: "HH:mm", date: gap.endDate)
        } else {
            return
        }
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
        if let shuffleVC = shuffleVC {
            let fillGapsController = FillGapsController(shuffleMode: shuffleVC.shuffleConfiguration, shuffleVC: shuffleVC)
            task = fillGapsController.shuffleTask()

            //Haptic
            let generator = UIImpactFeedbackGenerator(style: .light)
            if SettingsValues.otherSettings[0] {
                generator.impactOccurred()
            }
            
            UIView.animate(withDuration: 0.15, delay: 0, animations: { () -> Void in
                self.singleResultModalView.singleCard.nameLabel.transform = .init(scaleX: 0.75, y: 0.75)
                self.singleResultModalView.singleCard.dateLabel.transform = .init(scaleX: 0.75, y: 0.75)
                self.singleResultModalView.singleCard.startTime.transform = .init(scaleX: 0.75, y: 0.75)
                self.singleResultModalView.singleCard.endTime.transform = .init(scaleX: 0.75, y: 0.75)
                self.updatePriorityColor()
            }, completion: { (finished: Bool) -> Void in
                self.setupNameLabel()
                self.setupDateLabel()
                self.setupTimeLabels()
                self.singleResultModalView.singleCard.nameLabel.transform = .identity
                self.singleResultModalView.singleCard.dateLabel.transform = .identity
                self.singleResultModalView.singleCard.startTime.transform = .identity
                self.singleResultModalView.singleCard.endTime.transform = .identity
            })
        }
    }
    
    @objc private func okButtonAction() {
        //TODO: Store assigned tasks
        task.state = .assigned
        TaskManager.persistAssignments(task: task)
        
        if let shuffleVC = shuffleVC {
            shuffleVC.shuffleSegmentedControllersDelegate.updateShuffleMessageLabel(shuffleConf: shuffleVC.shuffleConfiguration)
        }
        
        dismiss(animated: true, completion: nil)
    }

}
