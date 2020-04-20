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
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ViewController")
        
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
            UINavigationBar.appearance().isTranslucent = false
        }
        
    
        self.window!.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

}

