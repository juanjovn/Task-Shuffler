//
//  ViewController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 25/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView

class ViewController: AMTabsViewController {
    
    //Variables
    
    var myTask :Task?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //***** Testing code *****
        
        
        myTask = Task(name: "Tarea de prueba", duration: 60, priority: .low, state: .pending)
        
//        if let task = myTask {
//            print(task)
//        } else {
//            print("Task llegó nulo")
//        }
        
        //***** Testing code *****
        
        
        //AMTabView test code
        
        setTabsControllers()
        
        
    }
    
    
    
    private func setTabsControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
//        let tasksViewController = storyboard.instantiateViewController(withIdentifier: "TasksListViewController")
//        let gapsViewController = storyboard.instantiateViewController(withIdentifier: "GapsViewController")
//        let scheduleViewController = storyboard.instantiateViewController(withIdentifier: "ScheduleViewController")
        let tasksNavigationController = storyboard.instantiateViewController(withIdentifier: "TasksNavigationController")
        let gapsNavigationController = storyboard.instantiateViewController(withIdentifier: "GapsNavigationController")
        let scheduleNavigationController = storyboard.instantiateViewController(withIdentifier: "ScheduleNavigationController")
        
        
        viewControllers = [
        tasksNavigationController,
        gapsNavigationController,
        scheduleNavigationController
      ]
    }


}
