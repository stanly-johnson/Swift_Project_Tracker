//
//  ViewController.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        @IBOutlet var tableView: UITableView!
        var projects: [NSManagedObject] = []
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
        
        
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let project = projects[indexPath.row]
        let cellIdentifier = "HomeTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HomeTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProjectTableViewCell.")
        }
        
        cell.nameStatusOfProject.text = project.value(forKeyPath: "name") as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            
        case "HomeScreenDetail":
            guard let selectedViewController = segue.destination as? Add_New_Project else {
                fatalError("Unexpected Destination; \(segue.destination)")
            }
            
            guard let selectedTableCell = sender as? HomeTableViewCell else {
                fatalError("Unexpected sender -- table cell \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTableCell) else {
                fatalError("The selected cell is not in table")
            }
            let project = projects[indexPath.row]
            selectedViewController.editMode = true
            selectedViewController.viewMode = true
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
