//
//  AppDelegate.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 25/02/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit
import AMTabView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //DEBUG/////////////////
        //createTestTasks()
        //factoryResetWithTestTasks()
        //SettingsValues.resetEasterEgg()
        //resetReviewRequestCounter()
        //Utils.printLocale()
        //DEBUG/////////////////
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController")
        
        // MARK: UserDefaults
        if SettingsValues.isKeyPresentInUserDefaults(key: "taskSettings"){
            SettingsValues.loadSettings()
            SettingsValues.storeSettings()
        } else {
            SettingsValues.storeSettings()
        }
        
        
        //MARK: AMTabView Customization
        // Customize the colors
        AMTabView.settings.ballColor = .fireOrange
        AMTabView.settings.tabColor = .mysticBlue
        AMTabView.settings.selectedTabTintColor = .pearlWhite
        AMTabView.settings.unSelectedTabTintColor = .pearlWhite

        // Change the animation duration
        AMTabView.settings.animationDuration = 0.7
        
        // Navigation Bar Appearance
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .mysticBlue
            appearance.titleTextAttributes = [.foregroundColor: UIColor.pearlWhite, .font: UIFont.avenirMedium(ofSize: 20)]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.pearlWhite, .font: UIFont.avenirDemiBold(ofSize: 35)]

            UINavigationBar.appearance().tintColor = UIColor.pearlWhite
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .pearlWhite
            UINavigationBar.appearance().barTintColor = .mysticBlue
            
        }
        
        //MARK: Notification permission request
        NotificationManager.instance.notificationPermissionRequest()
        
    
        let onboarding = OnboardingVC()
        if let firstTime = SettingsValues.firstTime["app"] {
            if firstTime {
                self.window!.rootViewController = onboarding
            } else {
                self.window!.rootViewController = vc
            }
        }
        
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        //Remove notification badge
        UIApplication.shared.applicationIconBadgeNumber = 0
        GapManager.instance.refreshOutdated()
        NotificationCenter.default.post(name: .didModifiedData, object: nil)
        //print ("BECOMES ACTIVE TRIGGERED")
    }

}

extension AppDelegate {
    
    private func resetTasks() {
        let db = DatabaseManager()
        db.resetAllAssignments()
    }
    
    private func factoryResetWithTestTasks() {
        let db = DatabaseManager()
        db.eraseAll()
        createTestTasks()
    }
    
    private func resetReviewRequestCounter() {
        let reviewManager = ReviewManager()
        reviewManager.reset(.easter)
        reviewManager.reset(.launchApp)
        reviewManager.reset(.shuffle)
    }
    
    private func createTestTasks() {
        let db = DatabaseManager()
        let task1 = TaskRealm()
        let task2 = TaskRealm()
        let task3 = TaskRealm()
        let task4 = TaskRealm()
        let task5 = TaskRealm()
        let task6 = TaskRealm()
        let task7 = TaskRealm()
        let task8 = TaskRealm()
        let task9 = TaskRealm()
        let task10 = TaskRealm()
        var tasks = [TaskRealm]()
        task1.name = "Ordenar el armario"
        task1.duration = 90
        task1.priority = Priority.low.rawValue
        tasks.append(task1)
        
        task2.name = "Presión ruedas moto"
        task2.duration = 20
        task2.priority = Priority.medium.rawValue
        tasks.append(task2)
        
        task3.name = "Cortar uñas de los gatos"
        task3.duration = 15
        task3.priority = Priority.medium.rawValue
        tasks.append(task3)
        
        task4.name = "Gestionar domiciliaciones"
        task4.duration = 120
        task4.priority = Priority.high.rawValue
        tasks.append(task4)
        
        task5.name = "Tarea corta mínima"
        task5.duration = 10
        task5.priority = Priority.low.rawValue
        tasks.append(task5)
        
        task6.name = "Tarea larga máxima"
        task6.duration = 180
        task6.priority = Priority.low.rawValue
        tasks.append(task6)
        
        task7.name = "Ejercicio"
        task7.duration = 45
        task7.priority = Priority.low.rawValue
        tasks.append(task7)
        
        task8.name = "Nombre de tarea muy largo ocupando todo"
        task8.duration = 180
        task8.priority = Priority.high.rawValue
        tasks.append(task8)
        
        task9.name = "Estudiar swift"
        task9.duration = 60
        task9.priority = Priority.low.rawValue
        tasks.append(task9)
        
        task10.name = "Llamar a casa"
        task10.duration = 40
        task10.priority = Priority.medium.rawValue
        tasks.append(task10)
        
        for task in tasks {
            db.addData(object: task)
        }
    }
}

