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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        setupTableView()
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
    
    @objc func switchAction (sender: MySettingsSwitch){
        let indexPath = sender.indexPath
        let row = indexPath?.row ?? 0
        switch indexPath?.section{
        case 0:
            SettingsValues.taskSettings[row] = !SettingsValues.taskSettings[row]
            print(SettingsValues.taskSettings[row])
        case 1:
            SettingsValues.notificationsSettings[row] = !SettingsValues.notificationsSettings[row]
            print(SettingsValues.notificationsSettings[row])
        case 2:
            SettingsValues.otherSettings[row] = !SettingsValues.otherSettings[row]
            print(SettingsValues.otherSettings[row])
            
        default:
            break
        }
        
        SettingsValues.storeSettings()
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
            cell.accessoryView = nil
            cell.textLabel?.text = creditsSection[indexPath.row]
        case 5:
            cell.accessoryView = nil
            cell.backgroundColor = .clear
            let imageView = UIImageView(image: UIImage(named: "easter")?.withTintColor(UIColor.pearlWhite.withAlphaComponent(0.2)))
            imageView.contentMode = .scaleAspectFit
            
            cell.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: Utils.screenHeight / 12).isActive = true
            //imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            
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
}

class MySettingsSwitch: UISwitch {
    var indexPath: IndexPath?
}


