//
//  NewTaskViewController.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 27/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView
import SkyFloatingLabelTextField
import fluid_slider
import WCLShineButton
import EasyTipView

class NewTaskViewController: UIViewController {
    
    deinit {
        //print("⚠️ DEINIT NEWTASKVC ⚠️")
    }
    
    var taskListVC: TasksListViewController?
    
    // MARK: Buttons
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var priorityButton: WCLShineButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: TextFields
    
    @IBOutlet weak var newTaskTextName: SkyFloatingLabelTextField!
    
    // MARK: Labels
    
    @IBOutlet weak var maxLengthLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priorityLabel: UILabel!
    
    // MARK: Views
    
    @IBOutlet weak var priorityButtonBackgroundView: UIView!
    
    // MARK: Constraints
    
    @IBOutlet weak var priorityButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var priorityButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var priorityButtonCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var priorityButtonCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var priorityButtonBackgroundTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var priorityLabelTopConstraint: NSLayoutConstraint!
    var sliderHeightConstraint = NSLayoutConstraint()
    var sliderValue = 0
    
    
    // MARK: Constants
    
    let db = DatabaseManager()
    let maxTextFieldLength = 39
    let step: Float = 5
    let priorityButtomImages = [
        UIImage(named: "exc_mark_low"),
        UIImage(named: "exc_mark_med"),
        UIImage(named: "exc_mark_high")
    ]
    var tipView = EasyTipView?(nilLiteral: ())
    
    // MARK: Variables
    
    var priorityButtonImageIndex: Int = 0
    var priorityButtonImage = UIImage()
    var taskPriority = Priority.low
    var selectedRow: IndexPath = []
    
    // MARK: Slider
    let slider = Slider()
    let sliderLabelAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.avenirMedium(ofSize: 20),
        .foregroundColor: UIColor.pearlWhite
    ]
    var sliderNobLabelAttributes: [NSAttributedString.Key: Any] = [:]
    
    // MARK: Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
    }
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gestures recognizers
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        let tapGesturePriorityButton = UITapGestureRecognizer(target: self, action: #selector(self.priorityButtonClicked (_:)))
        self.priorityButton.addGestureRecognizer(tapGesturePriorityButton)
        
        // Delegates
        
        newTaskTextName.delegate = self
        
        // View style
        view.backgroundColor = .fireOrange

        // Back button style
        confBackButtonStyle()
        
        // Slider
        addSlider()
        slider.isHidden = true
        slider.alpha = 0
        
        // Labels
        durationLabel.isHidden = true
        durationLabel.alpha = 0
        priorityLabel.isHidden = true
        priorityLabel.alpha = 0
        
        // Priority button
        addPriorityButton()
        priorityButton.isHidden = true
        priorityButton.alpha = 0
        priorityButtonBackgroundView.alpha = 0
        
        // Text Field
        newTaskTextName.placeholder = "New task name".localized()
        newTaskTextName.selectedTitle = "Task name".localized()
        newTaskTextName.autocapitalizationType = .sentences
        if !taskListVC!.isTaskEditing {
            newTaskTextName.becomeFirstResponder()
        }
        
        
        // Responsive resize
        setupForScreenSize()
    }
    
    // MARK: viewWillLayoutSubviews
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        priorityButton.fitLayers()
    }
    
    // MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        if let taskEditing = taskListVC?.isTaskEditing {
            if taskEditing{
                 configureEditingForm()
            }
        }
    }
    
    // MARK: viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        priorityButtonBackgroundView.layer.cornerRadius = priorityButtonBackgroundView.bounds.size.width/2
    }
    
    // MARK: Actions
    
    @IBAction func closeView(_ sender: Any) {
        var newTask : Task
        if backButton.titleLabel?.text == "OK"{
            let taskRealm = TaskRealm()
            taskRealm.name = newTaskTextName.text!
            taskRealm.duration = Int(slider.attributedTextForFraction(slider.fraction).string)!
            taskRealm.priority = taskPriority.rawValue
        
            
            newTask = Task(id: taskRealm.id, name: taskRealm.name, duration: taskRealm.duration, priority: taskPriority, state: .pending, gapid: "")
            if taskListVC!.isTaskEditing {
                newTask.id = taskListVC!.pendingTasks[selectedRow.row].id
                taskListVC?.replaceTask(task: newTask, position: selectedRow.row)
            } else {
                taskListVC?.addNewTask(task: newTask)
                db.addData(object: taskRealm)
            }
        }
        
        taskListVC?.isTaskEditing = false
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelView(_ sender: Any) {
        taskListVC?.isTaskEditing = false
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sliderValueChanged(_ sender: UIControl){
        
        if let tipView = tipView {
            tipView.dismiss()
        }
        
        let fractionValue = slider.fraction
        let value: Float = Float(fractionValue * (180 - 10))
        let resultValue: Int = 10 + roundTo(n: value, mult: 5)
        let nobShadow = NSShadow()
        nobShadow.shadowOffset = .init(width: 0, height: 1)
        
        let attributedString = NSAttributedString(string: String(resultValue), attributes: sliderNobLabelAttributes)
        
        slider.attributedTextForFraction = { fractionValue in
            return attributedString
        }
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        if SettingsValues.otherSettings[0] {
            if sliderValue != resultValue {
                generator.impactOccurred()
            }
        }
        
        sliderValue = resultValue
        
        if cancelButton.isHidden == true {
            if let taskListVC = taskListVC {
                if taskListVC.isTaskEditing {
                    cancelButton.isHidden = false
                }
            }
        }
        
    }
    
    @objc func dismissKeyboard (_ sender: Any) {
        newTaskTextName.endEditing(true)
        if let taskText = newTaskTextName.text{
            if taskText.count > 0 {
                showForm()
            }
            else{
                UIView.animate(withDuration: 0.5) {self.priorityLabel.alpha = 0}
                UIView.animate(withDuration: 0.5) {
                    self.priorityButton.alpha = 0
                    self.priorityButtonBackgroundView.alpha = 0
                }
                UIView.animate(withDuration: 0.5) {self.durationLabel.alpha = 0}
                UIView.animate(withDuration: 0.5) {self.slider.alpha = 0}
                
                _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {_ in
                    self.durationLabel.isHidden = true
                    self.slider.isHidden = true
                    self.priorityLabel.isHidden = true
                    self.priorityButton.isHidden = true
                    self.priorityButtonBackgroundView.isHidden = true
                }
                
                
                
            }
        }
    }
    
    @objc func priorityButtonClicked(_ sender: WCLShineButton){

        priorityButton.setClicked(!priorityButton.isSelected, animated: true)
        priorityButton.isSelected = false
        priorityButton.setClicked(true)
        priorityButtonImageIndex += 1
        
        if priorityButtonImageIndex > 2 {
            priorityButtonImageIndex = 0
        }
        
        priorityButtonImage = priorityButtomImages[priorityButtonImageIndex]!
        priorityButtonImage = customizePriorityButtonImage(buttonImage: priorityButtonImage)
        priorityButton.image = .defaultAndSelect(priorityButtonImage, priorityButtonImage)
        
        fromButtonToPriority()
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        if SettingsValues.otherSettings[0] {
                generator.impactOccurred()
        }
        
        if let taskListVC = taskListVC {
            if taskListVC.isTaskEditing {
                cancelButton.isHidden = false
            }
        }
    }
    
    
    
    
    // MARK: Functions
    
    private func fromButtonToPriority(){
        switch priorityButtonImageIndex {
            case 0:
                taskPriority = .low
            case 1:
                taskPriority = .medium
            case 2:
                taskPriority = .high
        default:
            taskPriority = .low
        }
    }
    
    func showForm() {
        self.durationLabel.isHidden = false
        self.slider.isHidden = false
        self.priorityLabel.isHidden = false
        self.priorityButton.isHidden = false
        self.priorityButtonBackgroundView.isHidden = false
        backButton.setTitle("OK", for: .normal)
        UIView.animate(withDuration: 0.3) {self.durationLabel.alpha = 1}
        UIView.animate(withDuration: 0.3) {self.slider.alpha = 1}
        _ = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {_ in
            UIView.animate(withDuration: 0.3) {self.priorityLabel.alpha = 1}
            UIView.animate(withDuration: 0.3, animations:  { self.priorityButton.alpha = 1
                self.priorityButtonBackgroundView.alpha = 1
            }, completion: {_ in
                if let firstTimeHere = SettingsValues.firstTime["newTask"] {
                    if firstTimeHere {
                        self.tipView = Onboard.instance.presentNewTaskTips(on: self)
                        SettingsValues.firstTime["newTask"] = false
                        SettingsValues.storeSettings()
                    }
                }
            })
        }
    }
    
    func confBackButtonStyle(){
        backButton.layer.cornerRadius = backButton.bounds.size.width/2
        backButton.layer.shadowOffset = .init(width: 0, height: 1)
        backButton.backgroundColor = .pearlWhite
        backButton.setTitleColor(.mysticBlue, for: .normal)
        backButton.setTitle("<", for: .normal)
    }
    
    func addSlider() {
        var nobText = ""
        // Nob
        let nobShadow = NSShadow()
        nobShadow.shadowOffset = .init(width: 0, height: 1)
        
        sliderNobLabelAttributes = [
            .font: UIFont.avenirMedium(ofSize: 20),
            .foregroundColor: UIColor.mysticBlue,
            .shadow: nobShadow
        ]
        
        // Fraction
        slider.attributedTextForFraction = { [unowned self] fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            var string = formatter.string(from: 10 + (fraction * (180 - 10)) as NSNumber) ?? ""
            if self.taskListVC!.isTaskEditing {
                string = "\(self.taskListVC?.pendingTasks[self.selectedRow.row].duration ?? 0)"
                nobText = string
            }
            let attributedString = NSAttributedString(string: string, attributes: self.sliderNobLabelAttributes)
            return attributedString
        }
        
        slider.setMinimumLabelAttributedText(NSAttributedString(string: "10", attributes: sliderLabelAttributes))
        slider.setMaximumLabelAttributedText(NSAttributedString(string: "180", attributes: sliderLabelAttributes))
        slider.fraction = 0.295
        if self.taskListVC!.isTaskEditing {
            slider.fraction = fromValueToFractionSlider(value: nobText)
        }
        slider.shadowOffset = CGSize(width: 0, height: 10)
        slider.shadowBlur = 5
        slider.shadowColor = UIColor(white: 0, alpha: 0.1)
        slider.contentViewColor = .mysticBlue
        slider.valueViewColor = .pearlWhite
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.didBeginTracking = { [unowned self] _ in
            
            let animationDisappear = {
                self.durationLabel.alpha = 0
            }
            
            self.newTaskTextName.endEditing(true)
            UIView.animate(withDuration: 0.11, animations: animationDisappear)
        }
        
        slider.didEndTracking = { [unowned self] _ in
            
            let animationAppear = {
                self.durationLabel.alpha = 1
            }
            
            UIView.animate(withDuration: 0.11, animations: animationAppear)
        }
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)
        slider.topAnchor.constraint(equalToSystemSpacingBelow: durationLabel.bottomAnchor, multiplier: 1.5).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        sliderHeightConstraint = slider.heightAnchor.constraint(equalToConstant: 60)
        sliderHeightConstraint.isActive = true
        
    }
    
    
    private func roundTo(n: Float, mult: Int) -> Int{
        let result: Float = n / Float(mult)
        return Int(result.rounded()) * mult
    }
    
    private func fromValueToFractionSlider (value: String) -> (CGFloat) {
        let num = CGFloat(Double(value) ?? 0)
        
        return (num - 10) / 170
    }
    
    func addPriorityButton() {
        if let vc = taskListVC {
            if vc.isTaskEditing {
                switch vc.pendingTasks[selectedRow.row].priority {
                case .low:
                    priorityButtonImageIndex = 0
                case .medium:
                    priorityButtonImageIndex = 1
                case .high:
                    priorityButtonImageIndex = 2
                }
                
                fromButtonToPriority()
            }
        } else {
            print("Missing Task List View Controller")
        }
        priorityButtonImage = priorityButtomImages[priorityButtonImageIndex]!
        var param1 = WCLShineParams()
        param1.animDuration = 0.8
        param1.allowRandomColor = true
        priorityButton.params = param1
        priorityButtonImage = customizePriorityButtonImage(buttonImage: priorityButtonImage)
        priorityButton.image = .defaultAndSelect(priorityButtonImage, priorityButtonImage)
        
        
        // Circular background of the priority exlamation mark button
        priorityButtonBackgroundView.layer.shadowOpacity = 0.1
        priorityButtonBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 10)
        priorityButtonBackgroundView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        priorityButtonBackgroundView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9529411765, alpha: 1)
    }
    
    func customizePriorityButtonImage(buttonImage: UIImage) -> UIImage{
        var tintColor = UIColor()

        switch priorityButtonImageIndex {
        case 0:
            tintColor = .powerGreen
        case 1:
            tintColor = .mysticBlue
        case 2:
            tintColor = .fireOrange
        default:
            tintColor = .mysticBlue
        }

        guard var customizedImage = buttonImage.tinted(color: tintColor) else {
            print("Tinted button returned nil Image")
            return buttonImage
        }
        
        //Add button shadow
        
        customizedImage = customizedImage.addingShadow(blur: 5, shadowColor: UIColor(white: 0, alpha: 0.1), offset: CGSize(width: 0, height: 10))

        return customizedImage
    }
    
    func setupForScreenSize(){
        let deviceType = UIDevice().type
        
        func setupLabels(){
            durationLabel.font = durationLabel.font.withSize(25)
            priorityLabel.font = priorityLabel.font.withSize(25)
        }
        
        func setupSlider(){
            sliderHeightConstraint.isActive = false
            sliderHeightConstraint = slider.heightAnchor.constraint(equalToConstant: 40)
            sliderHeightConstraint.isActive = true
            
            
            let fractionValue = slider.fraction
            let value: Float = Float(fractionValue * (180 - 10))
            let resultValue: Int = 10 + roundTo(n: value, mult: 5)
            
            sliderNobLabelAttributes[.font] = UIFont.avenirMedium(ofSize: 16)
            let attributedString = NSAttributedString(string: String(resultValue), attributes: sliderNobLabelAttributes)
            slider.attributedTextForFraction = { fractionValue in
                return attributedString
            }
            
            // Just for trigger the function updateValueViewText() inside Slider
            slider.fraction = slider.fraction
        }
        
        func setupPriorityButtonBackground(){
            priorityButtonBackgroundTopConstraint.constant = -30
        }
        
        func setupPriorityLabel(){
            
            priorityLabelTopConstraint.constant = -15
            
        }
        
        switch deviceType {
            
        case .iPhoneSE:
            print("IPHONE SE DETECTED. CALLING FUNCTIONS.")
            setupLabels()
            setupSlider()
            setupPriorityButtonBackground()
            setupPriorityLabel()
        default:
            break
            
        }
        
        
    }
    
    func configureEditingForm() {
        newTaskTextName.text = taskListVC?.pendingTasks[selectedRow.row].name
        showForm()
    }

}

//MARK: Extensions

extension NewTaskViewController: TabItem{
    
    var tabImage: UIImage? {
        return UIImage(named: "task_icon")
    }
    
}

extension NewTaskViewController: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = maxTextFieldLength
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
        currentString.replacingCharacters(in: range, with: string) as NSString
        if newString.length > maxTextFieldLength{
            //let textValue = self.newTaskTextName.text
            
            UIView.animate(withDuration: 0.5) {
                self.newTaskTextName.errorMessage = "MAX LENGTH"
                self.newTaskTextName.selectedLineHeight = 5
                self.newTaskTextName.errorMessage = ""
                self.maxLengthLabel.alpha = 1
            }
            
            UIView.animate(withDuration: 0.5, delay: 0.1) {
                self.newTaskTextName.selectedLineHeight = 2
                self.newTaskTextName.errorMessage = ""
                self.maxLengthLabel.alpha = 0
            }
            
        }
        else {
            newTaskTextName.errorMessage = ""
        }
        
        if newString.length > 0 {
            //backButton.setTitle("OK", for: .normal)
            cancelButton.isHidden = false
        }
        else {
            backButton.setTitle("<", for: .normal)
            cancelButton.isHidden = true
        }
        return newString.length <= maxLength
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.dismissKeyboard(textField)
        return true
    }
}
