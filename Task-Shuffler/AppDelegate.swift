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
        
        //MARK: AMTabView Customization
        // Customize the colors
        AMTabView.settings.ballColor = .fireOrange
        AMTabView.settings.tabColor = .mysticBlue
        AMTabView.settings.selectedTabTintColor = .pearlWhite
        AMTabView.settings.unSelectedTabTintColor = .pearlWhite

        // Change the animation duration
        AMTabView.settings.animationDuration = 0.7
        
    
        self.window!.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

