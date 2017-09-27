//
//  ProjectScreenTableViewController.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 20/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import CoreData
import os.log

class ProjectScreenTableViewController: UITableViewController {
    
    
    @IBOutlet weak var buttonAddNewProject: UIBarButtonItem!
    //var projects: [NSManagedObject] = []
    let items = ["General","People","Sechdule","Cost","Status"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Projects"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ProjectTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProjectTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProjectTableViewCell.")
        }
        
        let names = items[indexPath.row]
        cell.nameLabel.text = names;
        return cell
    }
    
    
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //data.remove(at: indexPath.row)
        
        /*
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let index = indexPath.row
        
        if editingStyle == .delete {
            managedObjectContext.delete(people[indexPath.row])
            people.remove(at: index)
            
            do {
                try managedObjectContext.save()
                self.tableView.reloadData()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } */
        
    }
    
    
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        
//        switch(segue.identifier ?? "") {
//            
//        case "AddItem":
//            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
//            
//            
//        case "ShowItem":
//            guard let Add_New_Project = segue.destination as? Add_New_Project else {
//                fatalError("Unexpected destination: \(segue.destination)")
//            }
//            
//            guard let selectedMealCell = sender as? ProjectTableViewCell else {
//                fatalError("Unexpected sender: \(sender)")
//            }
//            
//            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//            
//            let selectedMeal = data[indexPath.row]
//            //destinationViewController.nameOfProject.text = selectedMeal
//            
//            
//        default:
//            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
//            
//
//
//            }
    

  //  }
    

}
