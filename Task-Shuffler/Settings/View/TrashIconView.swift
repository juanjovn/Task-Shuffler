//
//  TrashIconView.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 1/2/21.
//  Copyright © 2021 Juanjo Valiño. All rights reserved.
//

import UIKit

class TrashIconView: UIImageView {

    override init(frame: CGRect) {
        super.init(image: UIImage(systemName: "trash"))
        
        tintColor = UIColor.pearlWhite.withAlphaComponent(0.60)
        contentMode = .scaleAspectFill
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
