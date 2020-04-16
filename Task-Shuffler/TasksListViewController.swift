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
    @IBOutlet weak var segmentedController: SJFluidSegmentedControl!
    
    
    
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        tableView.delegate = self
        tableView.dataSource = self
        segmentedController.dataSource = self
        segmentedController.delegate = self
        
        view.backgroundColor = .naturGreen
        
        setupTableView()
        
        newTaskButton.layer.cornerRadius = newTaskButton.bounds.size.width/2
        newTaskButton.layer.shadowOffset = .init(width: 0, height: 1)
        newTaskButtonBottomConstraint.constant = -100
        newTaskButton.backgroundColor = .fireOrange
        newTaskButton.setTitleColor(.pearlWhite, for: .normal)
        showButton()
        
        
        //***** Testing code *****
        
        createTestTasks()
        
        //***** Testing code *****
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupSegmentedController()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        // insert row in table
//        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
//            let indexPath = IndexPath(row: 0, section: 0)
//            self.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//            self.tableView.reloadData()
//            }
    }
    
    // MARK: Functions
    
    func setupTableView() {
        tableView.backgroundColor = .naturGreen
    }
    
    func setupSegmentedController(){
        segmentedController.cornerRadius = segmentedController.frame.height / 2
        let currentTextSize = segmentedController.textFont.pointSize
        segmentedController.textFont = UIFont.avenirMedium(ofSize: currentTextSize)
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
    
    public func addNewTask (task: Task) {
        
        pendingTasks.append(task)
        print(pendingTasks.description)
//        let numbCurrentRows = tableView.numberOfRows(inSection: 0)
//        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {_ in
//        let indexPath = IndexPath(row: numbCurrentRows, section: 0)
//        self.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//
//        }
        
        _ = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) {_ in
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let `self` = self else { return }
                let indexSet = IndexSet(integer: 0)
                self.tableView.reloadSections(indexSet, with: UITableView.RowAnimation.fade)
            })
        }
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
      let controller = segue.destination
      controller.transitioningDelegate = self
      controller.modalPresentationCapturesStatusBarAppearance = true
      controller.modalPresentationStyle = .custom
        
        // Pass data between controllers
        let vc = segue.destination as? NewTaskViewController
        vc?.taskListVC = self // Assigns reference to the property on the modal view controller NewTaskViewController
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch indexPath.section {
                case 0:
                    if segmentedController.currentSegment == 0 {
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
            
            if !existTasks(tasks: assignedTasks){
                tableView.reloadSections(IndexSet(integer: 1), with: .fade)
            }
            
        }
    }
    
    
}

// MARK: TableView Data Source Delegate

extension TasksListViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return segmentedController.currentSegment == 0 ? pendingTasks.count : completedTasks.count
        } else {
            return segmentedController.currentSegment == 0 ? assignedTasks.count : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zelda = UITableViewCell.init(style: .default, reuseIdentifier: "prueba")
        zelda.backgroundColor = .pearlWhite
        
        var cellText = ""
        switch indexPath.section {
            case 0:
                if segmentedController.currentSegment == 0{
                    cellText = "\(pendingTasks[indexPath.row].name) -  \(pendingTasks[indexPath.row].duration) -  \(pendingTasks[indexPath.row].priority.rawValue)"
                } else {
                    cellText = "\(completedTasks[indexPath.row].name) -  \(completedTasks[indexPath.row].duration) -  \(completedTasks[indexPath.row].priority.rawValue)"
                }
                
            case 1:
                cellText = "\(assignedTasks[indexPath.row].name) -  \(assignedTasks[indexPath.row].duration) -  \(assignedTasks[indexPath.row].priority.rawValue)"
            
            default:
                break
            
        }
        
        zelda.textLabel?.text = cellText
        
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row), name = \(zelda.textLabel?.text ?? "default")")
        
        return zelda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return segmentedController.currentSegment == 0 ? 2 : 1 //In segmented controller index 0 two sections, in index 1 only one section with completed tasks
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let firstSectionTitle: String = segmentedController.currentSegment == 0 ? "Pending" : "Completed"
        let secondSectionTitle: String = segmentedController.currentSegment == 0 ? "Assigned" : ""
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

    
    
//    func countByState (_ tasks: [Task], _ state: State) -> Int {
//        var counter = 0
//
//        for task in tasks {
//            if task.state == state {
//                counter += 1
//            }
//        }
//        print ("Number of ROWS with state \(state) is : \(counter)")
//        return counter
//    }
    
    func existTasks (tasks: [Task]) -> Bool {
        print(tasks.count)
        print(tasks.count > 0)
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
    
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, willChangeFromSegment fromSegment: Int) {
//        if fromSegment == 0 {
//            //tableView.deleteSections(IndexSet(integer: 1), with: .bottom)
//        } else {
//            //tableView.reloadSections(IndexSet(integersIn: 0...1), with: .fade)
//        }
//    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl, didChangeFromSegmentAtIndex fromIndex: Int, toSegmentAtIndex toIndex: Int) {
//        if toIndex == 1 {
//            //tableView.deleteSections(IndexSet(integer: 1), with: .bottom)
//            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
//        } else {
//            tableView.reloadSections(IndexSet(integersIn: 0...1), with: .fade)
//        }
        
        tableView.reloadSections(IndexSet(integersIn: 0...1), with: .fade)
    }
}
