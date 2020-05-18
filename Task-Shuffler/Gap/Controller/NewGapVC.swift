//
//  NewGapVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 07/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class NewGapVC: UIViewController {
    
    var gapsVC: GapsViewController?
    
    //MARK: Properties
    let contentView = UIView()
    let datePicker = DatePickerVC()
    let timePicker = TimePickerVC()
    let fromDisplayTimeView = DisplayTime(text: "From")!
    let toDisplayTimeView = DisplayTime(text: "To")!
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    let dateLabel = UILabel()
    let newGap = GapRealm()
    let closeButton = UIButton()
    let nextButton = UIButton(type: .custom)
    var viewTopConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDatePicker()
        setupDateLabel()
        setupCloseButton()
        setupNextButton()
    }
    
    override func viewDidLayoutSubviews() {
        nextButton.layer.cornerRadius = nextButton.bounds.size.width / 2
        fromDisplayTimeView.fromTimeContainerView.layer.cornerRadius = fromDisplayTimeView.fromTimeContainerView.bounds.size.height / 2
        toDisplayTimeView.fromTimeContainerView.layer.cornerRadius = fromDisplayTimeView.fromTimeContainerView.bounds.size.height / 2
    }

    private func setupView() {
        view.backgroundColor = .clear
        contentView.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7725490196, blue: 0.7254901961, alpha: 0.85)
        contentView.layer.cornerRadius = 20
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        viewTopConstraint = contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: screenHeight / 3)
        viewTopConstraint.isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.clipsToBounds = true
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    private func setupDatePicker() {
        addChild(datePicker)
        
        datePicker.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker.view)
        
        datePicker.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        datePicker.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: screenHeight / 6).isActive = true
        datePicker.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        datePicker.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -screenHeight / 5).isActive = true
        
        datePicker.didMove(toParent: self)
        datePicker.delegate = self
        
    }
    
    private func setupDateLabel() {
        dateLabel.text = "Select a day"
        dateLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(30))
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        dateLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: contentView.topAnchor, multiplier: 5).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    private func setupCloseButton() {
        closeButton.setTitle("Cancel", for: .normal)
        closeButton.setTitleColor(UIColor.bone, for: .normal)
        closeButton.setTitleColor(UIColor.bone.withAlphaComponent(0.35), for: .highlighted)
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        
        closeButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        
    }
    
    private func setupNextButton() {
        nextButton.layer.shadowColor = UIColor.mysticBlue.cgColor
        nextButton.layer.shadowOffset = .init(width: 0, height: 2)
        nextButton.layer.shadowRadius = 5
        nextButton.layer.shadowOpacity = 0.7
        nextButton.backgroundColor = .bone
        nextButton.setTitleColor(UIColor.mysticBlue.withAlphaComponent(0.2), for: .normal)
        nextButton.setTitleColor(UIColor.pearlWhite.withAlphaComponent(0.2), for: .highlighted)
        nextButton.setTitle(">", for: .normal)
        nextButton.titleLabel?.font = .avenirDemiBold(ofSize: UIFont.scaleFont(25))
        
        view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        nextButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.17).isActive = true
        nextButton.widthAnchor.constraint(equalTo: self.nextButton.heightAnchor).isActive = true
        
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    private func setupTimePicker(){
        timePicker.view.alpha = 0
        addChild(timePicker)
        timePicker.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timePicker.view)
        
        timePicker.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        timePicker.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: screenHeight / 8).isActive = true
        timePicker.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        timePicker.view.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20).isActive = true
        
        timePicker.didMove(toParent: self)
        timePicker.delegate = self
        
        setupFromDisplayTimeView()
        setupToDisplayTimeView()
    }
    
    private func setupFromDisplayTimeView() {
        fromDisplayTimeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(fromDisplayTimeAction)))
        fromDisplayTimeView.alpha = 0
        view.addSubview(fromDisplayTimeView)
        
        fromDisplayTimeView.translatesAutoresizingMaskIntoConstraints = false
        fromDisplayTimeView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1.5).isActive = true
        fromDisplayTimeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        fromDisplayTimeView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 0.9).isActive = true
        fromDisplayTimeView.bottomAnchor.constraint(equalTo: timePicker.view.topAnchor, constant: -screenHeight/50).isActive = true
        fromDisplayTimeView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.04).isActive = true
        
    }
    
    private func setupToDisplayTimeView() {
        toDisplayTimeView.alpha = 0
        view.addSubview(toDisplayTimeView)
        
        toDisplayTimeView.translatesAutoresizingMaskIntoConstraints = false
        toDisplayTimeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 5).isActive = true
        toDisplayTimeView.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -screenWidth/11).isActive = true
        toDisplayTimeView.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: dateLabel.bottomAnchor, multiplier: 0.9).isActive = true
        toDisplayTimeView.bottomAnchor.constraint(equalTo: timePicker.view.topAnchor, constant: -screenHeight/50).isActive = true
        toDisplayTimeView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.04).isActive = true
        
    }
    
    // MARK: Actions
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func nextButtonAction() {
        switch nextButton.tag {
        case 0:
            if SettingsValues.otherSettings[0]{
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.error)
            }
        case 1:
            self.setupTimePicker()
            UIView.animate(withDuration: 0.3,animations: {
                self.datePicker.view.alpha = 0
                self.dateLabel.topAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: self.contentView.topAnchor, multiplier: 2).isActive = true
                self.dateLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(20))
                self.viewTopConstraint.isActive = false
                self.viewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
                self.viewTopConstraint.isActive = true
                self.view.layoutIfNeeded()
                self.timePicker.view.alpha = 1
                self.fromDisplayTimeView.alpha = 1
            },
            completion: { success in
                self.nextButton.tag = 2
            })
            
        case 2:
            let hour = Int(fromDisplayTimeView.fromHourLabel.text!)!
            let minute = Int(fromDisplayTimeView.fromMinuteLabel.text!)!
            
            let startDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: newGap.startDate)!
            if startDate < Date() {
                Alert.errorInformation(title: "Error", message: "The gap must start later than current time", vc: self, handler: nil)
            } else {
                nextButton.setTitle(">", for: .normal)
                self.toDisplayTimeView.fromHourLabel.text = self.fromDisplayTimeView.fromHourLabel.text
                self.toDisplayTimeView.fromMinuteLabel.text = self.fromDisplayTimeView.fromMinuteLabel.text
                UIView.animate(withDuration: 0.3,animations: {
                    self.toDisplayTimeView.alpha = 1
                    self.fromDisplayTimeView.fromTimeContainerView.alpha = 0
                    self.fromDisplayTimeView.alpha = 0.50
                    self.toDisplayTimeView.fromTimeContainerView.alpha = 0.8
                },
                completion: { success in
                    self.nextButton.tag = 3
                    self.nextButton.setTitle("OK", for: .normal)
                })
            }
        case 3:
            nextButton.setTitle("OK", for: .normal)
            var hour = Int(fromDisplayTimeView.fromHourLabel.text!)!
            var minute = Int(fromDisplayTimeView.fromMinuteLabel.text!)!
            newGap.startDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: newGap.startDate)!
            print(Utils.formatDate(datePattern: "E dd MMMM - HH:mm", date: newGap.startDate))
            hour = Int(toDisplayTimeView.fromHourLabel.text!)!
            minute = Int(toDisplayTimeView.fromMinuteLabel.text!)!
            newGap.endDate = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: newGap.endDate)!
            if newGap.duration < 10 {
                Alert.errorInformation(title: "Error", message: "The gap must end later than start time", vc: self, handler: nil)
            } else {
                let predicate = NSPredicate(format: "startDate < %@ AND %@ < endDate", newGap.endDate as CVarArg, newGap.startDate as CVarArg)
                let results = gapsVC?.db.getData(objectClass: GapRealm.self).filter(predicate)
                if results!.count > 0 {
                    Alert.errorInformation(title: "Error", message: "A gap of time already exists in that time", vc: self, handler: nil)
                } else {
                    gapsVC?.addNewGap(gap: newGap)
                    print("🤩 GAP Added! \(newGap.debugDescription)")
                    dismiss(animated: true, completion: nil)
                }
            }
        default:
            break
        }
        
    }
    
    @objc private func fromDisplayTimeAction () {
        switch nextButton.tag {
        case 3:
            UIView.animate(withDuration: 0.3,animations: {
                self.toDisplayTimeView.alpha = 0
                self.fromDisplayTimeView.fromTimeContainerView.alpha = 0.8
                self.fromDisplayTimeView.alpha = 1
                self.nextButton.setTitle(">", for: .normal)
            })
            let hour = Int(fromDisplayTimeView.fromHourLabel.text!)!
            let minute = Int(fromDisplayTimeView.fromMinuteLabel.text!)! / 5
            var hourRow = hour > 12 ? hour - 12 - 1 : hour - 1
            if hourRow < 0 {
                hourRow = 11
            }
            let hourCell = timePicker.hourTableView.cellForRow(at: IndexPath(row: hourRow, section: 0))
            let minuteCell = timePicker.minuteTableView.cellForRow(at: IndexPath(row: minute, section: 0))
            
            UIView.animate(withDuration: 0.1) {
                self.timePicker.hourView.center = CGPoint(x: self.timePicker.hourView.center.x, y: (hourCell?.frame.midY)!)
                self.timePicker.minuteView.center = CGPoint(x: self.timePicker.minuteView.center.x, y: (minuteCell?.frame.midY)!)
                self.timePicker.amPmAction()
                self.timePicker.hourLabel.text = hour == 0 ? "00" : "\(hour)"
                self.timePicker.minuteLabel.text = self.fromDisplayTimeView.fromMinuteLabel.text
                if hour > 12 || hour == 0 {
                    self.timePicker.amPmButton.isSelected =  true
                    self.timePicker.hLabel.text = "H"
                } else {
                    self.timePicker.amPmButton.isSelected =  false
                    self.timePicker.hLabel.text = "h"
                }
            }
            nextButton.tag = 2
            
        default:
            break
        }
    }
    
}

//MARK: Extensions
extension NewGapVC: DatePickerVCDelegate{
    func selectedDate(selectedDate: Date) {
        if nextButton.tag == 0{
            UIView.transition(with: nextButton,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { [weak self] in
                                self?.nextButton.setTitleColor(UIColor.mysticBlue.withAlphaComponent(1), for: .normal)
            })
        }
        nextButton.tag = 1
        newGap.startDate = selectedDate
        newGap.endDate = selectedDate
        print("\(Utils.formatDate(datePattern: "E dd MMMM", date: newGap.startDate))")
    }
    
    func updateDateLabel(textDate: String) {
        UIView.animate(withDuration: 0.1, animations: {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            self.dateLabel.alpha = 0
            self.dateLabel.text = textDate
            if SettingsValues.otherSettings[0] {
                generator.impactOccurred()
            }
        })
        UIView.animate(withDuration: 0.3, animations: {
            self.dateLabel.text = textDate
            self.dateLabel.alpha = 1
        })
    }
    
    
}

extension NewGapVC: TimePickerVCDelegate {
    func timeDidSelect(hour: Int?, minute: Int?) {
        if hour != nil{
            if nextButton.tag == 2{
                fromDisplayTimeView.fromHourLabel.text = String(format: "%02lu", hour!)
            } else {
                toDisplayTimeView.fromHourLabel.text = String(format: "%02lu", hour!)
            }
        }
        if nextButton.tag == 2 {
            fromDisplayTimeView.fromMinuteLabel.text = String(format: "%02lu", minute!)
        } else {
            toDisplayTimeView.fromMinuteLabel.text = String(format: "%02lu", minute!)
        }
    }
    
}
