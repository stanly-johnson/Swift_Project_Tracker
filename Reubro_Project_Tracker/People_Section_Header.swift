//
//  People_Section_Header.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 27/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class People_Section_Header: UITableViewCell {
    
    
    @IBOutlet weak var peopleLabel: UILabel!

    @IBOutlet weak var buttonAddNewPerson: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
