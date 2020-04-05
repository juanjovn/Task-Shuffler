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
    @IBOutlet weak var scrollTasks: UIScrollView!
    @IBOutlet weak var newTaskButtonBottomConstraint: NSLayoutConstraint!
    
    
    //Constants
    
    let transition = BubbleTransition()
    
    //Variables
    
    var myTask :Task?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        scrollTasks.delegate = self
        
        newTaskButton.layer.cornerRadius = newTaskButton.bounds.size.width/2
        newTaskButton.layer.shadowOffset = .init(width: 0, height: 1)
        newTaskButtonBottomConstraint.constant = -100
        newTaskButton.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.3098039216, blue: 0.2156862745, alpha: 1)
        newTaskButton.setTitleColor(#colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9529411765, alpha: 1), for: .normal)
        showButton()
        
        
        //***** Testing code *****
        
        myTask = Task(name: "Tarea de prueba", duration: 60, priority: .low)
        
//        if let task = myTask {
//            print(task)
//        } else {
//            print("Task llegó nulo")
//        }
        
        //***** Testing code *****
        
        
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

//MARK: Scrolling actions

extension TasksListViewController: UIScrollViewDelegate{
    
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
            self.view.layoutIfNeeded()
        }
        
    }
    
    func showButton() {
        
        UIView.animate(withDuration: 0.3) {
            self.newTaskButton.alpha = 1
            self.newTaskButtonBottomConstraint.constant = 80
            self.view.layoutIfNeeded()
        }
        
    }
    
}
