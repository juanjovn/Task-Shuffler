//
//  NewGapVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 07/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class NewGapVC: UIViewController {
    
    //MARK: Properties
    let contentView = UIView()
    let datePicker = DatePickerVC()
    let timePicker = TimePickerVC()
    let screenHeight = UIScreen.main.bounds.height
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
        nextButton.setTitleColor(.mysticBlue, for: .normal)
        nextButton.setTitleColor(UIColor.pearlWhite.withAlphaComponent(0.2), for: .highlighted)
        nextButton.setTitle(">", for: .normal)
        nextButton.titleLabel?.font = .avenirDemiBold(ofSize: UIFont.scaleFont(25))
        
        view.addSubview(nextButton)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalToSystemSpacingBelow: datePicker.view.bottomAnchor, multiplier: 3.25).isActive = true
        nextButton.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.17).isActive = true
        nextButton.widthAnchor.constraint(equalTo: self.nextButton.heightAnchor).isActive = true
        
        nextButton.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
    }
    
    private func setupTimePicker(){
        addChild(timePicker)
        timePicker.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timePicker.view)
        
        timePicker.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        timePicker.view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: screenHeight / 8).isActive = true
        timePicker.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        timePicker.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -screenHeight / 5.5).isActive = true
        
        timePicker.didMove(toParent: self)
        //timePicker.delegate = self
    }
    
    // MARK: Actions
    @objc private func cancelButtonAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func nextButtonAction() {
        UIView.animate(withDuration: 0.3,animations: {
            self.datePicker.view.alpha = 0
            self.dateLabel.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: self.contentView.topAnchor, multiplier: 2).isActive = true
            self.dateLabel.font = .avenirDemiBold(ofSize: UIFont.scaleFont(25))
            self.viewTopConstraint.isActive = false
            self.viewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            self.viewTopConstraint.isActive = true
            self.view.layoutIfNeeded()
        },
        completion: {
            sucess in
                self.setupTimePicker()
        })
    }
    
}

//MARK: Extensions
extension NewGapVC: DatePickerVCDelegate{
    func selectedDate(selectedDate: Date) {
        newGap.startDate = selectedDate
        newGap.endDate = selectedDate
        print("\(Utils.formatDate(datePattern: "E dd MMMM", date: newGap.startDate))")
    }
    
    func updateDateLabel(textDate: String) {
        UIView.animate(withDuration: 0.1, animations: {
            self.dateLabel.alpha = 0
            self.dateLabel.text = textDate
        })
        UIView.animate(withDuration: 0.3, animations: {
            self.dateLabel.text = textDate
            self.dateLabel.alpha = 1
        })
    }
    
    
}
