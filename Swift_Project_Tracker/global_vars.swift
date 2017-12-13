//
//  global_vars.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 05/10/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import Foundation

struct sechdule {
    var start_date = String()
    var end_date = String()
    var hours_project = String()
}

struct projectDetails {
    var projectName = String()
    var clientName = String()
    var time = sechdule()
    var est_cost : String = "0"
    var total_cost : String = "0"
    var completed : Bool = false
    var closed : Bool = false
    
}

var newProject = projectDetails()
