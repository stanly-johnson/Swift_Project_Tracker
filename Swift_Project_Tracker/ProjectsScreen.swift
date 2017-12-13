//
//  ProjectsScreen.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit

class ProjectsScreen: UIViewController {
    
    //MARK : Properties
    var meals = [ProjectsScreen]()
   
    
    private func loadSampleMeals() {
        
        guard let meal1 = ProjectsScreen(name: "Caprese Salad") else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = ProjectsScreen(name: "Chicken and Potatoes") else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = ProjectsScreen(name: "Pasta with Meatballs") else {
            fatalError("Unable to instantiate meal2")
        }
        

        
    }
    
    
}
