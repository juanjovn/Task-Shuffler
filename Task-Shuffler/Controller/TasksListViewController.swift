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

class TasksListViewController: AMTabsViewController {
    
    //Outlets
    
    @IBOutlet weak var newTaskButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTaskButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControl: SJFluidSegmentedControl!
    
    
    
    //Constants
    
    let transition = BubbleTransition()
    
    //Variables
    
//    var myTasks = [Task]() {
//        didSet{
//            groupTasks(myTasks)
//        }
//    }
//    var groupedTasks: [(State, [Task])] = [(.pending, []), (.assigned, [])]
    
    var pendingTasks = [Task]()
    var assignedTasks = [Task]()
    var completedTasks = [Task]()
    var isTaskEditing: Bool = false
    
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
        
        view.backgroundColor = .paleSilver
        
        newTaskButton.layer.cornerRadius = newTaskButton.bounds.size.width/2
        newTaskButton.layer.shadowOffset = .init(width: 0, height: 1)
        newTaskButtonBottomConstraint.constant = -100
        newTaskButton.backgroundColor = .fireOrange
        newTaskButton.setTitleColor(.pearlWhite, for: .normal)
        showButton()
        
        
        //***** Testing code *****
        
        createTestTasks()
        
        //***** Testing code *****
        
        setupTableView()
        
    }
    
    // MARK: viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLayoutSubviews()
        setupSegmentedController()
    }
    
    // MARK: Functions
    
    func setupTableView() {
        tableView.backgroundColor = .paleSilver
        let nib = UINib(nibName: "TaskCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "taskCell")
        tableView.estimatedRowHeight = 40.0
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        tableView.contentInset = insets
    }
    
    func setupSegmentedController(){
        segmentedControl.cornerRadius = segmentedControl.frame.height / 2
        let currentTextSize = segmentedControl.textFont.pointSize
        segmentedControl.textFont = UIFont.avenirMedium(ofSize: currentTextSize)
    }
    
    func createTestTasks() {
        pendingTasks = [
            Task(name: "Tarea pendiente 1", duration: 60, priority: .medium, state: .pending),
            Task(name: "Tarea pendiente 2", duration: 90, priority: .low, state: .pending),
            Task(name: "Tarea pendiente 3", duration: 15, priority: .low, state: .pending),
            Task(name: "Tarea pendiente 4", duration: 30, priority: .high, state: .pending),
            Task(name: "Tarea pendiente 5", duration: 90, priority: .low, state: .pending),
            Task(name: "Tarea pendiente 6", duration: 180, priority: .medium, state: .pending),
            Task(name: "Tarea pendiente 7", duration: 120, priority: .low, state: .pending)
        ]
        assignedTasks = [
            Task(name: "Tarea asignada 1", duration: 60, priority: .medium, state: .assigned),
            //Task(name: "Tarea asignada 2", duration: 90, priority: .low, state: .assigned)
        ]
        completedTasks = [
            Task(name: "Tarea completada 1", duration: 60, priority: .medium, state: .completed),
            Task(name: "Tarea completada 2", duration: 90, priority: .low, state: .completed),
            Task(name: "Tarea completada 3", duration: 15, priority: .low, state: .completed),
            Task(name: "Tarea completada 4", duration: 30, priority: .high, state: .completed),
            Task(name: "Tarea completada 5", duration: 90, priority: .low, state: .completed)
        ]
    }
    
//    func groupTasks (_ tasks:[Task]) -> (){
//        groupedTasks = [(.pending, []), (.assigned, [])] // Reinitialize array
//
//        for t in tasks {
//            if t.state == .pending{
//                groupedTasks[0].1.append(t)
//            }
//            else {
//                groupedTasks[1].1.append(t)
//            }
//        }
//    }
    
    func delayReloadSections(section: Int) {
        _ = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) {_ in
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let `self` = self else { return }
                self.tableView.reloadSections(IndexSet(integer: section), with: UITableView.RowAnimation.fade)
            })
        }
    }
    
    public func addNewTask (task: Task) {
        pendingTasks.append(task)
        delayReloadSections(section: 0)
    }
    
    public func replaceTask (task: Task, position: Int) {
        pendingTasks[position] = task
        delayReloadSections(section: 0)
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
        if let i = (sender as? UIScrollView){
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
            switch indexPath.section {
                case 0:
                    if segmentedControl.currentSegment == 0 {
                        pendingTasks.remove(at: indexPath.row)
                    } else {
                        completedTasks.remove(at: indexPath.row)
                }
                case 1:
                    assignedTasks.remove(at: indexPath.row)
                default:
                    break
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            hideAssignedIfEmpty()
            
        }
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
        
        completedTasks.insert(task, at: 0)
        tableView.deleteRows(at: [indexPath], with: .fade)
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
        pendingTasks.append(task)
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
        zelda.backgroundColor = .pearlWhite
        zelda.nameLabel.font = .avenirMedium(ofSize: 21)
        
        var task = Task(name: "", duration: 0, priority: .low, state: .pending)
        switch indexPath.section {
            case 0:
                if segmentedControl.currentSegment == 0{
//                    cellText = "\(pendingTasks[indexPath.row].name) -  \(pendingTasks[indexPath.row].duration) -  \(pendingTasks[indexPath.row].priority.rawValue)"
                    task = pendingTasks[indexPath.row]
                } else {
//                    cellText = "\(completedTasks[indexPath.row].name) -  \(completedTasks[indexPath.row].duration) -  \(completedTasks[indexPath.row].priority.rawValue)"
                    task = completedTasks[indexPath.row]
                }
                
            case 1:
//                cellText = "\(assignedTasks[indexPath.row].name) -  \(assignedTasks[indexPath.row].duration) -  \(assignedTasks[indexPath.row].priority.rawValue)"
                task = assignedTasks[indexPath.row]
            
            default:
                break
            
        }
        
        zelda.nameLabel.text = task.name
        zelda.durationLabel.text = String(task.duration) + "'"
        
        switch task.priority {
            case .low:
                zelda.priorityImage.image = UIImage(named: "exc_mark_low")
            case .medium:
                zelda.priorityImage.image = UIImage(named: "exc_mark_med")
            case .high:
                zelda.priorityImage.image = UIImage(named: "exc_mark_high")
        }
        
        //print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row), name = \(zelda.textLabel?.text ?? "default")")
        
        return zelda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return segmentedController.currentSegment == 0 ? 2 : 1 //In segmented controller index 0 two sections, in index 1 only one section with completed tasks
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 9
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
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, titleForSegmentAtIndex index: Int) -> String? {
        index == 0 ? "Current" : "Completed"
    }
}

//MARK: Segmented Control Delegate

extension TasksListViewController: SJFluidSegmentedControlDelegate {
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
        
        tableView.reloadSections(IndexSet(integersIn: 0...1), with: .fade)
    }
}
