//
//  ScheduleViewController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 29/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView

class ScheduleViewController: AMTabsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationItems()
        setupCalendarView()
    }
    
    func setupNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "gear"), style: .plain, target: self, action: #selector(settingsButtonAction))
    }
    
    func setupView() {
        view.backgroundColor = .paleSilver
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupCalendarView() {
        let calendarVC = CalendarVC()
        addChild(calendarVC)
        let calendarView = calendarVC.view!
        view.addSubview(calendarView)
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        calendarVC.didMove(toParent: self)
    }
    
    @objc func settingsButtonAction() {
        present(UINavigationController(rootViewController: SettingsVC()), animated: true)
    }


}

extension ScheduleViewController: TabItem{
    
    var tabImage: UIImage? {
        return UIImage(named: "calendar")
    }
    
}
