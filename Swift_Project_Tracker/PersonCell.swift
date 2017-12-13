//
//  PersonCell.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 29/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var moduleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
