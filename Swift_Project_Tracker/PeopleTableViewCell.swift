//
//  PeopleTableViewCell.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 22/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet weak var peopleNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
