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
        AMTabView.settings.ballColor = #colorLiteral(red: 0.9137254902, green: 0.3098039216, blue: 0.2156862745, alpha: 1)
        AMTabView.settings.tabColor = #colorLiteral(red: 0.1333333333, green: 0.2196078431, blue: 0.262745098, alpha: 1)
        AMTabView.settings.selectedTabTintColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9529411765, alpha: 1)
        AMTabView.settings.unSelectedTabTintColor = #colorLiteral(red: 0.937254902, green: 0.9450980392, blue: 0.9529411765, alpha: 1)

        // Change the animation duration
        AMTabView.settings.animationDuration = 0.7
        
    
        self.window!.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        return true
    }

}

