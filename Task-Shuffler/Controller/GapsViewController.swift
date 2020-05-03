//
//  GapsViewController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 29/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView
import SJFluidSegmentedControl

class GapsViewController: AMTabsViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
    @IBOutlet weak var segmentedControlBottomConstraint: NSLayoutConstraint!
    
    //Constants
    let db = DatabaseManager()
    
    //Variable
    var pendingGaps = [GapRealm]()
    var assignedGaps = [GapRealm]()
    var completedGaps = [GapRealm]()
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationItems()
        setupSegmentedControl()
        setupTableView()
    }
    
    func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sort"), style: .plain, target: self, action: #selector(sortButtonAction))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
    }
    
    func setupView(){
        view.backgroundColor = .paleSilver
    }
    
    @objc func settingsButtonAction(){
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }
    
    @objc func sortButtonAction(){
    }
    
    func setupSegmentedControl(){
        segmentedControl.dataSource = self
        segmentedControl.delegate = self
        segmentedControl.cornerRadius = segmentedControl.bounds.height / 2
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .paleSilver
        let nib = UINib(nibName: "TaskCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "taskCell")
        
        let insets = UIEdgeInsets(top: 18, left: 0, bottom: 120, right: 0)
        tableView.contentInset = insets
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }

}

//MARK: Segmented Control

extension GapsViewController: SJFluidSegmentedControlDataSource, SJFluidSegmentedControlDelegate{
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        2
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        if index == 0{
            return [UIColor.fireOrange]
        } else {
            return [UIColor.powerGreen]
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        switch bounce {
        case .left:
            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
        case .right:
            return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        }
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        
        tableView.reloadSections(IndexSet(integersIn: 0...1), with: .fade)
        
        if tableView.numberOfRows(inSection: 0) > 0{
            let topIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndex, at: .top, animated: true)
            tableView.reloadData()
        }
        
    }
    
}

extension GapsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking{
            hideButton()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            showButton()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showButton()
    }
    
    func hideButton() {
        UIView.animate(withDuration: 0.5) {
            //self.newTaskButton.alpha = 0
            //self.newTaskButtonBottomConstraint.constant = 0
            self.segmentedControl.alpha = 0
            self.segmentedControlBottomConstraint.constant = 30
            
            // This conditional is just for avoid a xcode warning about UITableView:
            // [TableView] Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window).
            if self.view.window != nil{
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showButton() {
        UIView.animate(withDuration: 0.3) {
            //self.newTaskButton.alpha = 1
            //self.newTaskButtonBottomConstraint.constant = 80
            self.segmentedControl.alpha = 1
            self.segmentedControlBottomConstraint.constant = 0
            
            // This conditional is just for avoid a xcode warning about UITableView:
            // [TableView] Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window).
            if self.view.window != nil{
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView

        if let textlabel = header.textLabel {
            textlabel.font = .avenirDemiBold(ofSize: 20)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (SettingsValues.taskSettings[1]){
                Alert.confirmation(title: "Confirm delete?", message: nil, vc: self, handler: {_ in
                    //self.deleteTask(indexPath)
                })
            } else {
                //deleteTask(indexPath)
            }
        }
    }
    
    func deleteTask (_ indexPath: IndexPath){
//        var task = Task(id: "", name: "", duration: 10, priority: .low, state: .pending)
//        switch indexPath.section {
//        case 0:
//            if segmentedControl.currentSegment == 0 {
//                task = pendingTasks[indexPath.row]
//                pendingTasks.remove(at: indexPath.row)
//            } else {
//                task = completedTasks[indexPath.row]
//                completedTasks.remove(at: indexPath.row)
//            }
//        case 1:
//            task = assignedTasks[indexPath.row]
//            assignedTasks.remove(at: indexPath.row)
//        default:
//            break
//        }
//
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        db.deleteByPK(primaryKey: task.id, objectClass: TaskRealm.self)
//
//        hideAssignedIfEmpty()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipeAction = UIContextualAction()
        if segmentedControl.currentSegment == 0 {
            swipeAction = UIContextualAction(style: .normal, title: "✓", handler: {
                (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                //self.markCompleted(indexPath: indexPath)
                print("✅ Marcado completado")
                success(true)
            })
            swipeAction.image = UIGraphicsImageRenderer(size: CGSize(width: 26, height: 20)).image { _ in
                UIImage(named: "tick")?.draw(in: CGRect(x: 0, y: 0, width: 26, height: 20))
            }
            swipeAction.backgroundColor = .powerGreen
        } else {
            swipeAction = UIContextualAction(style: .normal, title: "⎌", handler: {
                (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                //self.restoreTask(indexPath: indexPath)
                print("⎌ Marcado restaurar")
                success(true)
            })
            swipeAction.image = UIGraphicsImageRenderer(size: CGSize(width: 26, height: 26)).image { _ in
                UIImage(named: "restore")?.draw(in: CGRect(x: 0, y: 0, width: 26, height: 26))
            }
            swipeAction.backgroundColor = .systemOrange
        }
        
        return UISwipeActionsConfiguration(actions: [swipeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 0 && segmentedControl.currentSegment == 0{
//            isTaskEditing = true
//            performSegue(withIdentifier: "newTaskSegue", sender: tableView)
//        }
//
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func markCompleted(indexPath: IndexPath) {
//        var task: Task
//
//        if indexPath.section == 0 {
//            task = pendingTasks[indexPath.row]
//            pendingTasks.remove(at: indexPath.row)
//        } else {
//            task = assignedTasks[indexPath.row]
//            assignedTasks.remove(at: indexPath.row)
//        }
//        task.state = .completed
//        completedTasks.insert(task, at: 0)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//        TaskManager.updateTask(task: task)
//        hideAssignedIfEmpty()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return segmentedControl.currentSegment == 0 ? pendingGaps.count : completedGaps.count
        } else {
            return segmentedControl.currentSegment == 0 ? assignedGaps.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zelda = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        

        
        return zelda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstSectionTitle: String = segmentedControl.currentSegment == 0 ? "Free" : "Completed"
        let secondSectionTitle: String = segmentedControl.currentSegment == 0 ? "Assigned" : ""
        switch section {
        case 0:
            return firstSectionTitle
        case 1:
            if existGaps(gaps: assignedGaps){
                return secondSectionTitle
            } else{
                return nil
            }
        default:
            return ""
        }
    }
    
    func existGaps (gaps: [GapRealm]) -> Bool {
        return gaps.count > 0
    }
    
}

extension GapsViewController: TabItem{
    
    var tabImage: UIImage? {
        return UIImage(named: "clock")
    }
    
}
