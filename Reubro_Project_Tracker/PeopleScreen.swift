//
//  PeopleScreen.swift
//  Reubro_Project_Tracker
//
//  Created by reubro on 19/09/17.
//  Copyright © 2017 Reubro. All rights reserved.
//

import UIKit
import CoreData

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
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = people[indexPath.row]
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PScell", for: indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        print(person.value(forKeyPath: "name") as? String)
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
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    
    
    @IBAction func actionAddNewPerson(_ sender: Any) {
        
        let addPersonAlert = UIAlertController(title: "New Person", message: "Add a new person", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                      style: .default) {
                                        [unowned self] action in
                                        
                                        guard let firsttextField = addPersonAlert.textFields?[0],
                                            let nameToSave = firsttextField.text else {
                                                return
                                        }
                                        
                                        
                                        guard let secondtextField = addPersonAlert.textFields?[1],
                                            let rate = secondtextField.text else {
                                                return
                                        }
                                        
                                        //storing the data to coredata
                                        
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        
                                        let context = appDelegate.persistentContainer.viewContext
                                        
                                        let entity =
                                            NSEntityDescription.entity(forEntityName: "Person",
                                                                       in: context)!
                                        
                                        let person = NSManagedObject(entity: entity,
                                                                     insertInto: context)
                                        
                                        person.setValue(nameToSave, forKeyPath: "name")
                                        person.setValue(rate, forKeyPath: "rate")
                                        
                                        do
                                        {
                                            try context.save()
                                            self.people.append(person)
                                            print("saved")
                                        }
                                            
                                        catch let error as NSError {
                                            print("Could not fetch. \(error), \(error.userInfo)")
                                        }
                                        
                                        self.tableView.reloadData()
        
       }
    
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        addPersonAlert.addTextField()
        addPersonAlert.addTextField()
        addPersonAlert.textFields?[0].placeholder = "Name"
        addPersonAlert.textFields?[1].placeholder = "Rate/hr"
        addPersonAlert.addAction(saveAction)
        addPersonAlert.addAction(cancelAction)
        present(addPersonAlert, animated: true)
        
    }
    
    
    
}
