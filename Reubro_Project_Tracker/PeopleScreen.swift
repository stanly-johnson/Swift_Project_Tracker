//
//  PeopleScreen.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import CoreData
import os.log

class PeopleScreen: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var buttonAddNewPerson: UIBarButtonItem!
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "People"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PScell") //people screen cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            people = try managedContext.fetch(fetchRequest)
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cellIdentifier = "PeopleTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PeopleTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProjectTableViewCell.")
        }
        
        cell.peopleNameLabel.text = person.value(forKeyPath: "name") as? String
        //print(person.value(forKeyPath: "name") as? String)
        //cell.textLabel?.text = person.value(forKeyPath: "rate") as? String
        return cell
        
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let index = indexPath.row
        
        if editingStyle == .delete {
            managedObjectContext.delete(people[indexPath.row])
            people.remove(at: index)
            
            do {
                try managedObjectContext.save()
                self.tableView.reloadData()
                
            }
            
            catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "addPeopleDetail":
            os_log("Adding a new person", log: OSLog.default, type: .debug)
            
        case "showPeopleDetail":
            guard let selectedViewController = segue.destination as? Add_New_Person else {
                fatalError("Unexpected Destination; \(segue.destination)")
            }
            
            guard let selectedTableCell = sender as? PeopleTableViewCell else {
                fatalError("Unexpected sender -- table cell \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTableCell) else {
                fatalError("The selected cell is not in table")
            }
            let person = people[indexPath.row]
            selectedViewController.editMode = true
            selectedViewController.incomingName = person.value(forKeyPath: "name") as? String
            selectedViewController.incomingDesg = person.value(forKeyPath: "desg") as? String
            selectedViewController.incomingRate = person.value(forKeyPath: "rate") as? String
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    
}
