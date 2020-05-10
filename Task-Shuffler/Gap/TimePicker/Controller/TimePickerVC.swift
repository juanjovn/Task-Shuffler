//
//  TimePicker.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 10/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

protocol TimePickerVCDelegate {
    func timeDidSelect(hour: Int, minute: Int)
}

class TimePickerVC: UIViewController {
    var delegate: TimePickerVCDelegate?
    
    var hourContainerView = UIView()
    var hourView = UIView()
    var hourLabel = UILabel()
    var hourTableView = UITableView()
    var minuteContainerView = UIView()
    var minuteView = UIView()
    var minuteLabel = UILabel()
    var minuteTableView = UITableView()
    
    var hour: Int = 0
    var minute: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hourContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gesture)))
        hourContainerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gesture)))
        
        minuteContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gesture)))
        minuteContainerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(gesture)))
        
        setupHourContainerView()
        setupMinuteContainerView()

    }
    
    private func setupHourContainerView() {
        hourContainerView.backgroundColor = .systemPink
        view.addSubview(hourContainerView)
        
        hourContainerView.translatesAutoresizingMaskIntoConstraints = false
        hourContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hourContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        hourContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hourContainerView.trailingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        setupHourTableView()
        setupHourView()
    }
    
    private func setupHourTableView() {
        hourContainerView.addSubview(hourTableView)
        
        hourTableView.translatesAutoresizingMaskIntoConstraints = false
        hourTableView.topAnchor.constraint(equalTo: hourContainerView.topAnchor).isActive = true
        hourTableView.bottomAnchor.constraint(equalTo: hourContainerView.bottomAnchor).isActive = true
        hourTableView.leadingAnchor.constraint(equalTo: hourContainerView.leadingAnchor).isActive = true
        hourTableView.trailingAnchor.constraint(equalTo: hourContainerView.trailingAnchor).isActive = true
    }
    
    private func setupHourView() {
        hourView.backgroundColor = .mysticBlue
        hourContainerView.addSubview(hourView)
        
        hourView.translatesAutoresizingMaskIntoConstraints = false
        hourView.leadingAnchor.constraint(equalTo: hourContainerView.leadingAnchor).isActive = true
        hourView.trailingAnchor.constraint(equalTo: hourContainerView.trailingAnchor).isActive = true
        hourView.centerYAnchor.constraint(equalTo: hourContainerView.centerYAnchor).isActive = true
        hourView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setupMinuteContainerView() {
        minuteContainerView.backgroundColor = .systemBlue
        view.addSubview(minuteContainerView)
        
        minuteContainerView.translatesAutoresizingMaskIntoConstraints = false
        minuteContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        minuteContainerView.leadingAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        minuteContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        minuteContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    //MARK: Actions
    @objc func gesture(gesture: UIGestureRecognizer) {
        guard let view = gesture.view else { return }
        switch view {
        case hourContainerView:
            var point = gesture.location(in: hourContainerView)
            point.x = hourView.center.x
            point.y = min(max(point.y, 30), view.frame.size.height - 30)
            
            if let indexPath = hourTableView.indexPathForRow(at: point) {
                hour = indexPath.row + 1
                hourLabel.text = String(format: "%02lu", hour)
            }
            
            UIView.animate(withDuration: 0.1) {
                self.hourView.center = point
            }
        case minuteContainerView:
            var point = gesture.location(in: minuteContainerView)
            point.x = minuteView.center.x
            point.y = min(max(point.y, 30), view.frame.size.height - 30)
            
            if let indexPath = hourTableView.indexPathForRow(at: point) {
                minute = indexPath.row * 5
                minuteLabel.text = String(format: "%02lu", minute)
            }
            
            UIView.animate(withDuration: 0.1) {
                self.minuteView.center = point
            }
        default: break
        }
    }
}
