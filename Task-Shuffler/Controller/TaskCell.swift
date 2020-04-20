//
//  TaskCell.swift
//  Task-Shuffler
//
//  Created by Juanjo Valiño on 20/04/2020.
//  Copyright © 2020 Juanjo Valiño. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priorityImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
