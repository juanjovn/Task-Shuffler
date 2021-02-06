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
    private var clear: clearMode = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = modalView
        setupCancelButton()
        setupOkButton()
        setupReshuffleButton()
        setupTitleLabel()
        setupGestures()
    }
    
    // Gestures recognizers
    private func setupGestures() {
        let tapGestureTasks = UITapGestureRecognizer(target: self, action: #selector(clearTasksViewAction))
        modalView.clearTasksView.addGestureRecognizer(tapGestureTasks)
        
        let tapGestureGaps = UITapGestureRecognizer(target: self, action: #selector(clearGapsViewAction))
        modalView.clearGapsView.addGestureRecognizer(tapGestureGaps)
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
    
    @objc private func reshuffleButtonAction() {//Clear All button in this case. Reshuffle is in parent class.
        let db = DatabaseManager()
        Alert.confirmation(title: "Clear all data", message: "All tasks and gaps will be erased, are you sure?", vc: self) {_ in
            let queue = DispatchQueue.global()
            queue.sync {
                db.eraseAll()
            }
            
            queue.sync {
                NotificationCenter.default.post(name: .didModifiedData, object: nil)
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func okButtonAction() {
        let db = DatabaseManager()
        switch clear {
        case .tasks:
            Alert.confirmation(title: "Clear tasks data", message: "All tasks will be erased, are you sure?", vc: self) {_ in
                let queue = DispatchQueue.global()
                queue.sync {
                    db.deleteAllByType(object: TaskRealm.self)
                    GapManager.instance.resetGapAssignments()
                }
                
                queue.sync {
                    NotificationCenter.default.post(name: .didModifiedData, object: nil)
                }
                self.dismiss(animated: true, completion: nil)
            }
        case .gaps:
            Alert.confirmation(title: "Clear gaps data", message: "All gaps will be erased, are you sure?", vc: self) {_ in
                let queue = DispatchQueue.global()
                queue.sync {
                    db.deleteAllByType(object: GapRealm.self)
                    TaskManager.resetTaskAssignments()
                }
                
                queue.sync {
                    NotificationCenter.default.post(name: .didModifiedData, object: nil)
                }
                self.dismiss(animated: true, completion: nil)
            }
        case .none:
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func clearTasksViewAction() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        if SettingsValues.otherSettings[0] {
                generator.impactOccurred()
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.modalView.clearTasksView.backgroundColor = .fireOrange
            self.modalView.tasksTrashIcon.tintColor = .pearlWhite
            self.modalView.clearGapsView.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.15)
            self.modalView.gapsTrashIcon.tintColor = UIColor.pearlWhite.withAlphaComponent(0.6)
            self.modalView.tasksTrashIcon.transform = .init(scaleX: 1.10, y: 1.10)
            self.modalView.clearTasksView.layer.shadowOpacity = 0.7
            self.modalView.clearGapsView.layer.shadowOpacity = 0
        }, completion: {_ in
            UIView.animate(withDuration: 0.05){
                self.modalView.tasksTrashIcon.transform = .identity
            }
        })
        
        
        clear = .tasks
    }
    
    @objc private func clearGapsViewAction() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        if SettingsValues.otherSettings[0] {
                generator.impactOccurred()
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.modalView.clearGapsView.backgroundColor = .fireOrange
            self.modalView.gapsTrashIcon.tintColor = .pearlWhite
            self.modalView.clearTasksView.backgroundColor = UIColor.mysticBlue.withAlphaComponent(0.15)
            self.modalView.tasksTrashIcon.tintColor = UIColor.pearlWhite.withAlphaComponent(0.6)
            self.modalView.gapsTrashIcon.transform = .init(scaleX: 1.10, y: 1.10)
            self.modalView.clearTasksView.layer.shadowOpacity = 0
            self.modalView.clearGapsView.layer.shadowOpacity = 0.7
        }, completion: {_ in
            UIView.animate(withDuration: 0.05){
                self.modalView.gapsTrashIcon.transform = .identity
            }
        })
        
        clear = .gaps
    }

}

extension FactoryResetVC {
    private enum clearMode {
        case tasks
        case gaps
        case none
    }
}
