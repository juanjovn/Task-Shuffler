//
//  CustomFonts.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 06/04/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

extension UIFont {
    
    static func avenirMedium(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "AvenirNext-Medium", size: size){
            return font
        } else {
            print("😕 SYSTEM FONT rather than MEDIUM")
            return .systemFont(ofSize: size)
        }
    }
    
    static func avenirDemiBold(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "AvenirNext-DemiBold", size: size){
            return font
        } else {
            print("😕 SYSTEM FONT rather than DEMIBOLD")
            return .systemFont(ofSize: size)
        }
    }
    
    static func scaleFont(_ size: CGFloat) -> CGFloat{
        if (UIScreen.main.bounds.width != 375){
            let scaleFactor = UIScreen.main.bounds.width / 375
            return CGFloat(size * scaleFactor)
        } else {
            return size
        }
    }
    
}
