//
//  TimePicker.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 10/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

protocol TimePickerVCDelegate {
    func timeDidSelect(hour: Int?, minute: Int?)
}

class TimePickerVC: UIViewController {
    var delegate: TimePickerVCDelegate?
    
    var hourContainerView = UIView()
    var hourView = UIView()
    var hourLabel = UILabel()
    var hLabel = UILabel()
    let dotLabel = UILabel()
    var amPmButton = UIButton(type: .system)
    var amPmButtonCotainerView = UIView()
    var hourTableView = UITableView()
    var minuteContainerView = UIView()
    var minuteView = UIView()
    var minuteLabel = UILabel()
    var mLabel = UILabel()
    let dotLabelM = UILabel()
    var dragLinesView = UIImageView(image: UIImage(named: "draglines"))
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
        minuteView.layer.cornerRadius = minuteView.layer.bounds.height / 2
        amPmButtonCotainerView.layer.cornerRadius = amPmButtonCotainerView.bounds.size.height / 2
    }
    
    private func setupHourContainerView() {
        hourContainerView.backgroundColor = UIColor.bone.withAlphaComponent(0.80)
        hourContainerView.layer.cornerRadius = 20
        view.addSubview(hourContainerView)
        
        hourContainerView.translatesAutoresizingMaskIntoConstraints = false
        hourContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        hourContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        hourContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        hourContainerView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -5).isActive = true
        
        setupHourTableView()
        setupHourView()
    }
    
    private func setupHourTableView() {
        hourTableView.delegate = self
        hourTableView.dataSource = self
        hourTableView.register(HourCell.self, forCellReuseIdentifier: "hourCell")
        hourTableView.isScrollEnabled = false
        hourTableView.separatorStyle = .none
        hourTableView.backgroundColor = .clear
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
        hourView.leadingAnchor.constraint(equalTo: hourContainerView.leadingAnchor, constant: 1).isActive = true
        hourView.trailingAnchor.constraint(equalTo: hourContainerView.trailingAnchor, constant: -1).isActive = true
        hourView.topAnchor.constraint(equalTo: hourContainerView.topAnchor).isActive = true
        hourView.heightAnchor.constraint(equalTo: hourContainerView.heightAnchor, multiplier: 1/12).isActive = true
        
        setupHourLabel()
        setupHLabel()
        setupAmPmButton()
        setupAmPmButtonContainerView()
        setupDotLabel()
    }
    
    private func setupHourLabel() {
        hourLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(24))
        hourLabel.textColor = .pearlWhite
        hourLabel.text = "1"
        hourView.addSubview(hourLabel)
        
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.centerYAnchor.constraint(equalTo: hourView.centerYAnchor).isActive = true
        hourLabel.trailingAnchor.constraint(equalTo: hourView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func setupHLabel() {
        hLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(24))
        hLabel.textColor = .pearlWhite
        hLabel.text = "h"
        hourView.addSubview(hLabel)
        
        hLabel.translatesAutoresizingMaskIntoConstraints = false
        hLabel.trailingAnchor.constraint(equalTo: hourLabel.leadingAnchor, constant: -10).isActive = true
        hLabel.bottomAnchor.constraint(equalTo: hourLabel.bottomAnchor).isActive = true
    }
    
    private func setupAmPmButton() {
        amPmButton.setTitleColor(.fireOrange, for: .normal)
        amPmButton.setTitleColor(.fireOrange, for: .selected)
        amPmButton.titleLabel?.font = .avenirMedium(ofSize: UIFont.scaleFont(16))
        amPmButton.tintColor = .clear
        amPmButton.setTitle("AM", for: .normal)
        amPmButton.setTitle("PM", for: .selected)
        amPmButton.addTarget(self, action: #selector(amPmAction), for: .touchUpInside)
        hourView.addSubview(amPmButton)
        
        amPmButton.translatesAutoresizingMaskIntoConstraints = false
        amPmButton.centerYAnchor.constraint(equalTo: hourView.centerYAnchor).isActive = true
        amPmButton.leadingAnchor.constraint(equalTo: hourView.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupAmPmButtonContainerView() {
        amPmButtonCotainerView.backgroundColor = UIColor.pearlWhite.withAlphaComponent(0.15)
        hourView.addSubview(amPmButtonCotainerView)
        hourView.sendSubviewToBack(amPmButtonCotainerView)
        
        amPmButtonCotainerView.translatesAutoresizingMaskIntoConstraints = false
        amPmButtonCotainerView.centerXAnchor.constraint(equalTo: amPmButton.centerXAnchor).isActive = true
        amPmButtonCotainerView.centerYAnchor.constraint(equalTo: amPmButton.centerYAnchor).isActive = true
        amPmButtonCotainerView.widthAnchor.constraint(equalTo: amPmButton.widthAnchor, multiplier: 1.3).isActive = true
        amPmButtonCotainerView.heightAnchor.constraint(equalTo: amPmButton.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    private func setupDotLabel() {
        dotLabel.text = "·"
        dotLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(30))
        dotLabel.textColor = UIColor.pearlWhite.withAlphaComponent(0.75)
        
        hourView.addSubview(dotLabel)
        dotLabel.translatesAutoresizingMaskIntoConstraints = false
        dotLabel.centerYAnchor.constraint(equalTo: hourView.centerYAnchor).isActive = true
        dotLabel.leadingAnchor.constraint(equalTo: hourView.centerXAnchor, constant: -9).isActive = true
    }
    
    private func setupMinuteContainerView() {
        minuteContainerView.backgroundColor = UIColor.bone.withAlphaComponent(0.80)
        minuteContainerView.layer.cornerRadius = 20
        view.addSubview(minuteContainerView)
        
        minuteContainerView.translatesAutoresizingMaskIntoConstraints = false
        minuteContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        minuteContainerView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 5).isActive = true
        minuteContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        minuteContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        setupMinuteTableView()
        setupMinuteView()
    }
    
    private func setupMinuteTableView() {
        minuteTableView.delegate = self
        minuteTableView.dataSource = self
        minuteTableView.register(MinuteCell.self, forCellReuseIdentifier: "minuteCell")
        minuteTableView.isScrollEnabled = false
        minuteTableView.separatorStyle = .none
        minuteTableView.backgroundColor = .clear
        minuteContainerView.addSubview(minuteTableView)
        
        minuteTableView.translatesAutoresizingMaskIntoConstraints = false
        minuteTableView.topAnchor.constraint(equalTo: minuteContainerView.topAnchor).isActive = true
        minuteTableView.bottomAnchor.constraint(equalTo: minuteContainerView.bottomAnchor).isActive = true
        minuteTableView.leadingAnchor.constraint(equalTo: minuteContainerView.leadingAnchor).isActive = true
        minuteTableView.trailingAnchor.constraint(equalTo: minuteContainerView.trailingAnchor).isActive = true
    }
    
    private func setupMinuteView() {
        minuteView.backgroundColor = UIColor.mysticBlue
        minuteContainerView.addSubview(minuteView)
        
        minuteView.translatesAutoresizingMaskIntoConstraints = false
        minuteView.leadingAnchor.constraint(equalTo: minuteContainerView.leadingAnchor, constant: 1).isActive = true
        minuteView.trailingAnchor.constraint(equalTo: minuteContainerView.trailingAnchor, constant: -1).isActive = true
        minuteView.topAnchor.constraint(equalTo: minuteContainerView.topAnchor).isActive = true
        minuteView.heightAnchor.constraint(equalTo: minuteContainerView.heightAnchor, multiplier: 1/12).isActive = true
        
        setupMinuteLabel()
        setupMLabel()
        setupDotLabelM()
        setupDragLines()
    }
    
    private func setupMinuteLabel() {
        minuteLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(24))
        minuteLabel.textColor = .pearlWhite
        minuteLabel.text = "00"
        minuteView.addSubview(minuteLabel)
        
        minuteLabel.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.centerYAnchor.constraint(equalTo: minuteView.centerYAnchor).isActive = true
        minuteLabel.leadingAnchor.constraint(equalTo: minuteView.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupMLabel() {
        mLabel.font = .avenirRegular(ofSize: UIFont.scaleFont(24))
        mLabel.textColor = .pearlWhite
        mLabel.text = "m"
        minuteView.addSubview(mLabel)
        
        mLabel.translatesAutoresizingMaskIntoConstraints = false
        mLabel.leadingAnchor.constraint(equalTo: minuteLabel.trailingAnchor, constant: 10).isActive = true
        mLabel.bottomAnchor.constraint(equalTo: minuteLabel.bottomAnchor).isActive = true
    }
    
    private func setupDotLabelM() {
        dotLabelM.text = "·"
        dotLabelM.font = .avenirDemiBold(ofSize: UIFont.scaleFont(30))
        dotLabelM.textColor = UIColor.pearlWhite.withAlphaComponent(0.75)
        
        minuteView.addSubview(dotLabelM)
        dotLabelM.translatesAutoresizingMaskIntoConstraints = false
        dotLabelM.centerYAnchor.constraint(equalTo: minuteView.centerYAnchor).isActive = true
        dotLabelM.leadingAnchor.constraint(equalTo: minuteView.centerXAnchor, constant: 9).isActive = true
    }
    
    private func setupDragLines() {
        dragLinesView.tintColor = UIColor.pearlWhite.withAlphaComponent(0.80)
        minuteView.addSubview(dragLinesView)
        
        dragLinesView.translatesAutoresizingMaskIntoConstraints = false
        dragLinesView.trailingAnchor.constraint(equalTo: minuteView.trailingAnchor, constant: -19).isActive = true
        dragLinesView.centerYAnchor.constraint(equalTo: minuteView.centerYAnchor).isActive = true
        dragLinesView.heightAnchor.constraint(equalTo: minuteView.heightAnchor, multiplier: 0.7).isActive = true
    }
    
    //MARK: Actions
    @objc func gesture(gesture: UIGestureRecognizer) {
        guard let view = gesture.view else { return }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        switch view {
        case hourContainerView:
            let hourViewheight = hourView.frame.size.height
            var point = gesture.location(in: hourContainerView)
            point.x = hourView.center.x
            point.y = centeredYCoordinate(hourView: hourView, yGesture: point.y)
            point.y = min(max(point.y, hourViewheight / 2), view.frame.size.height - hourViewheight / 2)
            
            if let indexPath = hourTableView.indexPathForRow(at: point) {
                hour = amPmButton.isSelected ? indexPath.row + 13 : indexPath.row + 1
                hourLabel.text = "\(hour)"
                delegate?.timeDidSelect(hour: hour, minute: minute)
                if indexPath.row == 11 && amPmButton.isSelected {
                    hourLabel.text = "00"
                    delegate?.timeDidSelect(hour: 00, minute: minute)
                }
            }
            if SettingsValues.otherSettings[0] && round(hourView.center.y) != round(point.y) {
                generator.impactOccurred()
            }
            UIView.animate(withDuration: 0.1) {
                self.hourView.center = point
            }
        case minuteContainerView:
            let minuteViewheight = minuteView.frame.size.height
            var point = gesture.location(in: minuteContainerView)
            point.x = minuteView.center.x
            point.y = centeredYCoordinate(hourView: minuteView, yGesture: point.y)
            point.y = min(max(point.y, minuteViewheight / 2), view.frame.size.height - minuteViewheight / 2)
            
            if let indexPath = hourTableView.indexPathForRow(at: point) {
                minute = indexPath.row * 5
                minuteLabel.text = String(format: "%02lu", minute)
            }
            if SettingsValues.otherSettings[0] && round(minuteView.center.y) != round(point.y) {
                generator.impactOccurred()
            }
            delegate?.timeDidSelect(hour: nil, minute: minute)
            UIView.animate(withDuration: 0.1) {
                self.minuteView.center = point
            }
        default: break
        }
    }
    
    @objc func amPmAction() {
        let numericHour = Int(hourLabel.text!)
        if amPmButton.isSelected{
            hLabel.text = "h"
            if numericHour != 0 {
                delegate?.timeDidSelect(hour: numericHour! - 12, minute: minute)
                hourLabel.text = "\(numericHour! - 12)"
            } else {
                delegate?.timeDidSelect(hour: 12, minute: minute)
                hourLabel.text = "12"
            }
        } else {
            hLabel.text = "H"
            if numericHour != 12 {
                delegate?.timeDidSelect(hour: numericHour! + 12, minute: minute)
                hourLabel.text = "\(numericHour! + 12)"
            } else {
                delegate?.timeDidSelect(hour: 00, minute: minute)
                hourLabel.text = "00"
            }
        }
        amPmButton.isSelected = !amPmButton.isSelected
        hourTableView.reloadData()
    }
    
    func centeredYCoordinate(hourView: UIView, yGesture: CGFloat) -> CGFloat{
        var finalY = CGFloat()
        let hourHeight = hourView.frame.height
        let rowCenterHeight = hourHeight / 2
        var centerPoints = [CGFloat]()
        var accumulatedY = rowCenterHeight
        
        for _ in 0...11 {
            centerPoints.append(accumulatedY)
            accumulatedY = accumulatedY + hourHeight
        }
        
        finalY = centerPoints[0]
        
        for point in centerPoints {
            if abs(yGesture - point) < abs(finalY - yGesture) {
                finalY = point
            }
        }
        
        return finalY
    }
    
}

//MARK: Extensions
extension TimePickerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case hourTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "hourCell", for: indexPath) as! HourCell
            cell.hourLabel.text = amPmButton.isSelected ? "\(indexPath.row + 13)" : "\(indexPath.row + 1)"
            if indexPath.row == 11 && amPmButton.isSelected {
                cell.hourLabel.text = "00"
            }
            cell.backgroundColor = .clear
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "minuteCell", for: indexPath) as! MinuteCell
            cell.minuteLabel.text = String(format: "%02lu", indexPath.row * 5)
            cell.backgroundColor = .clear
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


