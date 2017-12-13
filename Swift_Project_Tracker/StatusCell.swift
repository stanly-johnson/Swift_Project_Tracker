//
//  StatusCell.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 29/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {
    
    
    @IBOutlet weak var completedSwitch: UISwitch!
    @IBOutlet weak var closedSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
