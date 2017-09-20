//
//  HomeTableViewCell.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 20/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameStatusOfProject: UILabel!
    
    @IBOutlet weak var closedLabel: UILabel!
    
    @IBOutlet weak var completedLabel: UILabel!
   
    @IBOutlet weak var activeLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
