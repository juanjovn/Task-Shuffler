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
            return .systemFont(ofSize: size)
        }
    }
    
    static func avenirDemiBold(ofSize size: CGFloat) -> UIFont {
        if let font = UIFont(name: "AvenirNext-DemiBold", size: size){
            return font
        } else {
            return .systemFont(ofSize: size)
        }
    }
    
}
