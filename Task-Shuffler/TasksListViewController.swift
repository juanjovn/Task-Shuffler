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

class TasksListViewController: AMTabsViewController {
    
    //Outlets
    
    @IBOutlet weak var newTaskButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTaskButtonBottomConstraint: NSLayoutConstraint!
    
    
    //Constants
    
    let transition = BubbleTransition()
    
    //Variables
    
    var myTasks = [Task]() {
        didSet{
            groupTasks(myTasks)
        }
    }
    var groupedTasks: [(State, [Task])] = [(.pending, []), (.assigned, [])]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .naturGreen
        
        setupTableView()
        
        newTaskButton.layer.cornerRadius = newTaskButton.bounds.size.width/2
        newTaskButton.layer.shadowOffset = .init(width: 0, height: 1)
        newTaskButtonBottomConstraint.constant = -100
        newTaskButton.backgroundColor = .fireOrange
        newTaskButton.setTitleColor(.pearlWhite, for: .normal)
        showButton()
        
        
        //***** Testing code *****
        
        myTasks = createTestTasks()
        //groupTasks(myTasks)
        
//        if let task = myTask {
//            print(task)
//        } else {
//            print("Task llegó nulo")
//        }
        
        //***** Testing code *****
        
        
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
    
    func createTestTasks () -> [Task] {
        return [Task(name: "Tarea de prueba 1", duration: 60, priority: .medium, state: .assigned),
                Task(name: "Tarea de prueba 2", duration: 90, priority: .low, state: .pending),
                Task(name: "Tarea de prueba 3", duration: 15, priority: .low, state: .assigned),
                Task(name: "Tarea de prueba 4", duration: 30, priority: .high, state: .pending),
                Task(name: "Tarea de prueba 5", duration: 90, priority: .low, state: .pending),
                Task(name: "Tarea de prueba 6", duration: 180, priority: .medium, state: .pending),
                Task(name: "Tarea de prueba 7", duration: 120, priority: .low, state: .completed)
                ]
    }
    
    func groupTasks (_ tasks:[Task]) -> (){
        groupedTasks = [(.pending, []), (.assigned, [])] // Reinitialize array
        
        for t in tasks {
            if t.state == .pending{
                groupedTasks[0].1.append(t)
            }
            else {
                groupedTasks[1].1.append(t)
            }
        }
    }
    
    public func addNewTask (task: Task) {
        myTasks.append(task)
        print(groupedTasks.description)
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
    
}

// MARK: TableView Data Source Delegate

extension TasksListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return countByState(myTasks, .pending)
        } else {
            return countByState(myTasks, .assigned)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let zelda = UITableViewCell.init(style: .default, reuseIdentifier: "prueba")
        zelda.backgroundColor = .pearlWhite

        zelda.textLabel?.text = groupedTasks[indexPath.section].1[indexPath.row].name + " -  \(groupedTasks[indexPath.section].1[indexPath.row].duration) -  \(groupedTasks[indexPath.section].1[indexPath.row].priority.rawValue)"
        
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row), name = \(zelda.textLabel?.text ?? "default")")
        
        return zelda
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if existAssigned(myTasks) {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Pending"
        case 1:
            return "Assigned"
        default:
            return ""
        }
    }
    
    
    func countByState (_ tasks: [Task], _ state: State) -> Int {
        var counter = 0
        
        for task in tasks {
            if task.state == state {
                counter += 1
            }
        }
        print ("Number of ROWS with state \(state) is : \(counter)")
        return counter
    }
    
    func existAssigned (_ tasks: [Task]) -> Bool {
        var isAssigned = false
        
        for task in tasks {
            if task.state == .assigned {
                isAssigned = true
                break
            }
        }
        
        return isAssigned
    }
    
}
