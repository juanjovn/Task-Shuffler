//
//  Alert.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 03/05/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

enum Alert {
    static func confirmation(title: String, message: String?, vc: UIViewController, handler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: handler)
        let cancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        vc.present(alert, animated: true)
    }
    
    static func errorInformation(title: String, message: String?, vc: UIViewController, handler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: handler)
        alert.addAction(ok)
        
        vc.present(alert, animated: true)
    }
    
}

//, confirmationCode: () -> ((UIAlertAction) -> Void)?
