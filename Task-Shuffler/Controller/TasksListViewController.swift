//
//  TasksListViewController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 29/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView
import BubbleTransition
import SJFluidSegmentedControl
import RealmSwift

class TasksListViewController: AMTabsViewController {
    
    //Outlets
    
    @IBOutlet weak var newTaskButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTaskButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControlBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
    
    
    
    //Constants
    
    let db = DatabaseManager()
    let transition = BubbleTransition()
    
    //Variables

    var pendingTasks = [Task]()
    var assignedTasks = [Task]()
    var completedTasks = [Task]()
    var isTaskEditing: Bool = false
    
    //Enums
    
    private enum SortType: String {
        case name = "By name"
        case priority = "By priority"
        case duration = "By duration"
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        tableView.delegate = self
        tableView.dataSource = self
        segmentedControl.dataSource = self
        segmentedControl.delegate = self
        
        view.backgroundColor = .mysticBlue
        
        newTaskButton.layer.cornerRadius = newTaskButton.bounds.size.width/2
        newTaskButton.layer.shadowOffset = .init(width: 0, height: 1)
        newTaskButtonBottomConstraint.constant = -100
        newTaskButton.backgroundColor = .fireOrange
        newTaskButton.setTitleColor(.pearlWhite, for: .normal)
        showButton()
        
        
        //***** Testing code *****
        
        //createTestTasks()
        print(try! Realm().configuration.fileURL!)
        pendingTasks = TaskManager.populateTasks(state: .pending)
        assignedTasks = TaskManager.populateTasks(state: .assigned)
        completedTasks = TaskManager.populateTasks(state: .completed)
        
        //***** Testing code *****
        
        setupTableView()
        setupNavigationBar()
        setupSegmentedController()
    }
    
    // MARK: viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        segmentedControl.cornerRadius = segmentedControl.bounds.height / 2
        tableView.reloadData()
    }
    
    // MARK: Functions
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "sort"), style: .plain, target: self, action: #selector(sortButtonAction))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
    }
    
    @objc private func sortButtonAction () {
        let sortMenu = UIAlertController(title: "Sort by", message: nil, preferredStyle: .actionSheet)
        let sortByPriorityAction = UIAlertAction(title: "Priority", style: .default, handler: {
            action in
            self.sortActions(sortType: .priority)
        })
        let sortByDurationAction = UIAlertAction(title: "Duration", style: .default, handler: {
            action in
            self.sortActions(sortType: .duration)
        })
        let sortByNameAction = UIAlertAction(title: "Name", style: .default, handler: {
            action in
            self.sortActions(sortType: .name)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        sortMenu.addAction(sortByNameAction)
        sortMenu.addAction(sortByPriorityAction)
        sortMenu.addAction(sortByDurationAction)
        sortMenu.addAction(cancelAction)
        
        sortMenu.pruneNegativeWidthConstraints()
        self.present(sortMenu, animated: true, completion: nil)
        
    }
    
    @objc func settingsButtonAction(){
        let settingsVC = SettingsVC()

        present(UINavigationController(rootViewController: settingsVC), animated: true)
        //present(settingsVC, animated: true)
    }
    
    private func sortActions (sortType: SortType) {
        switch sortType {
        case .priority:
            if segmentedControl.currentSegment == 0 {
                let sortedTasks = pendingTasks.sorted(by: {$0.priority.rawValue > $1.priority.rawValue})
                if sortedTasks == pendingTasks {
                    pendingTasks = sortedTasks.sorted(by: {$0.priority.rawValue < $1.priority.rawValue})
                    assignedTasks = assignedTasks.sorted(by: {$0.priority.rawValue < $1.priority.rawValue})
                } else {
                    pendingTasks = sortedTasks
                    assignedTasks = assignedTasks.sorted(by: {$0.priority.rawValue > $1.priority.rawValue})
                }
            } else {
                let sortedTasks = completedTasks.sorted(by: {$0.priority.rawValue > $1.priority.rawValue})
                if sortedTasks == completedTasks {
                    completedTasks = sortedTasks.sorted(by: {$0.priority.rawValue < $1.priority.rawValue})
                } else {
                    completedTasks = sortedTasks
                }
            }
        case .name:
            if segmentedControl.currentSegment == 0 {
                let sortedTasks = pendingTasks.sorted(by: {$0.name < $1.name})
                if sortedTasks == pendingTasks {
                    pendingTasks = sortedTasks.sorted(by: {$0.name > $1.name})
                    assignedTasks = assignedTasks.sorted(by: {$0.name > $1.name})
                } else {
                    pendingTasks = sortedTasks
                    assignedTasks = assignedTasks.sorted(by: {$0.name < $1.name})
                }
            } else {
                let sortedTasks = completedTasks.sorted(by: {$0.name < $1.name})
                if sortedTasks == completedTasks {
                    completedTasks = sortedTasks.sorted(by: {$0.name > $1.name})
                } else {
                    completedTasks = sortedTasks
                }
            }
        case .duration:
            if segmentedControl.currentSegment == 0 {
                let sortedTasks = pendingTasks.sorted(by: {$0.duration < $1.duration})
                if sortedTasks == pendingTasks {
                    pendingTasks = sortedTasks.sorted(by: {$0.duration > $1.duration})
                    assignedTasks = assignedTasks.sorted(by: {$0.duration > $1.duration})
                } else {
                    pendingTasks = sortedTasks
                    assignedTasks = assignedTasks.sorted(by: {$0.duration < $1.duration})
                }
            } else {
                let sortedTasks = completedTasks.sorted(by: {$0.duration < $1.duration})
                if sortedTasks == completedTasks {
                    completedTasks = sortedTasks.sorted(by: {$0.duration > $1.duration})
                } else {
                    completedTasks = sortedTasks
                }
            }
        }
        
        tableView.reloadSections(IndexSet(integersIn: 0...tableView.numberOfSections - 1), with: .fade)
    }
    
    func setupTableView() {
        tableView.backgroundColor = .paleSilver
        let nib = UINib(nibName: "TaskCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "taskCell")
        
        let insets = UIEdgeInsets(top: 18, left: 0, bottom: 120, right: 0)
        tableView.contentInset = insets
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
    }
    
    func setupSegmentedController(){
        segmentedControl.cornerRadius = segmentedControl.bounds.height / 2
        let currentTextSize = segmentedControl.textFont.pointSize
        segmentedControl.textFont = UIFont.avenirMedium(ofSize: currentTextSize)
//        segmentedControl.layer.shadowOffset = CGSize(width: 0, height: 2)
//        segmentedControl.layer.shadowColor = UIColor.black.cgColor
//        segmentedControl.layer.shadowOpacity = 0.2
//        segmentedControl.layer.shadowRadius = 3
//        segmentedControl.layer.shadowPath = UIBezierPath(roundedRect: segmentedControl.bounds, cornerRadius: 3).cgPath
//        segmentedControl.layer.shouldRasterize = true
//        segmentedControl.layer.rasterizationScale = UIScreen.main.scale
    }
    
//    func createTestTasks() {
//        pendingTasks = [
//            
//            Task(name: "Poner la lavadora y tender la ropa hoy", duration: 180, priority: .high, state: .pending),
//            Task(name: "Tarea pendiente 1", duration: 60, priority: .medium, state: .pending),
//            Task(name: "Tarea pendiente 2", duration: 90, priority: .low, state: .pending),
//            Task(name: "Tarea pendiente 3", duration: 15, priority: .low, state: .pending),
//            Task(name: "Tarea pendiente 4", duration: 30, priority: .high, state: .pending),
//            Task(name: "Tarea pendiente 5", duration: 90, priority: .low, state: .pending),
//            Task(name: "Tarea pendiente 6 Tarea pendiente 6", duration: 180, priority: .medium, state: .pending),
//            Task(name: "Tarea pendiente 7", duration: 120, priority: .low, state: .pending),
//            Task(name: "Tarea pendiente 2", duration: 90, priority: .low, state: .pending),
//            Task(name: "Tarea pendiente 3", duration: 15, priority: .low, state: .pending),
//            Task(name: "Tarea pendiente 6 Tarea pendiente 6", duration: 30, priority: .high, state: .pending),
//            Task(name: "Tarea pendiente 6 Tarea pendiente 6", duration: 90, priority: .low, state: .pending),
//            Task(name: "Tarea pendiente 6", duration: 180, priority: .medium, state: .pending),
//        ]
//        assignedTasks = [
//            Task(name: "Tarea asignada 1", duration: 60, priority: .medium, state: .assigned),
//            Task(name: "Tarea asignada 2", duration: 90, priority: .low, state: .assigned),
//            Task(name: "Tarea asignada 3", duration: 10, priority: .high, state: .assigned),
//            Task(name: "Tarea pendiente 2", duration: 90, priority: .low, state: .assigned),
//            Task(name: "Tarea pendiente 3", duration: 15, priority: .low, state: .assigned),
//            Task(name: "Tarea pendiente 6 Tarea pendiente 6", duration: 30, priority: .high, state: .assigned),
//            Task(name: "Tarea pendiente 5", duration: 90, priority: .low, state: .assigned),
//            Task(name: "Tarea pendiente 6", duration: 180, priority: .medium, state: .assigned),
//        ]
//        completedTasks = [
//            Task(name: "Tarea completada 1", duration: 60, priority: .medium, state: .completed),
//            Task(name: "Tarea completada 2", duration: 90, priority: .low, state: .completed),
//            Task(name: "Tarea pendiente 6 Tarea pendiente 6", duration: 15, priority: .low, state: .completed),
//            Task(name: "Tarea completada 4", duration: 30, priority: .high, state: .completed),
//            Task(name: "Tarea pendiente 6 Tarea pendiente 6", duration: 90, priority: .low, state: .completed),
//            Task(name: "Tarea pendiente 2", duration: 90, priority: .low, state: .completed),
//            Task(name: "Tarea pendiente 6 Tarea pendiente 6", duration: 15, priority: .low, state: .completed),
//            Task(name: "Tarea pendiente 4", duration: 30, priority: .high, state: .completed),
//            Task(name: "Tarea pendiente 5", duration: 90, priority: .low, state: .completed),
//            Task(name: "Tarea pendiente 6", duration: 180, priority: .medium, state: .completed),
//        ]
//    }
    
    func delayReloadSections(section: Int) {
        _ = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) {_ in
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let `self` = self else { return }
                self.tableView.reloadSections(IndexSet(integer: section), with: UITableView.RowAnimation.fade)
                let topIndex = IndexPath(row: 0, section: 0)
                
                if self.tableView.numberOfRows(inSection: 0) > 0{
                    self.tableView.scrollToRow(at: topIndex, at: .top, animated: true)
                }
                
            })
        }
    }
    
    public func addNewTask (task: Task) {
        pendingTasks.insert(task, at: 0)
        delayReloadSections(section: 0)
        
        if segmentedControl.currentSegment > 0 {
            segmentedControl.setCurrentSegmentIndex(0, animated: true)
        }
    }
    
    public func replaceTask (task: Task, position: Int) {
        pendingTasks[position] = task
        delayReloadSections(section: 0)
        TaskManager.updateTask(task: task)
    }
    
    func testDatabaseAdd(){
        let model = DummyModel()
        model.name = "Juanjo"
        db.addData(object: model)
    }
    
    func testDatabaseCleanAll(){
        db.eraseAll()
    }
    
    func testDatabaseRemove(){
        let models = db.getData(objectClass: DummyModel.self)
        db.deleteData(object: models[0])
    }
    
    
}

extension TasksListViewController: TabItem{
    
    var tabImage: UIImage? {
        return UIImage(named: "task_icon")
    }
    
}


//MARK: Bubble Transition

extension TasksListViewController: UIViewControllerTransitioningDelegate{
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let rowIndex: IndexPath
      let controller = segue.destination as? NewTaskViewController
      controller?.transitioningDelegate = self
      controller?.modalPresentationCapturesStatusBarAppearance = true
      controller?.modalPresentationStyle = .custom
        if (sender as? UIScrollView) != nil{
            rowIndex = tableView.indexPathForSelectedRow!
            controller?.selectedRow = rowIndex
        }
        // Pass data between controllers
        controller?.taskListVC = self // Assigns reference to the property on the modal view controller NewTaskViewController
    }
    
    // MARK: UIViewControllerTransitioningDelegate

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      transition.transitionMode = .present
      transition.startingPoint = newTaskButton.center
      transition.bubbleColor = newTaskButton.backgroundColor ?? .black
      return transition
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
      transition.transitionMode = .dismiss
      transition.startingPoint = newTaskButton.center
      transition.bubbleColor = newTaskButton.backgroundColor ?? .black
      return transition
    }
    
}

//MARK: TableView scrolling actions

extension TasksListViewController: UITableViewDelegate{
    
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
            self.newTaskButton.alpha = 0
            self.newTaskButtonBottomConstraint.constant = 0
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
            self.newTaskButton.alpha = 1
            self.newTaskButtonBottomConstraint.constant = 80
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
                    self.deleteTask(indexPath)
                })
            } else {
                deleteTask(indexPath)
            }
        }
    }
    
    func deleteTask (_ indexPath: IndexPath){
        var task = Task(id: "", name: "", duration: 10, priority: .low, state: .pending)
        switch indexPath.section {
        case 0:
            if segmentedControl.currentSegment == 0 {
                task = pendingTasks[indexPath.row]
                pendingTasks.remove(at: indexPath.row)
            } else {
                task = completedTasks[indexPath.row]
                completedTasks.remove(at: indexPath.row)
            }
        case 1:
            task = assignedTasks[indexPath.row]
            assignedTasks.remove(at: indexPath.row)
        default:
            break
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        db.deleteByPK(primaryKey: task.id, objectClass: TaskRealm.self)
        
        hideAssignedIfEmpty()
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var swipeAction = UIContextualAction()
        if segmentedControl.currentSegment == 0 {
            swipeAction = UIContextualAction(style: .normal, title: "✓", handler: {
                (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                self.markCompleted(indexPath: indexPath)
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
                self.restoreTask(indexPath: indexPath)
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
        if indexPath.section == 0 && segmentedControl.currentSegment == 0{
            isTaskEditing = true
            performSegue(withIdentifier: "newTaskSegue", sender: tableView)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func markCompleted(indexPath: IndexPath) {
        var task: Task
        
        if indexPath.section == 0 {
            task = pendingTasks[indexPath.row]
            pendingTasks.remove(at: indexPath.row)
        } else {
            task = assignedTasks[indexPath.row]
            assignedTasks.remove(at: indexPath.row)
        }
        task.state = .completed
        completedTasks.insert(task, at: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
        TaskManager.updateTask(task: task)
        hideAssignedIfEmpty()
    }
    
    private func hideAssignedIfEmpty() {
        if !existTasks(tasks: assignedTasks){
            tableView.reloadSections(IndexSet(integer: 1), with: .fade)
        }
    }
    
    private func restoreTask(indexPath: IndexPath) {
        var task: Task
        task = completedTasks[indexPath.row]
        completedTasks.remove(at: indexPath.row)
        task.state = .pending
        pendingTasks.append(task)
        TaskManager.updateTask(task: task)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    
}

// MARK: TableView Data Source Delegate

extension TasksListViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return segmentedControl.currentSegment == 0 ? pendingTasks.count : completedTasks.count
        } else {
            return segmentedControl.currentSegment == 0 ? assignedTasks.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zelda = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        var task = Task(id: "", name: "", duration: 0, priority: .low, state: .pending)
        switch indexPath.section {
            case 0:
                if segmentedControl.currentSegment == 0{
                    task = pendingTasks[indexPath.row]
                } else {
                    task = completedTasks[indexPath.row]
                }
                
            case 1:
                task = assignedTasks[indexPath.row]
            
            default:
                break
            
        }
        
        zelda.nameLabel.text = task.name
        zelda.durationLabel.text = String(task.duration) + "'"
        
        switch task.priority {
        case .low:
            zelda.priorityImage.image = UIImage(named: "exclamationmark.circle")
            zelda.priorityImage.tintColor = .powerGreen
        case .medium:
            zelda.priorityImage.image = UIImage(named: "exclamationmark.circle")
            zelda.priorityImage.tintColor = .systemOrange
        case .high:
            zelda.priorityImage.image = UIImage(named: "exclamationmark.circle")
            zelda.priorityImage.tintColor = .fireOrange
        }
        
        return zelda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstSectionTitle: String = segmentedControl.currentSegment == 0 ? "Pending" : "Completed"
        let secondSectionTitle: String = segmentedControl.currentSegment == 0 ? "Assigned" : ""
        switch section {
        case 0:
            return firstSectionTitle
        case 1:
            if existTasks(tasks: assignedTasks){
                return secondSectionTitle
            } else{
                return nil
            }
        default:
            return ""
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func existTasks (tasks: [Task]) -> Bool {
        return tasks.count > 0
    }
    
}

//MARK: Segmented Control datasource protocol

extension TasksListViewController: SJFluidSegmentedControlDataSource{
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        2
    }
    
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
//        index == 0 ? "Current" : "Completed"
//    }
    
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
}

//MARK: Segmented Control Delegate

extension TasksListViewController: SJFluidSegmentedControlDelegate {
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        
        tableView.reloadSections(IndexSet(integersIn: 0...1), with: .fade)
        
        if tableView.numberOfRows(inSection: 0) > 0{
            let topIndex = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndex, at: .top, animated: true)
            tableView.reloadData()
        }
        
    }
}

//Just for mute a autolayout warning by a bug of iOS: https://stackoverflow.com/questions/55653187/swift-default-alertviewcontroller-breaking-constraints
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
