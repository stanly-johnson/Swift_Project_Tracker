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
    var projects: [NSManagedObject] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        title = "Projects"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Project")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            projects = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let project = projects[indexPath.row]
        let cellIdentifier = "ProjectTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProjectTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProjectTableViewCell.")
        }
        
        cell.nameLabel.text = project.value(forKeyPath: "name") as? String
        
        return cell
    }
    
    
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let index = indexPath.row
        
        if editingStyle == .delete {
            managedObjectContext.delete(projects[indexPath.row])
            projects.remove(at: index)
            
            do {
                try managedObjectContext.save()
                self.tableView.reloadData()
                
            }
                
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
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
