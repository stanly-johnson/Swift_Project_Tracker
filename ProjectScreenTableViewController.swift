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

    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "NewProjectSegue":
            os_log("Adding a new project", log: OSLog.default, type: .debug)
            
            
        case "ShowProjectDetail":
            guard let selectedViewController = segue.destination as? Add_New_Project else {
                fatalError("Unexpected Destination; \(segue.destination)")
            }
            
            guard let selectedTableCell = sender as? ProjectTableViewCell else {
                fatalError("Unexpected sender -- table cell \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTableCell) else {
                fatalError("The selected cell is not in table")
            }
            let project = projects[indexPath.row]
            selectedViewController.editMode = true
            newProject.projectName = (project.value(forKeyPath: "name") as? String)!
            newProject.clientName = (project.value(forKeyPath: "client") as? String)!
            newProject.time.start_date = (project.value(forKeyPath: "startDate") as? String)!
            newProject.time.end_date = (project.value(forKeyPath: "endDate") as? String)!
            newProject.time.hours_project = (project.value(forKeyPath: "hours") as? String)!
            newProject.closed = (project.value(forKeyPath: "closed") as? Bool)!
            newProject.completed = (project.value(forKeyPath: "completed") as? Bool)!
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
            


            }
    

    }
    

}
