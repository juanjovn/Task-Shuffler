//
//  SettingsVC.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 01/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Constants
    let taskSection =   [ "Mark completed when time ends",
                          "Delete confirmation", "One task per gap"]
    let notificationsSection =  [ "Notify task starts",
                                  "Notify task ends"]
    let othersSection = ["Haptic feedback"]
    let resetSection = ["Factory reset"]
    let creditsSection = ["Credits"]
    
    //Variables
    var isEasterOpen = false
    var easterCount = 3
    var easterIndex = IndexPath()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        setupTableView()
    }
    
    
    @objc private func easterAction() {
        
        //Easter egg is not discovered yet
        if !SettingsValues.easterEgg {
            
            //Haptic handling
            if SettingsValues.otherSettings[0] {
                var generator = UIImpactFeedbackGenerator(style: .light)
                switch easterCount {
                case 3:
                    generator = UIImpactFeedbackGenerator(style: .light)
                case 2:
                    generator = UIImpactFeedbackGenerator(style: .medium)
                case 1:
                    generator = UIImpactFeedbackGenerator(style: .rigid)
                default:
                    generator = UIImpactFeedbackGenerator(style: .light)
                }
                generator.impactOccurred()
            }
            
            let easterCell = tableView.cellForRow(at: easterIndex) as! EasterCell
            let eggColorRGBA = easterCell.easterImageView.tintColor.rgba
            let eggAlpha = eggColorRGBA.3
            
            //        if easterCount > 0 {
            //            UIView.animate(withDuration: 0.05, animations: {
            //                easterCell.easterImageView.transform = CGAffineTransform(rotationAngle: 0.261799)
            //            }, completion: {_ in
            //                UIView.animate(withDuration: 0.05){
            //                    easterCell.easterImageView.transform = .identity
            //                }
            //            })
            //
            //            easterCell.easterImageView.tintColor = UIColor.pearlWhite.withAlphaComponent(eggAlpha + 0.26)
            //        }
            
            if easterCount > 0 {
                UIView.animate(withDuration: 0.07, animations: {
                    easterCell.easterImageView.tintColor = UIColor.pearlWhite.withAlphaComponent(eggAlpha + 0.26)
                    //left or right inclination
                    if self.easterCount % 2 == 0 {
                        easterCell.easterImageView.transform = CGAffineTransform(rotationAngle: -0.261799)
                    } else {
                        easterCell.easterImageView.transform = CGAffineTransform(rotationAngle: 0.261799)
                    }
                }, completion: {_ in
                    UIView.animate(withDuration: 0.1, animations: {
                        easterCell.easterImageView.transform = .identity
                    })
                })
                
            }
            easterCount -= 1
            if easterCount == 0 {
                easterCell.easterImageView.tintColor = UIColor.pearlWhite.withAlphaComponent(1)
                //easterCell.eggContainerView.isUserInteractionEnabled = false
                
                isEasterOpen = true
                SettingsValues.easterEgg = isEasterOpen
                SettingsValues.storeSettings()
                //print("LANZAR PANTALLA")
                present(EasterEggVC(), animated: true, completion: nil)
            }
            
            //print("tocado, contador = \(easterCount)")
        } else {
            if SettingsValues.otherSettings[0] {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
            //print("Easter egg esta descubierto. Abrir pantalla directamente.")
            present(EasterEggVC(), animated: true, completion: nil)
        }
        
        
    }
    
    private func setupView(){
        title = "Settings"
        view.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.7725490196, blue: 0.7254901961, alpha: 0.85)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        blurEffectView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        blurEffectView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
    }
    
    private func setupNavigationBar(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeModalView))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAction))
        
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
    }
    
    @objc func closeModalView(){
        dismiss(animated: true)
    }
    
    @objc func shareAction() {
        if let appUrl = URL(string: "https://itunes.apple.com/us/app/tallycounter/id1507818665") {
            let items:[Any] = [appUrl]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
        }
    }
    
    @objc func switchAction (sender: MySettingsSwitch){
        let indexPath = sender.indexPath
        let row = indexPath?.row ?? 0
        switch indexPath?.section{
        case 0:
            SettingsValues.taskSettings[row] = !SettingsValues.taskSettings[row]
        //print(SettingsValues.taskSettings[row])
        case 1:
            SettingsValues.notificationsSettings[row] = !SettingsValues.notificationsSettings[row]
            if !SettingsValues.notificationsSettings[row] {
                NotificationManager.instance.removeAllTypeNotifications()
            }
            NotificationManager.instance.scheduleMultipleTasksNotifications(for: TaskManager.populateTasks(state: .assigned))
            
        //print(SettingsValues.notificationsSettings[row])
        case 2:
            SettingsValues.otherSettings[row] = !SettingsValues.otherSettings[row]
        //print(SettingsValues.otherSettings[row])
        
        default:
            break
        }
        
        SettingsValues.storeSettings()
    }
    
    @objc func twitterAction() {
        if let url = URL(string: "https://twitter.com/juanjovn") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func instagramAction() {
        if let url = URL(string: "https://www.instagram.com/juanjovn/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @objc func mailAction() {
        let mailVC = MailController()
        
        addChild(mailVC)
        mailVC.didMove(toParent: self)
        mailVC.sendEmail()
        
    }
    
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return taskSection.count
        case 1:
            return notificationsSection.count
        case 2:
            return othersSection.count
        case 3:
            return resetSection.count
        case 4:
            return creditsSection.count
        case 5:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let easterCell = EasterCell()
        let mySwitch = MySettingsSwitch()
        mySwitch.indexPath = indexPath
        mySwitch.addTarget(self, action: #selector(switchAction(sender:)), for: .touchUpInside)
        mySwitch.onTintColor = .powerGreen
        cell.accessoryView = mySwitch
        cell.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9529411765, alpha: 0.85)
        cell.textLabel?.font = .avenirMedium(ofSize: UIFont.scaleFont(18))
        switch indexPath.section {
        case 0:
            mySwitch.setOn(SettingsValues.taskSettings[indexPath.row], animated: false)
            cell.textLabel?.text = taskSection[indexPath.row]
        case 1:
            mySwitch.setOn(SettingsValues.notificationsSettings[indexPath.row], animated: false)
            cell.textLabel?.text = notificationsSection[indexPath.row]
        case 2:
            mySwitch.setOn(SettingsValues.otherSettings[indexPath.row], animated: false)
            cell.textLabel?.text = othersSection[indexPath.row]
        case 3:
            cell.textLabel?.text = resetSection[indexPath.row]
            cell.accessoryView = nil
        case 4:
            let creditsCell = CreditsCell()
            creditsCell.twitterButton.setImage(UIImage(named: "twitter_icon"), for: .normal)
            creditsCell.twitterButton.addTarget(self, action: #selector(twitterAction), for: .touchUpInside)
            creditsCell.instagramButton.setImage(UIImage(named: "instagram_icon"), for: .normal)
            creditsCell.instagramButton.addTarget(self, action: #selector(instagramAction), for: .touchUpInside)
            creditsCell.mailButton.setImage(UIImage(named: "mail_icon"), for: .normal)
            creditsCell.mailButton.addTarget(self, action: #selector(mailAction), for: .touchUpInside)
            
            return creditsCell
        case 5:
            easterIndex = indexPath
            //Gesture recognizer
            let tapGestureEaster = UITapGestureRecognizer(target: self, action: #selector(easterAction))
            easterCell.eggContainerView.addGestureRecognizer(tapGestureEaster)
            if SettingsValues.easterEgg {
                easterCell.easterImageView.tintColor = UIColor.pearlWhite
            } else {
                easterCell.easterImageView.tintColor = UIColor.pearlWhite.withAlphaComponent(0.2)
            }
            
            return easterCell
            
        default:
            return cell
        }
        
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 3 || indexPath.section == 4 {
            return true
        } else {
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 3: //Factory reset
            let modalVC = FactoryResetVC()
            present(modalVC, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == tableView.numberOfSections - 1 {
            return 1
        } else if section == tableView.numberOfSections - 2 {
            return 20
        } else if section == 0{
            //return UITableView.automaticDimension
            return 15
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == tableView.numberOfSections - 2 {
            return "Developed by Juanjo Valiño"
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        let title = "Developed by Juanjo Valiño"
        header.textLabel?.font = .avenirRegular(ofSize: UIFont.scaleFont(13))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let text = title.withBoldText(text: "Juanjo Valiño")
        text.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: title.count))
        
        header.textLabel?.attributedText = text
    }
}

class MySettingsSwitch: UISwitch {
    var indexPath: IndexPath?
}


