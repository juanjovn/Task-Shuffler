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
    
    override func viewDidAppear(_ animated: Bool) {
        hourView.layer.cornerRadius = hourView.layer.bounds.height / 2
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
        hourTableView.delegate = self
        hourTableView.dataSource = self
        hourTableView.register(HourCell.self, forCellReuseIdentifier: "hourCell")
        hourContainerView.addSubview(hourTableView)
        
        hourTableView.translatesAutoresizingMaskIntoConstraints = false
        hourTableView.topAnchor.constraint(equalTo: hourContainerView.topAnchor).isActive = true
        hourTableView.bottomAnchor.constraint(equalTo: hourContainerView.bottomAnchor).isActive = true
        hourTableView.leadingAnchor.constraint(equalTo: hourContainerView.leadingAnchor).isActive = true
        hourTableView.trailingAnchor.constraint(equalTo: hourContainerView.trailingAnchor).isActive = true
    }
    
    private func setupHourView() {
        hourView.backgroundColor = UIColor.mysticBlue
        hourContainerView.addSubview(hourView)
        
        hourView.translatesAutoresizingMaskIntoConstraints = false
        hourView.leadingAnchor.constraint(equalTo: hourContainerView.leadingAnchor, constant: 10).isActive = true
        hourView.trailingAnchor.constraint(equalTo: hourContainerView.trailingAnchor).isActive = true
        hourView.centerYAnchor.constraint(equalTo: hourContainerView.centerYAnchor).isActive = true
        hourView.heightAnchor.constraint(equalTo: hourContainerView.heightAnchor, multiplier: 1/12).isActive = true
    }
    
    private func setupHourLabel() {
        
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
            let hourViewheight = hourView.frame.size.height
            print(hourViewheight)
            var point = gesture.location(in: hourContainerView)
            point.x = hourView.center.x
            point.y = min(max(point.y, hourViewheight / 2), view.frame.size.height - hourViewheight / 2)
            
            if let indexPath = hourTableView.indexPathForRow(at: point) {
                hour = indexPath.row + 1
                hourLabel.text = "\(hour)"
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

//MARK: Extensions
extension TimePickerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case hourTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath) as! HourCell
            cell.hourLabel.text = "\(hour + indexPath.row + 1)"
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MinuteCell", for: indexPath) as! MinuteCell
            cell.minuteLabel.text = String(format: "%02lu", indexPath.row * 5)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
}

extension TimePickerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 12
    }
}
